//
//  GRCircularBuffer.h
//  LOLCats
//
//  Created by Adam Markey on 8/5/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GRCircularBuffer : NSObject {
	NSMutableArray *buffer;
	NSInteger readPos;
	NSInteger maxLen;
}

- (id)initWithMaxLen:(NSInteger)len;

- (void)clear;
- (NSInteger)count;

- (void)insertNextObject:(id)object;
- (void)insertPreviousObject:(id)object;

- (void)makeObjectsPerformSelector:(SEL)aSelector withObject:(id)anObject;
- (void)makeObjectsPerformSelector:(SEL)aSelector;

//does not affect read pointer
- (id)objectAtRelativeOffset:(NSInteger)offset;

@property (nonatomic, assign) NSInteger maxLen;
@property (nonatomic, readonly) id next;
@property (nonatomic, readonly) id current;
@property (nonatomic, readonly) id prev;

@property (nonatomic, readonly) id first;
@property (nonatomic, readonly) id last;

//allow the user to see where the read pointer is in the buffer
@property (nonatomic, readonly) NSInteger readPos;

@end
