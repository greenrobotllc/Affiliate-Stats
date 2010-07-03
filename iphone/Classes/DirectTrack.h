//
//  DirectTrack.h
//  AffiliateStats
//
//  Created by Andy Triboletti on 8/25/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AffiliateStatsAppDelegate.h";
#import "RootViewController.h";
#import "DirectTrackYesterdayHelper.h"


@interface DirectTrack : NSURLConnection {
    NSMutableData *data;
    NSString *theName;
    NSURLResponse *response;
	NSString * addCode;
	NSString * url;
	NSString * password;
	NSString * client;
}
- (void)getStats:(NSString *)aUrl client:(NSString *)aClient addCode:(NSString *)aAddCode password:(NSString *)aPassword networkName:(NSString *)aNetworkName;

@property (nonatomic, retain) NSMutableData *data;
@property (nonatomic, retain) NSString *theName;
@property (nonatomic, retain) NSString *addCode;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *client;
@property (nonatomic, retain) NSURLResponse *response;

@end
