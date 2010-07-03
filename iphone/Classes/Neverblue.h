//
//  Neverblue.h
//  SimpleDrillDown
//
//  Created by Andy Triboletti on 7/8/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NeverblueHelper.h";


@interface Neverblue : NSURLConnection  {
	NSString * theEmail;
    NSMutableData *data;
	NSString * thePassword;
	NSString * theReportJob;
    NSURLResponse *response;
}
- (void)getStats:(NSString *)email password:(NSString *)password;

@property (nonatomic, retain) NSString *thePassword;
@property (nonatomic, retain) NSString *theEmail;
@property (nonatomic, retain) NSString *theReportJob;
@property (nonatomic, retain) NSMutableData *data;
@property (nonatomic, retain) NSURLResponse *response;
@end
