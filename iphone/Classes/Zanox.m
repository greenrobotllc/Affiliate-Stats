//
//  Zanox.m
//  AffiliateStats
//
//  Created by Andy Triboletti on 10/17/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Zanox.h"


@implementation Zanox

@synthesize theEmail;

@synthesize thePassword;
@synthesize data;
@synthesize response;

-(void)connection:(NSURLConnection *)connection
didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge previousFailureCount] == 0) {
        NSURLCredential *newCredential;
		
		NSString * networkEmailNeverblue = [theEmail stringByReplacingOccurrencesOfString:@"%40" withString:@"@"];
		
		
        newCredential=[NSURLCredential credentialWithUser:networkEmailNeverblue
                                                 password:thePassword
                                              persistence:NSURLCredentialPersistenceNone];
        [[challenge sender] useCredential:newCredential
               forAuthenticationChallenge:challenge];
    } else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
        // inform the user that the user name and password
        // in the preferences are incorrect
        
		//[self showPreferencesCredentialsAreIncorrectPanel:self];
		
	}
}


//+ (NSArray *)getStats:(NSString *)email password:(NSString *)password
- (void)getStats:(NSString *)email password:(NSString *)password
{
	data = nil;
	[self setTheEmail:email];
	[self setThePassword:password];
	//thePassword = password;
	NSMutableURLRequest *request;
	NSURLConnection *currentConnection;
	
	
	request = [[NSMutableURLRequest alloc] init ];  
	NSString * nbString = @"https://";
	
	nbString = [nbString stringByAppendingString:@"@neverblueads.com/service/aff/v1/rest/reportSchedule?type=date&relativeDate=this_month"];
	
	
	
	
	
	[request setURL:[NSURL URLWithString:nbString]];  
	
	[request setHTTPMethod:@"GET"];  
	
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
	//if(currentConnection) {
	//	[currentConnection release];
	//}
	
	[super dealloc];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)anError
{
	NSLog(@"did receive ERROR");
	//NSLog(anError);
    //running = NO;
    //error = [anError retain];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	//NSLog(@"did FINISH");
	
	//NSString *aStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	
	//NSLog(aStr);
	
	//NSURLConnection *currentConnection;
	
	
	/*
	
	NSCharacterSet *symbolSet = [NSCharacterSet symbolCharacterSet];
	NSArray *nameParts = [aStr componentsSeparatedByCharactersInSet:symbolSet];
	
	//NSLog(@"before nameParts count");
	if([nameParts count] < 12) {
		//return [NSArray arrayWithObjects: @"0.0", @"0.0",  @"0.0",  @"0.0", nil];
		NSLog(@"ERROR nameparts < 12");
		
		return;
	}
	
	//NSLog(@"after nameParts count");
	NSString * reportJob = [nameParts objectAtIndex:12];
	
	
	
	//connect to get this reportJob
	//todo check on the status of the job first, run in a loop in background until it's done
	
	//https://neverblueads.com/reports/?reportJob=934c29fb86c3c681d209f0394f98146cb3b6c6&format=csv
	
	
	
	NSString *newString = [@"https://neverblueads.com/reports/?format=xml&reportJob=" stringByAppendingString:reportJob];
	NSMutableURLRequest *request;
	
	request = [[NSMutableURLRequest alloc] init ];  
	[request setURL:[NSURL URLWithString:newString]];  
	
	[request setHTTPMethod:@"GET"];  
	
	
	
	NeverblueHelper *neverblueHelper = [[NeverblueHelper alloc] init];   
	[neverblueHelper setTheEmail:theEmail];
	[neverblueHelper setThePassword:thePassword];
	
	//currentConnection = [ZWURLConnection connectionWithRequest:request email:email password:password delegate:self];
	currentConnection = [[NSURLConnection alloc] initWithRequest:request delegate:neverblueHelper];
	data = nil;
	
	
    //running = NO;
	 */
	
}
@end
