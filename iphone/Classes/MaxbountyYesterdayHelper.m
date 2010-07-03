//
//  MaxbountyYesterdayHelper.m
//  AffiliateStats
//
//  Created by Andy Triboletti on 10/20/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "MaxbountyYesterdayHelper.h"
#import "DetailViewController.h";

@class AffiliateStatsAppDelegate;
@class RootViewController;


@implementation MaxbountyYesterdayHelper
@synthesize monthlyStats;
@synthesize dailyStats;
@synthesize theEmail;
@synthesize thePassword;
@synthesize data;
@synthesize response;
@synthesize theKey;

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)aResponse
{
    response = [aResponse retain];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)someData
{
	if (data == nil) 
        data = [[NSMutableData alloc] init];
    [data appendData:someData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)anError
{
	NSLog(@"did receive ERROR");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSString *aStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	data = nil;
	
	NSArray *nameParts = [aStr componentsSeparatedByString:@"<getYesterdayStatsReturn"];
	
	int loopCount = 0;
	NSDecimalNumber * runningCount= [NSDecimalNumber zero];
	
	for(NSString *ii in nameParts) {
		loopCount++;
		//NSLog(ii);
		if(loopCount != 0 && loopCount != 1 && loopCount != 2) {
			
			NSArray *earningsPart = [ii componentsSeparatedByString:@"EARNINGS"];
			
			NSString * earningsString = [earningsPart objectAtIndex:1];
			
			NSArray *earningsPart2 = [earningsString componentsSeparatedByString:@"<value xsi:type=\"soapenc:string\">"];
			NSString *earningsString2 = [earningsPart2 objectAtIndex:1];
			NSArray *earningsPart3 = [earningsString2 componentsSeparatedByString:@"</value>"];
			
			
			NSString *earningsPart4 = [earningsPart3 objectAtIndex:0];
			
			NSString * earningsNoDollarSign = [(NSString*)earningsPart4 stringByReplacingOccurrencesOfString:@"$" withString:@""];
			NSString * earningsNoCommas = [(NSString*)earningsNoDollarSign stringByReplacingOccurrencesOfString:@"," withString:@""];
			
			runningCount = [runningCount decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:earningsNoCommas]];
			
			
		}
		
	}
	
	
	
	//NSLog(@"done");
	
	CFAbsoluteTime time = CFAbsoluteTimeGetCurrent();
	
	NSMutableArray *theArray = [NSMutableArray arrayWithObjects:dailyStats, [runningCount stringValue], monthlyStats, [[NSNumber numberWithInt:time] stringValue], @"Maxbounty", nil];
	
	AffiliateStatsAppDelegate *appController = (AffiliateStatsAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	RootViewController *aRootViewController = (RootViewController*)[appController rootViewController];
	
	DetailViewController* aDetailViewController = (DetailViewController*)[aRootViewController detailViewController];
	
	data = nil;
	
	[aDetailViewController reloadWithStats:theArray];
	
	
	
	
}

@end