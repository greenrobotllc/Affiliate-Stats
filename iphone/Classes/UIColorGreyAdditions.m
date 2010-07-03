//
//  UIColorGreyAdditions.m
//  flutter
//
//  Created by Adam Markey on 7/1/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "UIColorGreyAdditions.h"


@implementation UIColor (GreyAdditions)
	
+ (UIColor *)darkGreyColor {
	return [self darkGrayColor];
}

+ (UIColor *)lightGreyColor {
	return [self lightGrayColor];
}

+ (UIColor *)greyColor {
	return [self grayColor];
}
	
@end
