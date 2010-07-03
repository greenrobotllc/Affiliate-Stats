//
//  NeverblueYesterdayHelper.m
//  AffiliateStats
//
//  Created by Andy Triboletti on 9/11/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "NeverblueYesterdayHelper.h"
#import "DetailViewController.h";

@implementation NeverblueYesterdayHelper


@synthesize theEmail;
@synthesize thePassword;
@synthesize data;
@synthesize stats;
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
	
	
	
	
	
	NSURLConnection *currentConnection;
	
	
	
	
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
	//todo check for status>success</status> neccessary?
	
	
	//connect to get this reportJob
	//todo check on the status of the job first, run in a loop in background until it's done
	
	//http://neverblueads.com/reports/?reportJob=934c29fb86c3c681d209f0394f98146cb3b6c6&format=csv
	
	
	
	NSString *newString = [@"https://neverblueads.com/reports/?format=xml&reportJob=" stringByAppendingString:reportJob];
	NSMutableURLRequest *request;
	
	request = [[NSMutableURLRequest alloc] init ];  
	[request setURL:[NSURL URLWithString:newString]];  
	
	[request setHTTPMethod:@"GET"];  
	
	
	//ANDYHERE
	NeverblueYesterdaySecondHelper *neverblueYesterdaySecondHelper = [[NeverblueYesterdaySecondHelper alloc] init];   
	[neverblueYesterdaySecondHelper setTheEmail:theEmail];
	[neverblueYesterdaySecondHelper setThePassword:thePassword];
	[neverblueYesterdaySecondHelper setStats:stats];
	
	//currentConnection = [ZWURLConnection connectionWithRequest:request email:email password:password delegate:self];
	
	currentConnection = [[NSURLConnection alloc] initWithRequest:request delegate:neverblueYesterdaySecondHelper];
	data = nil;

	
	
	
		
	
	
	
	
}
@end
