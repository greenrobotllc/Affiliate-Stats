//
//  DirectTrackYesterdayHelper.m
//  AffiliateStats
//
//  Created by Andy Triboletti on 9/9/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "DirectTrackYesterdayHelper.h"
#import "DetailViewController.h";


@implementation DirectTrackYesterdayHelper




@synthesize data;
@synthesize stats;
@synthesize response;




-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)aResponse
{
	//NSLog(@"did receive response");
    response = [aResponse retain];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)someData
{
	//NSLog(@"did receive data");
	
	if (data == nil) 
        data = [[NSMutableData alloc] init];
    
    [data appendData:someData];
	
	//if (data == nil) 
	//     data = [[NSMutableData alloc] init];
    
	// [data appendData:someData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)anError
{
	//NSLog(@"did receive ERROR");
    //running = NO;
    //error = [anError retain];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	
	
	NSString *stringResponse =
	[[NSString alloc] initWithData:data
						  encoding:NSUTF8StringEncoding];
	
	
	
	//NSCharacterSet *symbolSet = [NSCharacterSet symbolCharacterSet];
	//NSArray *nameParts = [stringResponse componentsSeparatedByCharactersInSet:symbolSet];
	
	NSArray *parts = [stringResponse componentsSeparatedByString:@"&amp;lt;dailystats&amp;gt;"];
	//int count = [parts count];
	
	//NSNumber *networkTotalMonth = [NSNumber numberWithFloat:0.0];
	
	//NSNumber *networkTotalToday = [NSNumber numberWithFloat:0.0];
	//NSNumber *networkTotalYesterday = [NSNumber numberWithFloat:0.0];
	
	NSArray *parts2;
	NSNumber *dailyTotal =[NSNumber numberWithFloat:0.0];
	//NSNumber *dailyTotalTemp =[NSNumber numberWithFloat:0.0];
	NSArray *dailyTotalTemp;
	
	//NSCharacterSet *commaSet = [NSCharacterSet characterSetWithCharactersInString:@","];
	
	NSMutableString *firstCol =[[NSMutableString alloc] initWithString:@""];
	//NSLog(@"size of daily parts array directrack");
	
	int sizeOfDailyArray = [parts count];
	int loopCount = 0;
	//if its the last row it's todays total, if it's next to last it's yesterdays
	
	//float networkTotalMonthF = 0.0;
	
	for(NSString *ii in parts) {
		loopCount++;
		//NSLog(@"nsstring data");
		//parts2 = [ii componentsSeparatedByCharactersInSet:commaSet];
		parts2 =[ii  componentsSeparatedByString:@"&amp;lt;"];
		
		firstCol = [parts2 objectAtIndex:0];
		//if( [firstCol isEqualToString:@"Date"]) {
		if(loopCount == 1) {
			//NSLog(@"it's the first row");
		}
		else if(loopCount == sizeOfDailyArray) {
			//NSLog(@"it's the last row");

						
			dailyTotal = [parts2 objectAtIndex:15];		 //commission&amp;gt; 33.30
			dailyTotalTemp =[(NSString *)dailyTotal  componentsSeparatedByString:@"&amp;gt; "];
			dailyTotal = [(NSArray *)dailyTotalTemp objectAtIndex:1];			
			
			//NSLog(@"daily total today is");
			//NSLog(@"daily total last row is %@", dailyTotal);
			
			//networkTotalToday = dailyTotal;
			//networkTotalMonthF = [networkTotalMonth floatValue] + [dailyTotal floatValue];
			//networkTotalMonth =[ NSNumber numberWithFloat: networkTotalMonthF];
			//NSLog(@"networkTotalMonth  is %@", networkTotalMonth);
		}
		else if(loopCount == sizeOfDailyArray -1) {
			//NSLog(@"it's the second to last row");

		}		
		else {
	
			
		}
		
	}
	
	
	
	//CFAbsoluteTime time = CFAbsoluteTimeGetCurrent();
	//return [NSArray arrayWithObjects: networkTotalToday, networkTotalYesterday,  monthString, [[NSNumber numberWithInt:time] stringValue], nil];
	//NSMutableArray *theArray = [NSMutableArray arrayWithObjects: networkTotalToday, networkTotalYesterday,  monthString,  [[NSNumber numberWithInt:time] stringValue], theName,  nil];
	
	[stats replaceObjectAtIndex: 1 withObject: dailyTotal];
	
	 
	AffiliateStatsAppDelegate *appController = (AffiliateStatsAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	RootViewController *aRootViewController = (RootViewController*)[appController rootViewController];
	
	DetailViewController* aDetailViewController = [aRootViewController detailViewController];
	
	data = nil;
	[aDetailViewController reloadWithStats:stats];
	
	


}
@end
