//
//  GRQueue.h
//  LOLCats
//
//  Created by Adam Markey on 8/6/08.
//  Copyright 2008 GreenRobot LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GRQueue : NSObject {
	NSMutableArray *array;
}

- (void)enqueue:(id)object;
- (id)dequeue;
- (id)peek;
- (void)clear;
- (NSUInteger)count;

@end
