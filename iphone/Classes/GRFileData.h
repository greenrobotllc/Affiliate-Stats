//
//  GRFileData.h
//  flutter
//
//  Created by Adam Markey on 6/20/08.
//  Copyright 2008 GreenRobot LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GRFileData : NSObject {
	NSString *filename;
	NSString *mime;
	NSData *data;
}

@property (nonatomic, retain) NSString *filename;
@property (nonatomic, retain) NSData *data;
@property (nonatomic, retain) NSString *mime;

@end
