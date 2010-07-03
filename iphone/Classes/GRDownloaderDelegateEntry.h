//
//  GRDownloaderDelegateEntry.h
//  Repentance
//
//  Created by Adam Markey on 1/20/09.
//  Copyright 2009 GreenRobot LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GRDownloaderDelegateEntry : NSObject {
	NSObject *delegate;
	SEL callback;
}

@property (nonatomic, retain) NSObject *delegate;
@property (nonatomic, assign) SEL callback;

- (void)cancel;

@end
