//
//  NeverblueYesterdayHelper.h
//  AffiliateStats
//
//  Created by Andy Triboletti on 9/11/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AffiliateStatsAppDelegate.h";
#import "RootViewController.h";
#import "NeverblueYesterdaySecondHelper.h"

@interface NeverblueYesterdayHelper : NSURLConnection {
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

