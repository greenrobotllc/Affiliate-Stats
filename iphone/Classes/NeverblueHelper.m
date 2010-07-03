//
//  NeverblueHelper.m
//  AffiliateStats
//
//  Created by Andy Triboletti on 9/4/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "NeverblueHelper.h"
#import "NeverblueYesterdayHelper.h"
#import "DetailViewController.h"


@implementation NeverblueHelper



@synthesize theEmail;

@synthesize thePassword;
@synthesize theReportJob;
@synthesize data;
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
	NSLog(@"did receive ERROR");
    //running = NO;
    //error = [anError retain];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	
	//NSLog(@"did FINISH");
	
	NSString *aStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	data = nil;
	//NSLog(aStr);
	

	if ([aStr rangeOfString:@"The requested report is not complete."].location == NSNotFound) {
		NSLog(@"string does not contain bla");
	
	
	
	//NSCharacterSet *newlineCharacterSet = [NSCharacterSet newlineCharacterSet];
	//NSArray *parts = [stringResponse2 componentsSeparatedByCharactersInSet:newlineCharacterSet];
	NSArray *parts = [aStr componentsSeparatedByString:@"<row>"];
	//int count = [parts count];
	
	NSNumber *neverblueTotalMonth = [NSNumber numberWithFloat:0.0];
	
	NSNumber *neverblueTotalToday = [NSNumber numberWithFloat:0.0];
	NSNumber *neverblueTotalYesterday = [NSNumber numberWithFloat:0.0];
	
	NSArray *parts2;
	NSNumber *dailyTotal =[NSNumber numberWithFloat:0.0];
	//NSNumber *dailyTotalTemp =[NSNumber numberWithFloat:0.0];
	NSArray *dailyTotalTemp; // =[NSNumber numberWithFloat:0.0];
	
	//NSCharacterSet *commaSet = [NSCharacterSet characterSetWithCharactersInString:@","];
	
	NSMutableString *firstCol =[[NSMutableString alloc] initWithString:@""];
	//NSLog(@"before sizeOfDaily");
	
	int sizeOfDailyArray = [parts count];
	//NSLog(@"AFTER sizeOfDaily");
	
	int loopCount = 0;
	//if its the last row it's todays total, if it's next to last it's yesterdays
	
	float neverblueTotalMonthF = 0.0;
	
	for(NSString *ii in parts) {
		loopCount++;
		//NSLog(@"componentsSeparatedByString before");
		//parts2 = [ii componentsSeparatedByCharactersInSet:commaSet];
		parts2 =[ii  componentsSeparatedByString:@"<cell>"];
		//NSLog(@"componentsSeparatedByString AFTER");
		
		firstCol = [parts2 objectAtIndex:0];
		//if( [firstCol isEqualToString:@"Date"]) {
		if(loopCount == 1) {
		//	NSLog(@"it's the first row");
		}
		else if(loopCount == sizeOfDailyArray) {
			//NSLog(@"it's the last row");
			
			dailyTotal = [parts2 objectAtIndex:6];		
			dailyTotalTemp =[(NSString *)dailyTotal  componentsSeparatedByString:@"</cell>"];
			dailyTotal = [dailyTotalTemp objectAtIndex:0];
			//NSLog(@"daily total today is %", dailyTotal);
			//NSLog(dailyTotal);
			neverblueTotalToday = dailyTotal;
			neverblueTotalMonthF = [neverblueTotalMonth floatValue] + [dailyTotal floatValue];
			neverblueTotalMonth =[ NSNumber numberWithFloat: neverblueTotalMonthF];
		}
		else if(loopCount == sizeOfDailyArray -1) {
			//NSLog(@"it's the second to last row");
			
			dailyTotal = [parts2 objectAtIndex:6];		
			dailyTotalTemp =[(NSString *)dailyTotal  componentsSeparatedByString:@"</cell>"];
			dailyTotal = [dailyTotalTemp objectAtIndex:0];
			//NSLog(@"daily total yesterday is");
			//NSLog([dailyTotal stringValue]);
			
			neverblueTotalYesterday = dailyTotal;
			neverblueTotalMonthF = [neverblueTotalMonth floatValue] + [dailyTotal floatValue];
			neverblueTotalMonth =[ NSNumber numberWithFloat: neverblueTotalMonthF];
			
		}		
		else {
			dailyTotal = [parts2 objectAtIndex:6];		
			dailyTotalTemp =[(NSString*)dailyTotal  componentsSeparatedByString:@"</cell>"];
			dailyTotal = [dailyTotalTemp objectAtIndex:0];
			//NSLog(@"daily total is %", dailyTotal);
			//NSLog(dailyTotal);
			neverblueTotalMonthF = [neverblueTotalMonth floatValue] + [dailyTotal floatValue];
			neverblueTotalMonth =[ NSNumber numberWithFloat: neverblueTotalMonthF];
			
		}
		
	}
	
	NSString *monthString = [[neverblueTotalMonth stringValue] retain];
	//NSString *todayString = [[neverblueTotalToday stringValue] retain];
	//NSString *yesterdayString = [[neverblueTotalYesterday stringValue] retain];
	
	
	
	CFAbsoluteTime time = CFAbsoluteTimeGetCurrent();
	
	
	NSLog(@"in neverbluehelper");
	//if its first day of month connect to get yesterdays stats
	// < 3
	if(sizeOfDailyArray < 3 ) {
		
		NSMutableURLRequest *request;
		NSURLConnection *currentConnection;

		request = [[NSMutableURLRequest alloc] init ];  
		NSString * nbString = @"https://";
		
		nbString = [nbString stringByAppendingString:@"@neverblueads.com/service/aff/v1/rest/reportSchedule?type=date&relativeDate=last_month"];
		
		
		
		
		
		[request setURL:[NSURL URLWithString:nbString]];  
		
		[request setHTTPMethod:@"GET"];  
		
		//currentConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
		
		
		
		
		//NSHTTPURLResponse *response = nil;
		
		NeverblueYesterdayHelper *neverblueYesterdayHelper = [[NeverblueYesterdayHelper alloc] init];   
		//[directTrackYesterdayHelper setStats
		// [NSMutableArray arrayWithObjects: networkTotalToday,  monthString, nil]];
		NSMutableArray *theArray = [NSMutableArray arrayWithObjects: neverblueTotalToday, neverblueTotalYesterday,  monthString,  [[NSNumber numberWithInt:time] stringValue], @"NeverblueAds", nil];
		[neverblueYesterdayHelper setStats: theArray];
		[neverblueYesterdayHelper setTheEmail: theEmail];
		[neverblueYesterdayHelper setThePassword: thePassword];

		NeverblueYesterdaySecondHelper *neverblueYesterdaySecondHelper = [[NeverblueYesterdaySecondHelper alloc] init];   
		
		[neverblueYesterdaySecondHelper setStats: theArray];

		currentConnection = [[NSURLConnection alloc] initWithRequest:request delegate:neverblueYesterdayHelper];
		
		
		
	}
	else {
		
	
		//return [NSArray arrayWithObjects:neverblueTotalToday, neverblueTotalYesterday, neverblueTotalMonth, @"07/08/08", nil];
		//return [NSArray arrayWithObjects: monthString, monthString,  monthString, @"07/08/08", nil];
		NSMutableArray *theArray = [NSMutableArray arrayWithObjects: neverblueTotalToday, neverblueTotalYesterday,  monthString,  [[NSNumber numberWithInt:time] stringValue], @"NeverblueAds", nil];
		//*/
		//return [NSArray arrayWithObjects: @"0.0", @"0.0",  @"0.0",  @"0.0", nil];
	
		AffiliateStatsAppDelegate *appController = (AffiliateStatsAppDelegate *)[[UIApplication sharedApplication] delegate];

		RootViewController *aRootViewController = (RootViewController*)[appController rootViewController];
	
		DetailViewController* aDetailViewController = [aRootViewController detailViewController];

		data = nil;

		[aDetailViewController reloadWithStats:theArray];
	}

		
		
	} else {
		NSLog(@"it's not done yet");
	
	
	
	
		
		
		
		NSString *newString = [@"https://neverblueads.com/reports/?format=xml&reportJob=" stringByAppendingString:theReportJob];
		NSMutableURLRequest *request;
		
		request = [[NSMutableURLRequest alloc] init ];  
		[request setURL:[NSURL URLWithString:newString]];  
		
		[request setHTTPMethod:@"GET"];  
		
		
		NSURLConnection *currentConnection;

		NeverblueHelper *neverblueHelper = [[NeverblueHelper alloc] init];   
		[neverblueHelper setTheEmail:theEmail];
		[neverblueHelper setThePassword:thePassword];
		[neverblueHelper setTheReportJob:theReportJob];
		
		currentConnection = [[NSURLConnection alloc] initWithRequest:request delegate:neverblueHelper];
		data = nil;

	
	
	}
	
	
	
}



	
@end
