//
//  DirectTrackYesterdayHelper.h
//  AffiliateStats
//
//  Created by Andy Triboletti on 9/9/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AffiliateStatsAppDelegate.h";
#import "RootViewController.h";
#import "DirectTrackYesterdayHelper.h"

@interface DirectTrackYesterdayHelper : NSURLConnection  {
    NSMutableData *data;
    NSMutableArray *stats;
    NSURLResponse *response;
}


@property (nonatomic, retain) NSMutableData *data;
@property (nonatomic, retain) NSMutableArray *stats;
@property (nonatomic, retain) NSURLResponse *response;
@end


