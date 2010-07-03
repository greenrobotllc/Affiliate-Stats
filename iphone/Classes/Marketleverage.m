//
//  Marketleverage.m
//  SimpleDrillDown
//
//  Created by Andy Triboletti on 7/8/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Marketleverage.h"


@implementation Marketleverage
+ (NSArray *)getStats:(NSString *)url client:(NSString *)client addcode:(NSString *)addcode password:(NSString *)password

{
	//url, addcode, password
	
	NSMutableURLRequest *request;
	
	ZWURLConnection *currentConnection;
	
	request = [[NSMutableURLRequest alloc] init ];  
	[request setURL:[NSURL URLWithString:url]];  

	
	NSString * post = @"<soapenv:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:soap='http://soapinterop.org/'><soapenv:Header/>'<soapenv:Body><soap:dailyStatsInfo soapenv:encodingStyle='http://schemas.xmlsoap.org/soap/encoding/'><client xsi:type='xsd:string'>";
	
	
	post = [post stringByAppendingString:client];
	
	post = [post stringByAppendingString:@"</client><add_code xsi:type='xsd:string'>"];

	post = [post stringByAppendingString:addcode];
	post = [post stringByAppendingString:@"</add_code><password xsi:type='xsd:string'>"];
	post = [post stringByAppendingString:password];
	post = [post stringByAppendingString:@"</password></soap:dailyStatsInfo ></soapenv:Body></soapenv:Envelope>"];

	
	
	NSData *postData = [post dataUsingEncoding:  NSUTF8StringEncoding];
	
	AffiliateStatsAppDelegate *appDelegate = (AffiliateStatsAppDelegate *)[[UIApplication sharedApplication] delegate];
	[request setHTTPMethod:@"POST"];
	[request setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody: postData];
		
    NSHTTPURLResponse *response = nil;
	
	
	
	 currentConnection = [ZWURLConnection connectionWithRequest:request];
	while ([currentConnection isRunning]) {
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.2]];
	}
	
	
	NSData *data = [currentConnection data];
	response = [currentConnection response];
	
	NSString *stringResponse =
	[[NSString alloc] initWithData:data
						  encoding:NSUTF8StringEncoding];
	
	

	NSCharacterSet *symbolSet = [NSCharacterSet symbolCharacterSet];
	NSArray *nameParts = [stringResponse componentsSeparatedByCharactersInSet:symbolSet];
	
	NSArray *parts = [stringResponse componentsSeparatedByString:@"&amp;lt;dailystats&amp;gt;"];
	int count = [parts count];
	
	NSNumber *networkTotalMonth = [NSNumber numberWithFloat:0.0];
	
	NSNumber *networkTotalToday = [NSNumber numberWithFloat:0.0];
	NSNumber *networkTotalYesterday = [NSNumber numberWithFloat:0.0];
	
	NSArray *parts2;
	NSNumber *dailyTotal =[NSNumber numberWithFloat:0.0];
	NSNumber *dailyTotalTemp =[NSNumber numberWithFloat:0.0];
	
	NSCharacterSet *commaSet = [NSCharacterSet characterSetWithCharactersInString:@","];
	
	NSMutableString *firstCol =[[NSMutableString alloc] initWithString:@""];
	int sizeOfDailyArray = [parts count];
	int loopCount = 0;
	//if its the last row it's todays total, if it's next to last it's yesterdays
	
	float networkTotalMonthF = 0.0;
	
	for(NSString *ii in parts) {
		loopCount++;
		NSLog(@"nsstring data");
		//parts2 = [ii componentsSeparatedByCharactersInSet:commaSet];
		parts2 =[ii  componentsSeparatedByString:@"&amp;lt;"];
		
		firstCol = [parts2 objectAtIndex:0];
		//if( [firstCol isEqualToString:@"Date"]) {
		if(loopCount == 1) {
			NSLog(@"it's the first row");
		}
		else if(loopCount == sizeOfDailyArray) {
			NSLog(@"it's the last row");
			
			dailyTotal = [parts2 objectAtIndex:15];		 //commission&amp;gt; 33.30
			dailyTotalTemp =[dailyTotal  componentsSeparatedByString:@"&amp;gt; "];
			dailyTotal = [dailyTotalTemp objectAtIndex:1];			NSLog(@"daily total today is");
			NSLog(dailyTotal);
			networkTotalToday = dailyTotal;
			networkTotalMonthF = [networkTotalMonth floatValue] + [dailyTotal floatValue];
			networkTotalMonth =[ NSNumber numberWithFloat: networkTotalMonthF];
		}
		else if(loopCount == sizeOfDailyArray -1) {
			NSLog(@"it's the second to last row");
			
			dailyTotal = [parts2 objectAtIndex:15];		
			dailyTotalTemp =[dailyTotal  componentsSeparatedByString:@"&amp;gt; "];
			dailyTotal = [dailyTotalTemp objectAtIndex:1];
			NSLog(@"daily total yesterday is");
			NSLog(dailyTotal);
			networkTotalYesterday = dailyTotal;
			networkTotalMonthF = [networkTotalMonth floatValue] + [dailyTotal floatValue];
			networkTotalMonth =[ NSNumber numberWithFloat: networkTotalMonthF];
			
		}		
		else {
			dailyTotal = [parts2 objectAtIndex:15];		 //commission&amp;gt; 33.30
			dailyTotalTemp =[dailyTotal  componentsSeparatedByString:@"&amp;gt; "];
			dailyTotal = [dailyTotalTemp objectAtIndex:1];
			NSLog(@"daily total is");
			NSLog(dailyTotal);
			networkTotalMonthF = [networkTotalMonth floatValue] + [dailyTotal floatValue];
			networkTotalMonth =[ NSNumber numberWithFloat: networkTotalMonthF];
			
		}
		
	}
	
	NSString *monthString = [[networkTotalMonth stringValue] retain];

	
	return [NSArray arrayWithObjects: networkTotalToday, networkTotalYesterday,  monthString, @"07/08/08", nil];


}


- (void)downloadComplete:(GRDownloader *)downloader {
	
	NSLog(@"download complete");
	
}

- (void)downloadFailed:(GRDownloader *)downloader errorCode:(NSError *)error {
	
	NSLog(@"download failed");

}



@end
