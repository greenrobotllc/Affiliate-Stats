//
//  MaxbountyDailyHelper.m
//  AffiliateStats
//
//  Created by Andy Triboletti on 10/20/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "MaxbountyDailyHelper.h"


@implementation MaxbountyDailyHelper
@synthesize monthlyStats;
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
	
	NSArray *nameParts = [aStr componentsSeparatedByString:@"<getTodayStatsReturn"];
	
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
	
	
	
	MaxbountyYesterdayHelper *maxbountyYesterdayHelper = [[MaxbountyYesterdayHelper alloc] init];   
	[maxbountyYesterdayHelper setDailyStats:[runningCount stringValue]];
	[maxbountyYesterdayHelper setMonthlyStats:monthlyStats];
	[maxbountyYesterdayHelper setTheKey:theKey];
	
	NSMutableURLRequest *request;
	
	NSURLConnection *currentConnection2;
	
	request = [[NSMutableURLRequest alloc] init ];  
	[request setURL:[NSURL URLWithString:@"https://www.maxbounty.com/api/api.cfc?wsdl"]];  
	
	NSString * post = @"<SOAP-ENV:Envelope SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\"><SOAP-ENV:Body><ns6727:getYesterdayStats xmlns:ns6727=\"http://tempuri.org\"><keyStr xsi:type=\"xsd:string\">";
	
	post = [post stringByAppendingString:theKey];
	
	post = [post stringByAppendingString:@"</keyStr><offerId>0</offerId>"];
	post = [post stringByAppendingString:@"</ns6727:getYesterdayStats>"];
	post = [post stringByAppendingString:@"</SOAP-ENV:Body></SOAP-ENV:Envelope>"];
	
	NSData *postData = [post dataUsingEncoding:  NSUTF8StringEncoding];
	
	[request setHTTPMethod:@"POST"];
	[request setValue:@"text/xml charset=ISO-8859-1" forHTTPHeaderField:@"Content-Type"];
	[request setValue:@"" forHTTPHeaderField:@"SOAPAction"];
	[request setHTTPBody: postData];
	
	currentConnection2 = [[NSURLConnection alloc] initWithRequest:request delegate:maxbountyYesterdayHelper];
	
	
	
	
}

@end
