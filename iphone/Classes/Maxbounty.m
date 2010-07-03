//
//  Maxbounty.m
//  SimpleDrillDown
//
//  Created by Andy Triboletti on 7/8/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Maxbounty.h"


@implementation Maxbounty


@synthesize theEmail;

@synthesize thePassword;
@synthesize data;
@synthesize response;

- (void)getStats:(NSString *)email password:(NSString *)password
{
	data = nil;
	[self setTheEmail:email];
	[self setThePassword:password];
	
	NSMutableURLRequest *request;
	NSURLConnection *currentConnection;
	
	request = [[NSMutableURLRequest alloc] init ];  
	[request setURL:[NSURL URLWithString:@"https://www.maxbounty.com/api/api.cfc?wsdl"]];  
		
	NSString * post = @"<SOAP-ENV:Envelope SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\"><SOAP-ENV:Body><ns6727:getKey xmlns:ns6727=\"http://tempuri.org\"><user xsi:type=\"xsd:string\">";
	post = [post stringByAppendingString:email];
	post = [post stringByAppendingString:@"</user><password xsi:type=\"xsd:string\">"];
	post = [post stringByAppendingString:password];
	post = [post stringByAppendingString:@"</password></ns6727:getKey></SOAP-ENV:Body></SOAP-ENV:Envelope>"];

	NSData *postData = [post dataUsingEncoding:  NSUTF8StringEncoding];
	[request setHTTPMethod:@"POST"];
	[request setValue:@"text/xml charset=ISO-8859-1" forHTTPHeaderField:@"Content-Type"];
	[request setValue:@"" forHTTPHeaderField:@"SOAPAction"];
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
	
	
}

- (void)dealloc {

	[super dealloc];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)anError
{
	NSLog(@"did receive ERROR");

}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	
	NSString *aStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	
	if([aStr rangeOfString:@"<getKeyReturn xsi:type=\"xsd:string\"></getKeyReturn>"].location == NSNotFound){
		//NSLog(@"my_substring not found in absoluteURL %@", firstString);
	}
	else {
		NSLog(@"invalid!");
		NSString *theName = @"Maxbounty";
		NSString *invalidTitle =[theName stringByAppendingString:@": Invalid Login"];
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:invalidTitle message:@"Check your network login and password in Settings.app, and make sure the network has enabled webservices for your account."  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alert show];	
		[alert release];
		
	}
	NSArray *nameParts = [aStr componentsSeparatedByString:@"<getKeyReturn xsi:type=\"xsd:string\">"];
	
	NSString *newString = [nameParts objectAtIndex:1];
	
	[aStr release];
	 
	NSArray *nameParts2 = [newString componentsSeparatedByString:@"</getKeyReturn>"];
	
	NSString *key = [nameParts2 objectAtIndex:0];	

	MaxbountyHelper *maxbountyHelper = [[MaxbountyHelper alloc] init];   
	[maxbountyHelper setTheKey:key];

	NSMutableURLRequest *request;
	
	NSURLConnection *currentConnection2;
	
	request = [[NSMutableURLRequest alloc] init ];  
	[request setURL:[NSURL URLWithString:@"https://www.maxbounty.com/api/api.cfc?wsdl"]];  
	
	NSString * post = @"<SOAP-ENV:Envelope SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\"><SOAP-ENV:Body><ns6727:getMonthToDateStats xmlns:ns6727=\"http://tempuri.org\"><keyStr xsi:type=\"xsd:string\">";

	post = [post stringByAppendingString:key];
	
	post = [post stringByAppendingString:@"</keyStr><offerId>0</offerId>"];
	post = [post stringByAppendingString:@"</ns6727:getMonthToDateStats>"];
	post = [post stringByAppendingString:@"</SOAP-ENV:Body></SOAP-ENV:Envelope>"];

	NSData *postData = [post dataUsingEncoding:  NSUTF8StringEncoding];
	
	[request setHTTPMethod:@"POST"];
	[request setValue:@"text/xml charset=ISO-8859-1" forHTTPHeaderField:@"Content-Type"];
	[request setValue:@"" forHTTPHeaderField:@"SOAPAction"];
	[request setHTTPBody: postData];

	currentConnection2 = [[NSURLConnection alloc] initWithRequest:request delegate:maxbountyHelper];

}
@end

