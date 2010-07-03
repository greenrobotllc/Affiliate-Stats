//
//  NeverblueYesterdaySecondHelper.m
//  AffiliateStats
//
//  Created by Andy Triboletti on 9/11/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "NeverblueYesterdaySecondHelper.h"
#import "DetailViewController.h"


@implementation NeverblueYesterdaySecondHelper


@synthesize theEmail;
@synthesize thePassword;
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
	NSLog(@"did receive ERROR");
    //running = NO;
    //error = [anError retain];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSString *aStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	data = nil;
 
 
 //NSCharacterSet *newlineCharacterSet = [NSCharacterSet newlineCharacterSet];
 //NSArray *parts = [stringResponse2 componentsSeparatedByCharactersInSet:newlineCharacterSet];
 NSArray *parts = [aStr componentsSeparatedByString:@"<row>"];
 //int count = [parts count];
 
 NSNumber *neverblueTotalMonth = [NSNumber numberWithFloat:0.0];
 
 NSNumber *neverblueTotalToday = [NSNumber numberWithFloat:0.0];
 //NSNumber *neverblueTotalYesterday = [NSNumber numberWithFloat:0.0];
 
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
 
 
 
 }		
 else {
 
 
 }
 
 }
 
 
 [stats replaceObjectAtIndex: 1 withObject: dailyTotal];
 
 
 //NSMutableArray *theArray = [NSMutableArray arrayWithObjects: neverblueTotalToday, neverblueTotalYesterday,  monthString,  [[NSNumber numberWithInt:time] stringValue], @"NeverblueAds", nil];
 //*/
//return [NSArray arrayWithObjects: @"0.0", @"0.0",  @"0.0",  @"0.0", nil];

AffiliateStatsAppDelegate *appController = (AffiliateStatsAppDelegate *)[[UIApplication sharedApplication] delegate];

RootViewController *aRootViewController = (RootViewController*)[appController rootViewController];

DetailViewController* aDetailViewController = (DetailViewController*)[aRootViewController detailViewController];

data = nil;

[aDetailViewController reloadWithStats:stats];

}

@end
