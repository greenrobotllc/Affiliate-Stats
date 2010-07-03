//
//  GRQueue.m
//  LOLCats
//
//  Created by Adam Markey on 8/6/08.
//  Copyright 2008 GreenRobot LLC. All rights reserved.
//

#import "GRQueue.h"


@implementation GRQueue

- (id)init {
	if ((self = [super init])) {
		array = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)enqueue:(id)anObject {
	[array addObject:anObject];
}

- (id)dequeue {
	id anObject;
	if([array count] > 0) {
		anObject = [array objectAtIndex:0];
		[anObject retain];
		[array removeObjectAtIndex:0];
		[anObject autorelease];
	} else {
		anObject = nil;
	}
	return anObject;
}

- (id)peek {
	id anObject;
	if([array count] > 0)
		anObject = [array objectAtIndex:0];
	else
		anObject = nil;
	return anObject;
}

- (void)clear {
	[array removeAllObjects];
}

- (NSUInteger)count {
	return [array count];
}

- (void) dealloc
{
	if (array != nil)
		[array release];
	[super dealloc];
}


@end
