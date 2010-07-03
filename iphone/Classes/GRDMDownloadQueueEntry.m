//
//  GRDMDownloadQueueEntry.m
//  LOLCats
//
//  Created by Adam Markey on 8/6/08.
//  Copyright 2008 GreenRobot LLC. All rights reserved.
//

#import "GRDMDownloadQueueEntry.h"


@implementation GRDMDownloadQueueEntry

@synthesize url;
@synthesize delegate;
@synthesize callback;
@synthesize post;
@synthesize formDict;

- (id)init {
	if ((self = [super init])) {
	}
	
	return self;
}

- (void)dealloc {
	if (url != nil)
		[url release];
	if (delegate != nil)
		[delegate release];
	if (formDict != nil)
		[formDict release];
	[super dealloc];
}

@end
