//
//  GRCircularBuffer.m
//  LOLCats
//
//  Created by Adam Markey on 8/5/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "GRCircularBuffer.h"


@implementation GRCircularBuffer

@dynamic maxLen;
@dynamic next;
@dynamic current;
@dynamic prev;
@dynamic first;
@dynamic last;
@synthesize readPos;

- (id)init {
	if ((self = [super init])) {
		buffer = [[NSMutableArray alloc] init];
		maxLen = 0;
	}
	return self;
}

- (id)initWithMaxLen:(NSInteger)len {
	if ((self = [super init])) {
		buffer = [[NSMutableArray alloc] init];
		maxLen = len;
	}
	return self;
}

- (void)dealloc {
	if (buffer != nil)
		[buffer release];
	[super dealloc];
}

- (void)clear {
	[buffer removeAllObjects];
	readPos = 0;
}

- (NSInteger)count {
	return [buffer count];
}

//inserts an object at the end of the buffer
//and if necessary removes one from the beginning
- (void)insertNextObject:(id)object {
	[buffer addObject:object];
	if ([buffer count] > maxLen) {
		[buffer removeObjectAtIndex:0];
		if (readPos != 0)
			readPos--;
	}
}

//inserts an object at the beginning of the buffer
//and if necessary removes one from the other end
- (void)insertPreviousObject:(id)object {
	[buffer insertObject:object atIndex:0];
	if([buffer count] > maxLen) {
		[buffer removeObjectAtIndex:([buffer count] - 1)];
	}	
	if(readPos != ([buffer count] - 1))
		readPos++;
}

- (NSInteger)maxLen {
	return maxLen;
}

- (void)setMaxLen:(NSInteger)len {
	if (len < maxLen) {
		NSInteger truncateNum = maxLen - len;
		[buffer removeObjectsInRange:NSMakeRange(0, truncateNum)];
		readPos -= truncateNum;
		if (readPos < 0)
			readPos = 0;
	}
	maxLen = len;
}

- (id)objectAtRelativeOffset:(NSInteger)offset {
	if ([buffer count] > 0) {
		NSInteger index = readPos + offset;
		if (index < 0)
			index = 0;
		else if (index >= maxLen)
			index = maxLen - 1;
		return [buffer objectAtIndex:index];
	} else
		return nil;
}

- (id)next {
	if (readPos < (maxLen - 1) && readPos < ([buffer count] - 1))
		return [buffer objectAtIndex:++readPos];
	else
		return nil;
}

- (id)current {
	if ([buffer count] > 0)
		return [buffer objectAtIndex:readPos];
	else
		return nil;
}

- (id)prev {
	if (readPos > 0)
		return [buffer objectAtIndex:--readPos];
	else
		return nil;
}

- (id)first {
	if ([buffer count] > 0)
		return [buffer objectAtIndex:((readPos = 0))];
	else
		return nil;
}

- (id)last {
	if ([buffer count] > 0)
		return [buffer objectAtIndex:((readPos = [buffer count] - 1))];
	else
		return nil;
}

- (void)makeObjectsPerformSelector:(SEL)aSelector {
	[buffer makeObjectsPerformSelector:aSelector];
}

- (void)makeObjectsPerformSelector:(SEL)aSelector withObject:(id)anObject {
	[buffer makeObjectsPerformSelector:aSelector withObject:anObject];
}

@end
