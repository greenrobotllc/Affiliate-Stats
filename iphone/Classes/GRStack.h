//
//  GRStack.h
//  flutter
//
//  Created by Adam Markey on 6/26/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GRStack : NSObject {
	NSMutableArray *array;
}

- (void)push:(id)object;
- (id)pop;
- (id)top;
- (void)clear;
- (NSUInteger)count;

@end
