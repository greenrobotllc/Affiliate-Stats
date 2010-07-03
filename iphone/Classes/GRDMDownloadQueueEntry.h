//
//  GRDMDownloadQueueEntry.h
//  LOLCats
//
//  Created by Adam Markey on 8/6/08.
//  Copyright 2008 GreenRobot LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GRDownloaderDelegate;

@interface GRDMDownloadQueueEntry : NSObject {
	NSString *url;
	NSObject *delegate;
	SEL callback;
	BOOL post;
	NSDictionary *formDict;
}

@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSObject *delegate;
@property (nonatomic, assign) SEL callback;
@property (nonatomic, assign) BOOL post;
@property (nonatomic, retain) NSDictionary *formDict;

@end
