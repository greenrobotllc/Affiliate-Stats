//
//  GRDownloadManager.m
//  LOLCats
//
//  Created by Adam Markey on 8/6/08.
//  Copyright 2008 GreenRobot LLC. All rights reserved.
//

#import "GRDownloadManager.h"
#import "GRDMDownloadQueueEntry.h"
#import "GRDownloaderDelegateEntry.h"
#import "GRQueue.h"

#define kHARASSMENT_TIMER 60

@implementation GRDownloadManager

@synthesize  maxConcurrentConnections, requiredNetworkAvailability;
@dynamic activeConnections;

- (id)init {
	if ((self = [super init])) {
		downloaderToDelegateDict = [[NSMutableDictionary alloc] init];
		queue = [[GRQueue alloc] init];
		maxConcurrentConnections = 0;
		
		requiredNetworkAvailability = ReachableViaCarrierDataNetwork;  //default to any data
		
//		[[Reachability sharedReachability] setHostName:@"www.greenrobot.com"];
		userHasBeenAlerted = NO;
		[[Reachability sharedReachability] setNetworkStatusNotificationsEnabled:YES];
		
		internetConnectionStatus = [[Reachability sharedReachability] internetConnectionStatus];  //initialize this
		// Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the
		// method "reachabilityChanged" will be called. 
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:@"kNetworkReachabilityChangedNotification" object:nil];
	}
	return self;
}

- (void)reachabilityChanged:(NSNotification *)note
{
	internetConnectionStatus = [[Reachability sharedReachability] internetConnectionStatus];
	
	//report to our app that we've lost the required internet connection
	if(requiredNetworkAvailability == ReachableViaWiFiNetwork && internetConnectionStatus != ReachableViaWiFiNetwork) {
		if([[[UIApplication sharedApplication] delegate] respondsToSelector:@selector(lostRequiredInternetConnection)])
			[[[UIApplication sharedApplication] delegate] performSelector:@selector(lostRequiredInternetConnection)];
	} else if(requiredNetworkAvailability == ReachableViaCarrierDataNetwork && (internetConnectionStatus != ReachableViaCarrierDataNetwork || internetConnectionStatus != ReachableViaWiFiNetwork)) {
		if([[[UIApplication sharedApplication] delegate] respondsToSelector:@selector(lostRequiredInternetConnection)])
			[[[UIApplication sharedApplication] delegate] performSelector:@selector(lostRequiredInternetConnection)];		
	}
}

- (void)dealloc {
	if (downloaderToDelegateDict != nil) {
		[[downloaderToDelegateDict allKeys] makeObjectsPerformSelector:@selector(cancel)];
		[downloaderToDelegateDict release];
	}
	if (queue != nil)
		[queue release];
	[super dealloc];
}

- (void)startIndicator {
	UIApplication *app = [UIApplication sharedApplication];
	[app setNetworkActivityIndicatorVisible:YES];
}

- (void)stopIndicator {
	UIApplication *app = [UIApplication sharedApplication];
	[app setNetworkActivityIndicatorVisible:NO];
}

- (BOOL)get:(NSString *)aURL delegate:(NSObject<GRDownloaderDelegate>*)delegate {
	return [self get:aURL delegate:delegate callback:NULL];
}

- (BOOL)get:(NSString *)aURL delegate:(NSObject*)delegate callback:(SEL)callback {
	BOOL ret = NO;
	
	if ([self activeConnections] <= maxConcurrentConnections) {
		GRDownloader *download = [[GRDownloader alloc] init];
		if (download != nil) {
			BOOL canDownload = [self promptForNetworkConnectivity];
			GRDownloaderDelegateEntry *entry = [[GRDownloaderDelegateEntry alloc] init];
			[entry setDelegate:delegate];
			[entry setCallback:callback];
			[downloaderToDelegateDict setObject:entry forKey:download];
			[entry release];
			[download setDelegate:self];
			
			if(canDownload == YES) {
				ret = [download get:aURL];
			} else {
				[self downloadFailed:download errorCode:[NSError errorWithDomain:@"com.greenrobot" code:1 userInfo:nil]];
			}
			[download release];
		}
	} else {
		GRDMDownloadQueueEntry *entry = [[GRDMDownloadQueueEntry alloc] init];
		[entry setUrl:aURL];
		[entry setDelegate:delegate];
		[entry setCallback:callback];
		[entry setPost:NO];
		[queue enqueue:entry];
		[entry release];
		ret = YES;
	}
	
	if (ret == YES)
		[self startIndicator];
	
	return ret;
}

- (BOOL)post:(NSString *)aURL withForm:(NSDictionary *)formDict delegate:(NSObject<GRDownloaderDelegate>*)delegate {
	return [self post:aURL withForm:formDict delegate:delegate callback:NULL];
}

- (BOOL)post:(NSString *)aURL withForm:(NSDictionary *)formDict delegate:(NSObject*)delegate callback:(SEL)callback {
	BOOL ret = NO;
	
	if ([self activeConnections] <= maxConcurrentConnections) {
		GRDownloader *download = [[GRDownloader alloc] init];
		if (download != nil) {
			BOOL canDownload = [self promptForNetworkConnectivity];
			GRDownloaderDelegateEntry *entry = [[GRDownloaderDelegateEntry alloc] init];
			[entry setDelegate:delegate];
			[entry setCallback:callback];
			[downloaderToDelegateDict setObject:entry forKey:download];
			[entry release];
			[download setDelegate:self];
			
			if(canDownload == YES) {
				ret = [download post:aURL withForm:formDict];
			} else {
				[self downloadFailed:download errorCode:[NSError errorWithDomain:@"com.greenrobot" code:1 userInfo:nil]];
			}
			
			[download release];
		}
	} else {
		GRDMDownloadQueueEntry *entry = [[GRDMDownloadQueueEntry alloc] init];
		[entry setUrl:aURL];
		[entry setDelegate:delegate];
		[entry setCallback:callback];
		[entry setPost:YES];
		[entry setFormDict:formDict];
		[queue enqueue:entry];
		[entry release];
		ret = YES;
	}
	
	if (ret == YES)
		[self startIndicator];
	
	return ret;
}

