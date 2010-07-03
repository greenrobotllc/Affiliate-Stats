//
//  Azoogle.h
//  AffiliateStats
//
//  Created by Andy Triboletti on 8/25/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AzoogleHelper.h";

@interface Azoogle : NSURLConnection  {
	NSString * theUsername;
	NSString * theAccountid;
    NSMutableData *data;
	NSString * thePassword;
    NSURLResponse *response;
}
- (void)getStats:(NSString *)accountid username:(NSString *)username password:(NSString *)password;

@property (nonatomic, retain) NSString *thePassword;
@property (nonatomic, retain) NSString *theAccountid;
@property (nonatomic, retain) NSString *theUsername;
@property (nonatomic, retain) NSMutableData *data;
@property (nonatomic, retain) NSURLResponse *response;
@end
