//
//  HitPath.m
//  AffiliateStats
//
//  Created by Andy Triboletti on 5/27/09.
//  Copyright 2009 GreenRobot LLC. All rights reserved.
//

#import "HitPath.h"
#import "AffiliateStatsAppDelegate.h"
#import "GRDownloadManager.h"

@implementation HitPath


- (void) getStats:(NSString*)networkClientCode2 key:(NSString*)networkApiKey url:(NSString*)networkUrl2 {
	NSString *reportType = @"test"; //@"sales";
	//NSString *start = @"test"; //@"1-21-2008
	NSDate *lastmonth = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60 * 31) ]; //get date 31 days ago - should handle today, yesterday, and this month 
	NSString *lastmonthString = [lastmonth description];
	NSArray *parts = [lastmonthString componentsSeparatedByString:@" "];
	NSString *firstpartMonth = [parts objectAtIndex:0];

	
	//NSString *end = @"test"; //@"1-21-2008 5-1-2009
	NSString *url = @"http://reporting.c2mclicks.com/api.php?type=%@&key=%@&start=%@&format=csv&nozip=1";
	AffiliateStatsAppDelegate *appController = (AffiliateStatsAppDelegate *)[[UIApplication sharedApplication] delegate];

	NSString *gString = [[NSString alloc] initWithFormat:url, reportType, networkApiKey, firstpartMonth];
	[[appController downMan] get:gString delegate:self callback:@selector(gotReportData:)];	
	[gString release]; gString = nil;

}
/*
- (void)getStats:(NSString *)aUrl apiKey:(NSString *)key networkName:(NSString *)aNetworkName {


}*/



-(void)gotReportData:(GRDownloader *)downloader {
	if (downloader == nil) {
		//error?
		//NSLog(@"getNearbyLand: download failed - nil");
	}
	else if([downloader error] == nil) {	
		//NSString *string = [NSString stringWithCString:(const char*)[[downloader data] bytes] length:[[downloader data] length]];
		
		//NSLog(string);
		//NSArray *parts = [string componentsSeparatedByString:@"\n"];

		//split by \n
		
		//split by comma
		//NSMutableArray *j = [string JSONValue]; 
		
		
		//AppDelegate *appController = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		//[appController hideActivityViewer];
		
		//[self setJsonArray:j];
		
		//[tableView reloadData];
		
		
	}
	else {
		//NSLog(@"PlanetViewController: download failed - %@", [[downloader error] description]);			
	}			
	
}




@end
