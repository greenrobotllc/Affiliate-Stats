//
//  GRStack.m
//  flutter
//
//  Created by Adam Markey on 6/26/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "GRStack.h"


@implementation GRStack

- (id)init {
	if ((self = [super init])) {
		array = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)push:(id)anObject {
	[array addObject:anObject];
}

- (id)pop {
	id anObject = [array lastObject];
	[array removeLastObject];
	return anObject;
}

- (id)top {
	return [array lastObject];
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
