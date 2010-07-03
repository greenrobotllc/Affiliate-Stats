//
//  GRDownloaderDelegateEntry.m
//  Repentance
//
//  Created by Adam Markey on 1/20/09.
//  Copyright 2009 GreenRobot LLC. All rights reserved.
//

#import "GRDownloaderDelegateEntry.h"


@implementation GRDownloaderDelegateEntry

@synthesize delegate;
@synthesize callback;

- (id)init {
	if ((self = [super init])) {
	}
	
	return self;
}

- (void)cancel {
	[delegate performSelector:@selector(cancel)];
}

- (void)dealloc {
	if (delegate != nil)
		[delegate release];

	[super dealloc];
}

@end
