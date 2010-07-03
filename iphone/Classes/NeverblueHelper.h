//
//  NeverblueHelper.h
//  AffiliateStats
//
//  Created by Andy Triboletti on 9/4/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AffiliateStatsAppDelegate.h";
#import "RootViewController.h";
//#import "DetailViewController.h";
#import "NeverblueHelper.h"



@interface NeverblueHelper : NSURLConnection  {
	NSString * theEmail;
    NSMutableData *data;
	NSString * thePassword;
	NSString * theReportJob;
    NSURLResponse *response;
}

@property (nonatomic, retain) NSString *thePassword;
@property (nonatomic, retain) NSString *theEmail;
@property (nonatomic, retain) NSString *theReportJob;
@property (nonatomic, retain) NSMutableData *data;
@property (nonatomic, retain) NSURLResponse *response;
@end

