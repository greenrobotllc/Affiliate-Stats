//
//  AzoogleDailyHelper.h
//  AffiliateStats
//
//  Created by Andy Triboletti on 10/20/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AzoogleYesterdayHelper.h";

@interface AzoogleDailyHelper :NSURLConnection  {
	NSString * monthlyStats;
	NSString * theEmail;
    NSMutableData *data;
	NSString * thePassword;
	NSString *theKey;
    NSURLResponse *response;
}

@property (nonatomic, retain) NSString *monthlyStats;
@property (nonatomic, retain) NSString *thePassword;
@property (nonatomic, retain) NSString *theEmail;
@property (nonatomic, retain) NSString *theKey;
@property (nonatomic, retain) NSMutableData *data;
@property (nonatomic, retain) NSURLResponse *response;

@end

