//
//  Downloader.h
//  CameraTest
//
//  Created by Adam Markey on 5/21/08.
//  Copyright 2008 GreenRobot LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRDownloader;

@protocol GRDownloaderDelegate
- (void)downloadComplete:(GRDownloader *)downloader;
- (void)downloadFailed:(GRDownloader *)downloader errorCode:(NSError *)error;
@end

@interface GRDownloader : NSObject <NSCopying> {
	NSString *URL;
	NSString *suggestedFilename;
	NSMutableData *data;
	NSURLConnection *connection;
	NSObject *delegate;
	SEL callback;
	BOOL failed;
	BOOL complete;
	NSError *error;
}

@property (nonatomic, assign) NSObject *delegate;
@property (nonatomic, assign) SEL callback;
@property (readonly) NSData *data;
@property (readonly) NSString *URL;
@property (readonly) NSString *suggestedFilename;
@property (readonly) BOOL failed;
@property (readonly) BOOL complete;
@property (readonly) NSError *error;

- (BOOL)get:(NSString *)aURL;
- (BOOL)post:(NSString *)aURL withForm:(NSDictionary *)formDict;
- (void)cancel;
- (BOOL)active;

@end
