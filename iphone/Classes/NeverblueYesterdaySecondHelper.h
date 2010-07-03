//
//  NeverblueYesterdaySecondHelper.h
//  AffiliateStats
//
//  Created by Andy Triboletti on 9/11/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//


#import "AffiliateStatsAppDelegate.h";
#import "RootViewController.h";
#import "NeverblueHelper.h"
#import "NeverblueYesterdaySecondHelper.h"

@interface NeverblueYesterdaySecondHelper : NSURLConnection {
	NSString * theEmail;
    NSMutableData *data;
    NSMutableArray *stats;
	NSString * thePassword;
    NSURLResponse *response;
}

@property (nonatomic, retain) NSString *thePassword;
@property (nonatomic, retain) NSString *theEmail;
@property (nonatomic, retain) NSMutableData *data;
@property (nonatomic, retain) NSMutableArray *stats;
@property (nonatomic, retain) NSURLResponse *response;
@end

