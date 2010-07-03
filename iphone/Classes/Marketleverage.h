//
//  Marketleverage.h
//  SimpleDrillDown
//
//  Created by Andy Triboletti on 7/8/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AffiliateStatsAppDelegate.h";
#import "ZWURLConnection.h";


@interface Marketleverage : NSObject {
}

//+(NSArray *)getStats;
+ (NSArray *)getStats:(NSString *)url client:(NSString *)client addcode:(NSString *)addcode password:(NSString *)password;

@end
