//
//  GRDownloadManager.h
//  LOLCats
//
//  Created by Adam Markey on 8/6/08.
//  Copyright 2008 GreenRobot LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRDownloader.h"
#import "Reachability.h"

@class GRQueue;

@interface GRDownloadManager : NSObject <GRDownloaderDelegate> {
	NSInteger maxConcurrentConnections;
	NSMutableDictionary *downloaderToDelegateDict;
	GRQueue *queue;
	
	//for internet connectivity checking
	NetworkStatus internetConnectionStatus;
	BOOL userHasBeenAlerted;
	NSTimer *connectionHarassmentTimer;
	NetworkStatus requiredNetworkAvailability;
}

- (BOOL)get:(NSString *)aURL delegate:(NSObject<GRDownloaderDelegate>*)delegate;
- (BOOL)post:(NSString *)aURL withForm:(NSDictionary *)formDict delegate:(NSObject<GRDownloaderDelegate>*)delegate;
- (BOOL)get:(NSString *)aURL delegate:(NSObject*)delegate callback:(SEL)callback;
- (BOOL)post:(NSString *)aURL withForm:(NSDictionary *)formDict delegate:(NSObject*)delegate callback:(SEL)callback;;
- (void)cancelAllDownloads;

//intended for internal use only
- (void)startNextDownload;
- (BOOL)promptForNetworkConnectivity;
- (void)resetUserConnectionAlert;

@property (nonatomic, readonly) NSInteger activeConnections;
@property (nonatomic, assign) NSInteger maxConcurrentConnections;
@property (nonatomic, assign) NetworkStatus requiredNetworkAvailability;

@end
