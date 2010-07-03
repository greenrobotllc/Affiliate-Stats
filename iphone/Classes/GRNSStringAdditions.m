//
//  GRNSStringAdditions.m
//  EVSuperNova
//
//  Created by Adam Markey on 11/17/08.
//  Copyright 2008 GreenRobot LLC. All rights reserved.
//

#import "GRNSStringAdditions.h"


@implementation NSString (UUID)
+ (NSString*) stringWithNewUUID
{
	//create a new UUID
	CFUUIDRef	uuidObj = CFUUIDCreate(nil);
	//get the string representation of the UUID
	NSString	*newUUID = (NSString*)CFUUIDCreateString(nil, uuidObj);
	CFRelease(uuidObj);
	return [newUUID autorelease];
}
@end
