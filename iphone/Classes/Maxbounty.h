//
//  Maxbounty.h
//  SimpleDrillDown
//
//  Created by Andy Triboletti on 7/8/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaxbountyHelper.h";

@interface Maxbounty : NSURLConnection  {
	NSString * theEmail;
    NSMutableData *data;
	NSString * thePassword;
    NSURLResponse *response;
}
- (void)getStats:(NSString *)email password:(NSString *)password;

@property (nonatomic, retain) NSString *thePassword;
@property (nonatomic, retain) NSString *theEmail;
@property (nonatomic, retain) NSMutableData *data;
@property (nonatomic, retain) NSURLResponse *response;
@end