- (void)cancelAllDownloads {
	[[downloaderToDelegateDict allKeys] makeObjectsPerformSelector:@selector(cancel)];
	[self stopIndicator];
}

- (NSInteger)activeConnections {
	return [downloaderToDelegateDict count];
}

- (void)downloadComplete:(GRDownloader *)downloader {
	GRDownloaderDelegateEntry *target = [downloaderToDelegateDict objectForKey:downloader];
	
	if ([target callback] && [[target delegate] respondsToSelector:[target callback]])
		[[target delegate] performSelector:[target callback] withObject:downloader];
	else
		if ([[target delegate] respondsToSelector:@selector(downloadComplete:)])
			[(NSObject<GRDownloaderDelegate>*)[target delegate] downloadComplete:downloader];
	
	[downloaderToDelegateDict removeObjectForKey:downloader];
	
	[self startNextDownload];
}

- (void)downloadFailed:(GRDownloader *)downloader errorCode:(NSError *)error {
	GRDownloaderDelegateEntry *target = [downloaderToDelegateDict objectForKey:downloader];

	if ([target callback] && [[target delegate] respondsToSelector:[target callback]]) {
		if([[error domain] isEqualToString:@"com.greenrobot"] && [error code] == 1) 
			[[target delegate] performSelector:[target callback] withObject:nil];
		else
			[[target delegate] performSelector:[target callback] withObject:downloader];
	} else {
		if ([[target delegate] respondsToSelector:@selector(downloadFailed:errorCode:)]) {
			if([[error domain] isEqualToString:@"com.greenrobot"] && [error code] == 1) 
				[(NSObject<GRDownloaderDelegate>*)[target delegate] downloadFailed:nil errorCode:error];
			else
				[(NSObject<GRDownloaderDelegate>*)[target delegate] downloadFailed:downloader errorCode:error];
		}
	}

	[downloaderToDelegateDict removeObjectForKey:downloader];
	
	[self startNextDownload];
}

- (void)startNextDownload {
	while ([self activeConnections] <= maxConcurrentConnections && [queue count] > 0) {
		GRDMDownloadQueueEntry *entry = [queue dequeue];
		GRDownloader *download = [[GRDownloader alloc] init];
		if (download != nil) {
			BOOL canDownload = [self promptForNetworkConnectivity];
			GRDownloaderDelegateEntry *delEntry = [[GRDownloaderDelegateEntry alloc] init];
			[delEntry setDelegate:[entry delegate]];
			[delEntry setCallback:[entry callback]];
			[downloaderToDelegateDict setObject:delEntry forKey:download];
			[delEntry release];
			[download setDelegate:self];
			
			if(canDownload == YES) {
				if ([entry post] == NO)
					[download get:[entry url]];
				else
					[download post:[entry url] withForm:[entry formDict]];
			} else {
				[self downloadFailed:download errorCode:[NSError errorWithDomain:@"com.greenrobot" code:1 userInfo:nil]];
			}			
			
			[download release];
		}
	}
	
	if ([self activeConnections] == 0)
		[self stopIndicator];
}

- (void)resetUserConnectionAlert {
	userHasBeenAlerted = NO;
	[connectionHarassmentTimer release];
}

- (BOOL)promptForNetworkConnectivity {
	if(requiredNetworkAvailability == ReachableViaWiFiNetwork) {
		if(internetConnectionStatus != ReachableViaWiFiNetwork) {
			if(internetConnectionStatus == NotReachable) {
				if(userHasBeenAlerted == NO) {
					//UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Internet Connection Required" message:@"You may be in a poor serive area or have a week wireless signal." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
					//[alert show];
					//[alert release];			
					connectionHarassmentTimer = [[NSTimer scheduledTimerWithTimeInterval:kHARASSMENT_TIMER target:self selector:@selector(resetUserConnectionAlert) userInfo:nil repeats:NO] retain];
					userHasBeenAlerted = YES;
				}
				return NO;
			} else {
				if(userHasBeenAlerted == NO) {
					//UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WiFi Connection Required" message:@"For the best multiplayer experience, WiFi is required for this application." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
					//[alert show];
					//[alert release];			
					connectionHarassmentTimer = [[NSTimer scheduledTimerWithTimeInterval:kHARASSMENT_TIMER target:self selector:@selector(resetUserConnectionAlert) userInfo:nil repeats:NO] retain];
					userHasBeenAlerted = YES;
				}
				return NO;
			}
		}
	} else {
		if(internetConnectionStatus == NotReachable) {
			if(userHasBeenAlerted == NO) {
				//UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Internet Connection Required" message:@"You may be in a poor serive area or have a week wireless signal." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
				//[alert show];
				//[alert release];			
				connectionHarassmentTimer = [[NSTimer scheduledTimerWithTimeInterval:kHARASSMENT_TIMER target:self selector:@selector(resetUserConnectionAlert) userInfo:nil repeats:NO] retain];
				userHasBeenAlerted = YES;
			}
			return NO;
		}		
	}
	return YES;
}

@end
