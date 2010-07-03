//
//  DirectTrack.m
//  AffiliateStats
//
//  Created by Andy Triboletti on 8/25/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "DirectTrack.h"
#import "DetailViewController.h";


@implementation DirectTrack

@synthesize data;
@synthesize response;
@synthesize theName;
@synthesize addCode;
@synthesize url;
@synthesize password;
@synthesize client;



- (void)getStats:(NSString *)aUrl client:(NSString *)aClient addCode:(NSString *)aAddCode password:(NSString *)aPassword networkName:(NSString *)aNetworkName

{

	[self setTheName:aNetworkName];
	[self setAddCode:aAddCode];
	[self setUrl:aUrl];
	[self setClient:aClient];
	[self setPassword:aPassword];
	data = nil;
	//url, addcode, password
	
	NSMutableURLRequest *request;
	
	NSURLConnection *currentConnection;
	
	request = [[NSMutableURLRequest alloc] init ];  
	[request setURL:[NSURL URLWithString:url]];  
	
	
	NSString * post = @"<soapenv:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:soap='http://soapinterop.org/'><soapenv:Header/>'<soapenv:Body><soap:dailyStatsInfo soapenv:encodingStyle='http://schemas.xmlsoap.org/soap/encoding/'><client xsi:type='xsd:string'>";
	
	
	post = [post stringByAppendingString:client];
	
	post = [post stringByAppendingString:@"</client><add_code xsi:type='xsd:string'>"];
	
	post = [post stringByAppendingString:aAddCode];
	post = [post stringByAppendingString:@"</add_code><password xsi:type='xsd:string'>"];
	post = [post stringByAppendingString:password];
	post = [post stringByAppendingString:@"</password></soap:dailyStatsInfo ></soapenv:Body></soapenv:Envelope>"];
	
	
	
	NSData *postData = [post dataUsingEncoding:  NSUTF8StringEncoding];
	
	[request setHTTPMethod:@"POST"];
	[request setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody: postData];
	
	
	
	currentConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];


		
}




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
	
	NSString *firstString = [parts objectAtIndex:0];
	
	if([firstString rangeOfString:@"Invalid Login"].location == NSNotFound){
		//NSLog(@"my_substring not found in absoluteURL %@", firstString);
	}
	else {
		NSLog(@"invalid!");
		NSString *invalidTitle =[theName stringByAppendingString:@": Invalid Login"];

		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:invalidTitle message:@"Check your network login and password in Settings.app, and make sure the network has enabled webservices for your account."  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alert show];	
		[alert release];
		
	}
	
	
	NSNumber *networkTotalMonth = [NSNumber numberWithFloat:0.0];
	
	NSNumber *networkTotalToday = [NSNumber numberWithFloat:0.0];
	NSNumber *networkTotalYesterday = [NSNumber numberWithFloat:0.0];
	
	NSArray *parts2;
	NSNumber *dailyTotal =[NSNumber numberWithFloat:0.0];
	//NSNumber *dailyTotalTemp =[NSNumber numberWithFloat:0.0];
	NSArray *dailyTotalTemp;
	
	//NSCharacterSet *commaSet = [NSCharacterSet characterSetWithCharactersInString:@","];
	
	NSMutableString *firstCol =[[NSMutableString alloc] initWithString:@""];
	//NSLog(@"size of daily parts array directrack");
	NSMutableString *theMonth = nil;
	NSMutableString *theYear = nil;
	NSString *theYearTemp = nil;
	NSArray *theYearTempTemp = nil;
	NSString * dailyTotalStringFormatted = nil;
	NSString * dailyTotalStringFormatted2 = nil;
	int sizeOfDailyArray = [parts count];
	int loopCount = 0;
	//if its the last row it's todays total, if it's next to last it's yesterdays
	
	float networkTotalMonthF = 0.0;
	
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
			NSString *theDate = [parts2 objectAtIndex:1];
			NSArray *theDateTemp = [(NSString *)theDate  componentsSeparatedByString:@"-"];
			theMonth = [theDateTemp objectAtIndex:1];
			
			theYearTemp = [theDateTemp objectAtIndex:0];
			theYearTempTemp = [theYearTemp componentsSeparatedByString:@"&amp;gt;"];
			theYear = [theYearTempTemp objectAtIndex:1];
			
			dailyTotal = [parts2 objectAtIndex:15];		 //commission&amp;gt; 33.30
			dailyTotalTemp =[(NSString *)dailyTotal  componentsSeparatedByString:@"&amp;gt; "];
			dailyTotal = [(NSArray *)dailyTotalTemp objectAtIndex:1];			
			
			NSDate *today = [NSDate date];
			NSString *todayString = [today description];
			NSArray *todayArray = [(NSString *)todayString  componentsSeparatedByString:@" "];
			NSString *todayA = [todayArray objectAtIndex:0];
			NSString *receivedDate = [parts2 objectAtIndex:1];
			NSArray *receivedDateArray = [(NSString *)receivedDate  componentsSeparatedByString:@";gt;"];
			NSString *receivedA = [receivedDateArray objectAtIndex:1];
			
			
			dailyTotalStringFormatted = [(NSString*)dailyTotal stringByReplacingOccurrencesOfString:@" " withString:@""];
			dailyTotalStringFormatted2 = [(NSString*)dailyTotalStringFormatted stringByReplacingOccurrencesOfString:@"," withString:@""];
			
			if([receivedA isEqualToString:todayA]) {
				networkTotalToday =[ NSNumber numberWithFloat:[dailyTotalStringFormatted2 floatValue]];
			}
			else {
				NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:-24*60*60];
				NSString *yesterdayString = [yesterday description];
				NSArray *yesterdayArray = [(NSString *)yesterdayString  componentsSeparatedByString:@" "];
				NSString *yesterdayA = [yesterdayArray objectAtIndex:0];


				if([receivedA isEqualToString:yesterdayA]) {
					networkTotalYesterday = [ NSNumber numberWithFloat:[dailyTotalStringFormatted2 floatValue]];
					networkTotalToday =[ NSNumber numberWithFloat:0.0];

				}
				else {
					networkTotalToday =[ NSNumber numberWithFloat:0.0];
				}

			}
			
			networkTotalMonthF = [networkTotalMonth floatValue] + [dailyTotalStringFormatted2 floatValue];
			networkTotalMonth =[ NSNumber numberWithFloat: networkTotalMonthF];
			//NSLog(@"networkTotalMonth  is %@", networkTotalMonth);
	}
		else if(loopCount == sizeOfDailyArray -1) {
			//NSLog(@"it's the second to last row");
			
			dailyTotal = [parts2 objectAtIndex:15];		
			dailyTotalTemp =[(NSString *)dailyTotal  componentsSeparatedByString:@"&amp;gt; "];
			dailyTotal = [dailyTotalTemp objectAtIndex:1];
			
			dailyTotalStringFormatted = [(NSString*)dailyTotal stringByReplacingOccurrencesOfString:@" " withString:@""];
			dailyTotalStringFormatted2 = [(NSString*)dailyTotalStringFormatted stringByReplacingOccurrencesOfString:@"," withString:@""];
			
			
			NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:-24*60*60];
			NSString *yesterdayString = [yesterday description];
			NSArray *yesterdayArray = [(NSString *)yesterdayString  componentsSeparatedByString:@" "];
			NSString *yesterdayA = [yesterdayArray objectAtIndex:0];
			
			NSString *receivedDate = [parts2 objectAtIndex:1];
			NSArray *receivedDateArray = [(NSString *)receivedDate  componentsSeparatedByString:@";gt;"];
			NSString *receivedA = [receivedDateArray objectAtIndex:1];
			
			
			if([receivedA isEqualToString:yesterdayA]) {
				networkTotalYesterday = [ NSNumber numberWithFloat:[dailyTotalStringFormatted2 floatValue]];
			}
			else {
				networkTotalYesterday =[ NSNumber numberWithFloat:0.0];
			}
			
			networkTotalMonthF = [networkTotalMonth floatValue] + [dailyTotalStringFormatted2 floatValue];
			networkTotalMonth =[ NSNumber numberWithFloat: networkTotalMonthF];
		
		}		
		else {

			dailyTotal = [parts2 objectAtIndex:15];		 //commission&amp;gt; 33.30
			dailyTotalTemp =[(NSString *)dailyTotal  componentsSeparatedByString:@"&amp;gt; "];
			dailyTotal = [dailyTotalTemp objectAtIndex:1];
						
			dailyTotalStringFormatted = [(NSString*)dailyTotal stringByReplacingOccurrencesOfString:@" " withString:@""];
			dailyTotalStringFormatted2 = [(NSString*)dailyTotalStringFormatted stringByReplacingOccurrencesOfString:@"," withString:@""];

			networkTotalMonthF = [networkTotalMonth floatValue] + [dailyTotalStringFormatted2 floatValue];
			networkTotalMonth =[ NSNumber numberWithFloat: networkTotalMonthF];
			//NSLog(@"networkTotalMonth  is %@", networkTotalMonth);
			
		}
		
	}
	
	NSString *monthString = [[networkTotalMonth stringValue] retain];
	
	//THCalendarInfo * calInfo = [THCalendarInfo calendarInfo];
	
	
	// class methods
	//NSLog(@"+currentHour: %i", [THCalendarInfo currentHour]);
	//NSLog(@"+currentMinute: %i", [THCalendarInfo currentMinute]);
	//NSLog(@"+currentSecond: %i", [THCalendarInfo currentSecond]);
	//NSLog(@"+currentAbsoluteTime: %i", [THCalendarInfo currentAbsoluteTime]);
	
	
	//NSDate *today = [NSDate date];
	
	//if its first day of month connect to get yesterdays stats
	// < 2
	if(sizeOfDailyArray < 3 && theMonth) {
		
		
		NSString *previousMonth = nil;
		
		if([theMonth intValue] == 1) {
		//if(true) {
			previousMonth = @"12";
			//need to reset the year back by one too in this case
			int theYearInt = [theYear intValue];
			theYearInt = theYearInt -1;
			theYear = [ NSString stringWithFormat: @"%d", theYearInt ];
			
		}
		else if([theMonth intValue] == 2) {
			previousMonth = @"01";
		}
		else if([theMonth intValue] == 3) {
			previousMonth = @"02";
		}
		else if([theMonth intValue] == 4) {
			previousMonth = @"03";
		}
		else if([theMonth intValue] == 5) {
			previousMonth = @"04";
		}
		else if([theMonth intValue] == 6) {
			previousMonth = @"05";
		}
		else if([theMonth intValue] == 7) {
			previousMonth = @"06";
		}
		else if([theMonth intValue] == 8) {
			previousMonth = @"07";
		}
		else if([theMonth intValue] == 9) {
			previousMonth = @"08";
		}
		else if([theMonth intValue] == 10) {
			previousMonth = @"09";
		}
		else if([theMonth intValue] == 11) {
			previousMonth = @"10";
		}
		else if([theMonth intValue] == 12) {
			previousMonth = @"11";
		}
		
		NSMutableURLRequest *request;
		
		NSURLConnection *currentConnection;
		
		request = [[NSMutableURLRequest alloc] init ];  
		[request setURL:[NSURL URLWithString:url]];  

		
		NSMutableString *start_date = theYear;
		start_date = (NSMutableString *)[start_date stringByAppendingString:@"-"];
		start_date = (NSMutableString *)[start_date stringByAppendingString:previousMonth];
		start_date = (NSMutableString *)[start_date stringByAppendingString:@"-27"];
		
		NSMutableString *end_date = theYear;
		end_date = (NSMutableString *)[end_date stringByAppendingString:@"-"];
		end_date = (NSMutableString *)[end_date stringByAppendingString:previousMonth];
		end_date = (NSMutableString *)[end_date stringByAppendingString:@"-31"];
	
		
		//NSMutableString *start_date = @"2008-09-01";
		
		//NSMutableString *end_date = @"2008-09-01";


		
		
		//NSString *end_date = @"2008-04-31";
		
		NSString * post = @"<soapenv:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:soap='http://soapinterop.org/'><soapenv:Header/>'<soapenv:Body><soap:dailyStatsInfo soapenv:encodingStyle='http://schemas.xmlsoap.org/soap/encoding/'><client xsi:type='xsd:string'>";
		
		
		post = [post stringByAppendingString:client];
		
		post = [post stringByAppendingString:@"</client><add_code xsi:type='xsd:string'>"];
		
		post = [post stringByAppendingString:addCode];
		post = [post stringByAppendingString:@"</add_code><password xsi:type='xsd:string'>"];
		post = [post stringByAppendingString:password];
		
		
		post = [post stringByAppendingString:@"</password><start_date xsi:type='xsd:string'>"];
		post = [post stringByAppendingString:start_date];
		
		post = [post stringByAppendingString:@"</start_date><end_date xsi:type='xsd:string'>"];
		post = [post stringByAppendingString:end_date];
		
		
		post = [post stringByAppendingString:@"</end_date></soap:dailyStatsInfo ></soapenv:Body></soapenv:Envelope>"];
		
		
		
		NSData *postData = [post dataUsingEncoding:  NSUTF8StringEncoding];
		
		//AffiliateStatsAppDelegate *appDelegate = (AffiliateStatsAppDelegate *)[[UIApplication sharedApplication] delegate];
		[request setHTTPMethod:@"POST"];
		[request setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
		[request setHTTPBody: postData];
		
		//NSHTTPURLResponse *response = nil;
		CFAbsoluteTime time = CFAbsoluteTimeGetCurrent();

		DirectTrackYesterdayHelper *directTrackYesterdayHelper = [[DirectTrackYesterdayHelper alloc] init];   
		//[directTrackYesterdayHelper setStats
		// [NSMutableArray arrayWithObjects: networkTotalToday,  monthString, nil]];
		NSMutableArray *theArray = [NSMutableArray arrayWithObjects: networkTotalToday, networkTotalYesterday,  monthString,  [[NSNumber numberWithInt:time] stringValue], theName,  nil];
		[directTrackYesterdayHelper setStats: theArray];
		
		currentConnection = [[NSURLConnection alloc] initWithRequest:request delegate:directTrackYesterdayHelper];
		
		
		
	}
	else {
		CFAbsoluteTime time = CFAbsoluteTimeGetCurrent();
		//return [NSArray arrayWithObjects: networkTotalToday, networkTotalYesterday,  monthString, [[NSNumber numberWithInt:time] stringValue], nil];
		NSMutableArray *theArray = [NSMutableArray arrayWithObjects: networkTotalToday, networkTotalYesterday,  monthString,  [[NSNumber numberWithInt:time] stringValue], theName,  nil];
		
		AffiliateStatsAppDelegate *appController = (AffiliateStatsAppDelegate *)[[UIApplication sharedApplication] delegate];
		
		RootViewController *aRootViewController = (RootViewController*)[appController rootViewController];
		
		DetailViewController* aDetailViewController = [aRootViewController detailViewController];
		
		data = nil;
		[aDetailViewController reloadWithStats:theArray];
		
	}
	

	

}

@end
