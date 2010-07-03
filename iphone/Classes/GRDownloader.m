//
//  Downloader.m
//  CameraTest
//
//  Created by Adam Markey on 5/21/08.
//  Copyright 2008 GreenRobot LLC. All rights reserved.
//

#import "GRDownloader.h"
#import "GRFileData.h"

@implementation GRDownloader

@synthesize data;
@synthesize URL;
@synthesize suggestedFilename;
@synthesize callback;
@synthesize failed;
@synthesize complete;
@synthesize error;

- (void)dealloc
{
	if (connection != nil) {
		[connection cancel];
		[connection release];
	}
	if (URL != nil)
		[URL release];
	if (data != nil)
		[data release];
	if (suggestedFilename != nil)
		[suggestedFilename release];
	[super dealloc];
}

- (id)copyWithZone:(NSZone *)zone {
	return [self retain];
}

- (void)setDelegate:(NSObject*)object
{
	delegate = object;
}

- (NSObject*)delegate
{
	return delegate;
}

- (BOOL)active {
	return (connection != nil);
}

- (void)cancel
{
	if (data != nil) {
		[data release];
		data = nil;
	}
	if (connection != nil) {
		[connection cancel];
		[connection release];
		connection = nil;
	}
}

- (BOOL)get:(NSString *)aURL
{
	if (aURL == nil)
		return NO;
	
	NSURL *u = [NSURL URLWithString:aURL];
	NSURLRequest *request = [NSURLRequest requestWithURL:u];

	if (connection != nil) {
		[connection cancel];
		[connection release];
		connection = nil;
	}
	if (data != nil) {
		[data release];
		data = nil;
	}
	if (URL != nil) {
		[URL release];
		URL = nil;
	}
	
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	if (connection != nil) {
		URL = [aURL retain];
		data = [[NSMutableData data] retain];
		if (data == nil) {
			[URL release];
			URL = nil;
			[connection release];
			connection = nil;
			return NO;
		}
	} else {
		return NO;
	}
	
	return YES;
}

- (BOOL)post:(NSString *)aURL withForm:(NSDictionary *)formDict
{
	if (aURL == nil)
		return NO;

	NSURL *u = [NSURL URLWithString:aURL];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:u];

	NSMutableData *body = [NSMutableData data];
	NSString *boundary = @"--------------34298237429384623";
	NSArray *keys = [formDict allKeys];
	
	if (connection != nil) {
		[connection cancel];
		[connection release];
		connection = nil;
	}
	if (data != nil) {
		[data release];
		data = nil;
	}
	if (URL != nil) {
		[URL release];
		URL = nil;
	}
	
	for (int i = 0; i < [keys count]; i++) {
		NSString *key = [keys objectAtIndex:i];
		if ([key isKindOfClass:[NSString class]]) {
			id element = [formDict valueForKey:[keys objectAtIndex:i]];
			if ([element isKindOfClass:[NSString class]]) {
				NSString *value = element;
				[body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
				[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
				[body appendData:[[NSString stringWithFormat:@"%@\r\n", value] dataUsingEncoding:NSUTF8StringEncoding]];
			} else if ([element isKindOfClass:[GRFileData class]]) {
				GRFileData *fileData = element;
				NSString *filename = [fileData filename];
				NSString *mime = [fileData mime];
				NSData *someData = [fileData data];
				[body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
				[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", key, filename] dataUsingEncoding:NSUTF8StringEncoding]];
				[body appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", mime] dataUsingEncoding:NSUTF8StringEncoding]];
				[body appendData:someData];
				[body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
			} else {
				return NO;
			}
		} else {
			return NO;
		}
	}
	
	[request setHTTPMethod:@"POST"];
	[request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary] forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:body];
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	if (connection != nil) {
		URL = [aURL retain];
		data = [[NSMutableData alloc] initWithLength:0];
		if (data == nil) {
			[URL release];
			URL = nil;
			[connection release];
			connection = nil;
			return NO;
		}
	} else {
		return NO;
	}	
	
	return YES;
}

- (void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)response
{
	[data setLength:0];
	suggestedFilename = [[response suggestedFilename] retain];
}

- (void)connection:(NSURLConnection *)aConnection didReceiveData:(NSData *)aData
{
	[data appendData:aData];
}

- (void)connection:(NSURLConnection *)aConnection didFailWithError:(NSError *)anError
{
	failed = YES;
	complete = NO;
	error = anError;
	
	if (callback && [delegate respondsToSelector:callback])
		[delegate performSelector:callback withObject:self];
	else
		if ([delegate respondsToSelector:@selector(downloadFailed:errorCode:)])
			[(id<GRDownloaderDelegate>)delegate downloadFailed:self errorCode:anError];
	// release the connection, and the data object
	[connection release];
	connection = nil;
	[data release];
	data = nil;
	
	// inform the user
	//NSLog(@"Connection failed! Error - %@ %@", [anError localizedDescription], [[anError userInfo] objectForKey:NSErrorFailingURLStringKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection
{
	failed = NO;
	complete = YES;
	
	[connection release];
	connection = nil;
	if (callback && [delegate respondsToSelector:callback])
		[delegate performSelector:callback withObject:self];
	else
		if ([delegate respondsToSelector:@selector(downloadComplete:)])
			[(id<GRDownloaderDelegate>)delegate downloadComplete:self];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
	return nil;
}

@end
