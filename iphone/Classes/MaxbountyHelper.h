//
//  MaxbountyHelper.h
//  AffiliateStats
//
//  Created by Andy Triboletti on 10/17/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaxbountyDailyHelper.h";


@interface MaxbountyHelper : NSURLConnection  {
	NSString * theEmail;
    NSMutableData *data;
	NSString * thePassword;
	NSString *theKey;
    NSURLResponse *response;
}

@property (nonatomic, retain) NSString *thePassword;
@property (nonatomic, retain) NSString *theEmail;
@property (nonatomic, retain) NSString *theKey;
@property (nonatomic, retain) NSMutableData *data;
@property (nonatomic, retain) NSURLResponse *response;

@end

