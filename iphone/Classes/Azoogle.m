//
//  Azoogle.m
//  AffiliateStats
//
//  Created by Andy Triboletti on 8/25/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//



#import "Azoogle.h"


@implementation Azoogle


@synthesize theAccountid;
@synthesize theUsername;
@synthesize thePassword;
@synthesize data;
@synthesize response;

- (void)getStats:(NSString *)accountid username:(NSString *)username password:(NSString *)password
{
	data = nil;
	[self setTheAccountid:accountid];
	[self setTheUsername:username];
	[self setThePassword:password];
	
	NSMutableURLRequest *request;
	NSURLConnection *currentConnection;
	
	request = [[NSMutableURLRequest alloc] init ];  
	//[request setURL:[NSURL URLWithString:@"https://home.azoogleads.com/soap/azads2_server.php?wsdl"]];  
	[request setURL:[NSURL URLWithString:@"https://login.azoogleads.com/soap/azads2_server.php"]];  
	
	
	
	//NSString * post = @"<SOAP-ENV:Envelope SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\"><SOAP-ENV:Body><ns6727:getKey xmlns:ns6727=\"http://tempuri.org\"><user xsi:type=\"xsd:string\">";
	NSString * post = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:azads2_server\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><SOAP-ENV:Body><ns1:authenticate><affiliate_id xsi:type=\"xsd:integer\">";
	
	post = [post stringByAppendingString:accountid];
	post = [post stringByAppendingString:@"</affiliate_id><login xsi:type=\"xsd:string\">"];
	post = [post stringByAppendingString:username];
	post = [post stringByAppendingString:@"</login><password xsi:type=\"xsd:string\">"];
	post = [post stringByAppendingString:password];
	post = [post stringByAppendingString:@"</password></ns1:authenticate></SOAP-ENV:Body></SOAP-ENV:Envelope>"];
	NSLog(post);
	
	NSData *postData = [post dataUsingEncoding:  NSUTF8StringEncoding];
	[request setHTTPMethod:@"POST"];
	[request setValue:@"PHP-SOAP/5.3.2" forHTTPHeaderField:@"User-Agent"];
	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[request setValue:@"urn:azads2_server#authenticate" forHTTPHeaderField:@"SOAPAction"];
	[request setHTTPBody: postData];
	currentConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	//NSLog([request getHttp
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

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
	return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
		//if ([trustedHosts containsObject:challenge.protectionSpace.host])
			[challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
	
	[challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)anError
{
	NSLog(@"did receive ERROR");
	
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	
	NSString *aStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	NSLog(aStr);

	
	
	if([aStr rangeOfString:@"<login_hash xsi:type=\"xsd:string\">"].location == NSNotFound){
		//NSLog(@"my_substring not found in absoluteURL %@", firstString);
		NSLog(@"invalid!");
		NSString *theName = @"Azoogle";
		NSString *invalidTitle =[theName stringByAppendingString:@": Invalid Login"];
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:invalidTitle message:@"Check your network affiliate id, login, and password, and make sure the network has enabled webservices for your account."  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alert show];	
		[alert release];
	
	}
	else {

		

	NSArray *nameParts = [aStr componentsSeparatedByString:@"<login_hash xsi:type=\"xsd:string\">"];
	
	NSString *newString = [nameParts objectAtIndex:1];
	
	[aStr release];
	
	NSArray *nameParts2 = [newString componentsSeparatedByString:@"</login_hash>"];
	
	NSString *key = [nameParts2 objectAtIndex:0];	
	
	NSLog(key);

	
	
	
	
	
	
	
	
		NSDate *today = [NSDate date];
		NSString *todayString = [today description];
		NSArray *todayArray = [(NSString *)todayString  componentsSeparatedByString:@" "];
		NSString *todayA = [todayArray objectAtIndex:0];
		
	
	
		AzoogleHelper *helper = [[AzoogleHelper alloc] init];   
		[helper setTheKey:key];
		
		NSMutableURLRequest *request;
		
		NSURLConnection *currentConnection2;
		
		request = [[NSMutableURLRequest alloc] init ];  
		[request setURL:[NSURL URLWithString:@"https://login.azoogleads.com/soap/azads2_server.php"]];  
		
		NSString * post = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:azads2_server\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><SOAP-ENV:Body><ns1:leadTotals><login_hash xsi:type=\"xsd:string\">";

		post = [post stringByAppendingString:key];
		
		post = [post stringByAppendingString:@"</login_hash><affiliate_id xsi:type=\"xsd:integer\">"];
		
		post = [post stringByAppendingString:theAccountid];

		
		post = [post stringByAppendingString:@"</affiliate_id><offer_id xsi:type=\"xsd:string\">7052</offer_id><start_date xsi:type=\"xsd:string\">2010-06-01</start_date><end_date xsi:type=\"xsd:string\">"];
		post = [post stringByAppendingString:todayA];
		post = [post stringByAppendingString:@"</end_date><sales_only xsi:type=\"xsd:boolean\">true</sales_only>"];
	
		post = [post stringByAppendingString:@"</ns1:leadTotals></SOAP-ENV:Body></SOAP-ENV:Envelope>"];
		NSLog(post);
		NSData *postData = [post dataUsingEncoding:  NSUTF8StringEncoding];
		
		[request setHTTPMethod:@"POST"];
		[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
		[request setValue:@"urn:azads2_server#leadTotals" forHTTPHeaderField:@"SOAPAction"];
		[request setHTTPBody: postData];
		
		currentConnection2 = [[NSURLConnection alloc] initWithRequest:request delegate:helper];
		

		
	
	
	}
}
@end

