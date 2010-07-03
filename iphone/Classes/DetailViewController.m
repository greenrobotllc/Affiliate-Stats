#import "DetailViewController.h"
#import "azads2_serverSvc.h"

@implementation DetailViewController

@synthesize detailItem;
@synthesize myStats;
@synthesize canRefresh;
@synthesize neverblue;
@synthesize maxbounty;
@synthesize azoogle;
@synthesize offerfusion;
@synthesize hitpath;
@synthesize zanox;
@synthesize directtrack;
@synthesize calculateTotals;
@synthesize db;


- (void)startIndicator {
	UIApplication *app = [UIApplication sharedApplication];
	[app setNetworkActivityIndicatorVisible:YES];
}

- (void)stopIndicator {
	UIApplication *app = [UIApplication sharedApplication];
	[app setNetworkActivityIndicatorVisible:NO];
}


-(NSArray *) getEnabledNetworks {
	CFStringRef networkKey; 
	CFBooleanRef networkOn;
	
	NSMutableArray *enabledNetworks = [[NSMutableArray alloc] init];

	
	
	

		
	//AZOOGLE 
	networkKey = CFSTR("azoogleEnabled");
	networkOn;
	networkOn = (CFBooleanRef)CFPreferencesCopyAppValue(networkKey, kCFPreferencesCurrentApplication);
	if(networkOn && CFBooleanGetValue(networkOn)) {
		[enabledNetworks addObject:@"Azoogle"];	
	}

	//CLICKBOOTH 
	networkKey = CFSTR("clickboothEnabled");
	networkOn;
	networkOn = (CFBooleanRef)CFPreferencesCopyAppValue(networkKey, kCFPreferencesCurrentApplication);
	if(networkOn && CFBooleanGetValue(networkOn)) {
		[enabledNetworks addObject:@"ClickBooth"];	
	}
	
	//CPAEMPIRE 	
	networkKey = CFSTR("cpaempireEnabled");
	networkOn = (CFBooleanRef)CFPreferencesCopyAppValue(networkKey, kCFPreferencesCurrentApplication);
	if(networkOn && CFBooleanGetValue(networkOn)) {
		[enabledNetworks addObject:@"Affiliate.com"];	
	}
	
	//CONVERT2MEDIA 	
	networkKey = CFSTR("convert2mediaEnabled");
	networkOn = (CFBooleanRef)CFPreferencesCopyAppValue(networkKey, kCFPreferencesCurrentApplication);
	if(networkOn && CFBooleanGetValue(networkOn)) {
		[enabledNetworks addObject:@"Convert2Media"];
	}	
	//COPEAC 	
	networkKey = CFSTR("copeacEnabled");
	networkOn = (CFBooleanRef)CFPreferencesCopyAppValue(networkKey, kCFPreferencesCurrentApplication);
	if(networkOn && CFBooleanGetValue(networkOn)) {
		[enabledNetworks addObject:@"Copeac"];
	}		
	//CPASTORM 	
	networkKey = CFSTR("cpastormEnabled");
	networkOn = (CFBooleanRef)CFPreferencesCopyAppValue(networkKey, kCFPreferencesCurrentApplication);
	if(networkOn && CFBooleanGetValue(networkOn)) {
		[enabledNetworks addObject:@"CPAStorm"];
	}	
	
	//DIRECTLEADS 	
	networkKey = CFSTR("directleadsEnabled");
	networkOn = (CFBooleanRef)CFPreferencesCopyAppValue(networkKey, kCFPreferencesCurrentApplication);
	if(networkOn && CFBooleanGetValue(networkOn)) {
		[enabledNetworks addObject:@"DirectLeads"];
	}	
	
	
	//DIRECTLEADS 	
	networkKey = CFSTR("globaldirectmediaEnabled");
	networkOn = (CFBooleanRef)CFPreferencesCopyAppValue(networkKey, kCFPreferencesCurrentApplication);
	if(networkOn && CFBooleanGetValue(networkOn)) {
		[enabledNetworks addObject:@"GlobalDirectMedia"];
	}	
	
	
	//MARKETLEVERAGE 	
	networkKey = CFSTR("marketleverageEnabled");
	networkOn = (CFBooleanRef)CFPreferencesCopyAppValue(networkKey, kCFPreferencesCurrentApplication);
	
	if(networkOn && CFBooleanGetValue(networkOn)) {
		[enabledNetworks addObject:@"MarketLeverage"];	
	}
	
	//NEVERBLUEADS 
	networkKey = CFSTR("neverblueEnabled");
	networkOn;
	networkOn = (CFBooleanRef)CFPreferencesCopyAppValue(networkKey, kCFPreferencesCurrentApplication);
	if(networkOn && CFBooleanGetValue(networkOn)) {
		[enabledNetworks addObject:@"NeverblueAds"];	
	}																		
	
	//MAXBOUNTY 
	networkKey = CFSTR("maxbountyEnabled");
	networkOn;
	networkOn = (CFBooleanRef)CFPreferencesCopyAppValue(networkKey, kCFPreferencesCurrentApplication);
	if(networkOn && CFBooleanGetValue(networkOn)) {
		[enabledNetworks addObject:@"Maxbounty"];	
	}				
	
	//OFFERFUSION 
	networkKey = CFSTR("offerfusionEnabled");
	networkOn;
	networkOn = (CFBooleanRef)CFPreferencesCopyAppValue(networkKey, kCFPreferencesCurrentApplication);
	if(networkOn && CFBooleanGetValue(networkOn)) {
		[enabledNetworks addObject:@"Offerfusion"];	
	}				
	
	return enabledNetworks;
	
	

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}



-( void )refreshAction
{
	
	
	if(1) { //canRefresh
		canRefresh = 0;

		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"affiliatestats.sql"];
		db = [[FMDatabase databaseWithPath:writableDBPath] retain];
		
		if (![db open]) {
			NSLog(@"Could not open db.");
			//return 0;
		}
		


		NSString *titleString2 = [(NSDictionary *)detailItem objectForKey:@"title"];

		CFStringRef networkApiKey;
		CFStringRef networkApiKeyKey;

		CFStringRef networkPasswordKey2; 
		CFStringRef networkPassword2;
		CFStringRef networkAddCodeKey2; 
		CFStringRef networkAddCode2;
		CFStringRef networkEmailKey2; 
		CFStringRef networkEmail2;

		NSString * networkUrl2;
		
		NSString * networkClientCode2;

		//DIRECT TRACK NETWORKS
		if([titleString2 isEqualToString: @"Affiliate.com"]) {
			calculateTotals = NO;
		
			networkPasswordKey2 = CFSTR("cpaempirePassword");		
			networkPassword2 = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey2, kCFPreferencesCurrentApplication);
			networkAddCodeKey2 = CFSTR("cpaempireAddCode");		
			networkAddCode2 = (CFStringRef)CFPreferencesCopyAppValue(networkAddCodeKey2, kCFPreferencesCurrentApplication);
			networkUrl2 = @"https://login.tracking101.com/api/soap_affiliate.php";
			networkClientCode2 = @"cash4creatives";
			
		}
		else if([titleString2 isEqualToString: @"Copeac"]) {
			calculateTotals = NO;
			
			networkPasswordKey2 = CFSTR("copeacPassword");		
			networkPassword2 = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey2, kCFPreferencesCurrentApplication);		
			networkAddCodeKey2 = CFSTR("copeacAddCode");		
			networkAddCode2 = (CFStringRef)CFPreferencesCopyAppValue(networkAddCodeKey2, kCFPreferencesCurrentApplication);
			networkClientCode2 = @"intermarkmedia";
			networkUrl2 = @"https://secure.directtrack.com/api/soap_affiliate.php";
		}	
		
		else if([titleString2 isEqualToString: @"CPAStorm"]) {
			calculateTotals = NO;
			
			networkPasswordKey2 = CFSTR("cpastormPassword");		
			networkPassword2 = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey2, kCFPreferencesCurrentApplication);		
			networkAddCodeKey2 = CFSTR("cpastormAddCode");		
			networkAddCode2 = (CFStringRef)CFPreferencesCopyAppValue(networkAddCodeKey2, kCFPreferencesCurrentApplication);
			networkClientCode2 = @"cpastorm";
			networkUrl2 = @"https://media303.com/api/soap_affiliate.php";
		}	
		else if([titleString2 isEqualToString: @"DirectLeads"]) {
			calculateTotals = NO;
		
			networkPasswordKey2 = CFSTR("directleadsPassword");		
			networkPassword2 = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey2, kCFPreferencesCurrentApplication);
			networkAddCodeKey2 = CFSTR("directleadsAddCode");		
			networkAddCode2 = (CFStringRef)CFPreferencesCopyAppValue(networkAddCodeKey2, kCFPreferencesCurrentApplication);
			networkClientCode2 = @"directleads";
			networkUrl2 = @"https://directleads.com/api/soap_affiliate.php";
			
		}		
		else if([titleString2 isEqualToString: @"GlobalDirectMedia"]) {
			calculateTotals = NO;
			
			networkPasswordKey2 = CFSTR("directleadsPassword");		
			networkPassword2 = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey2, kCFPreferencesCurrentApplication);
			networkAddCodeKey2 = CFSTR("directleadsAddCode");		
			networkAddCode2 = (CFStringRef)CFPreferencesCopyAppValue(networkAddCodeKey2, kCFPreferencesCurrentApplication);
			networkClientCode2 = @"globaldirectmedia";
			networkUrl2 = @"https://directleads.com/api/soap_affiliate.php";
			
		}		
		else if([titleString2 isEqualToString: @"MarketLeverage"]) {
			calculateTotals = NO;
		
			networkPasswordKey2 = CFSTR("marketleveragePassword");		
			networkPassword2 = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey2, kCFPreferencesCurrentApplication);		
			networkAddCodeKey2 = CFSTR("marketleverageAddCode");		
			networkAddCode2 = (CFStringRef)CFPreferencesCopyAppValue(networkAddCodeKey2, kCFPreferencesCurrentApplication);
			networkUrl2 =@"https://users.marketleverage.com/api/soap_affiliate.php";
			networkClientCode2 = @"marketleverage";
			
		}	
		//NEVERBLUE
		else if([titleString2 isEqualToString: @"NeverblueAds"]) {
			calculateTotals = NO;
			networkPasswordKey2 = CFSTR("neverbluePassword");		
			networkPassword2 = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey2, kCFPreferencesCurrentApplication);
			networkEmailKey2 = CFSTR("neverblueEmail");		
			networkEmail2 = (CFStringRef)CFPreferencesCopyAppValue(networkEmailKey2, kCFPreferencesCurrentApplication);		
			
			NSString * networkEmailNeverblue = [(NSString*)networkEmail2 stringByReplacingOccurrencesOfString:@"@" withString:@"%40"];
			//networkEmail2 = (NSString*)
			
			
			//calculate stats now since it's not direct track
			if(networkPassword2 && networkEmailNeverblue) {		
				//myStats = [[Neverblue getStats:networkEmailNeverblue password:(NSString*)networkPassword2] retain];
			
				@try {
					[self startIndicator];
					
					[neverblue getStats:networkEmailNeverblue password:(NSString*)networkPassword2] ;
			}
			@catch(NSObject * ex) {
				////NSLog([ex description]);
			}
					//[db executeUpdate:@"update networks set today = ?, yesterday = ?, month = ?, last_updated = ? where name = ?" , [myStats objectAtIndex:0], [myStats objectAtIndex:1], [myStats objectAtIndex:2], [myStats objectAtIndex:3], titleString2, nil];
					//NSLog(@"db updated");
				
				
				
			}
			
			
		
	}

		else if([titleString2 isEqualToString: @"Convert2Media"]) {
			calculateTotals = NO;

			
			networkApiKeyKey = CFSTR("convert2mediaApiKey");		
			networkApiKey = (CFStringRef)CFPreferencesCopyAppValue(networkApiKeyKey, kCFPreferencesCurrentApplication);
			
			networkClientCode2 = @"convert2media";
			networkUrl2 = @"http://reporting.c2mclicks.com/api.php";	
			
			
			@try {
				[self startIndicator];
				
				[hitpath getStats:(NSString*)networkClientCode2 key:(NSString*)networkApiKey url:(NSString*)networkUrl2] ;
			}
			@catch(NSObject * ex) {
				//NSLog([ex description]);
			}
			
			
		}

		
	
	
		
		else if([titleString2 isEqualToString: @"Maxbounty"]) {
			calculateTotals = NO;
			networkPasswordKey2 = CFSTR("maxbountyPassword");		
			networkPassword2 = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey2, kCFPreferencesCurrentApplication);
			networkEmailKey2 = CFSTR("maxbountyEmail");		
			networkEmail2 = (CFStringRef)CFPreferencesCopyAppValue(networkEmailKey2, kCFPreferencesCurrentApplication);		
			
			@try {
					[self startIndicator];
					
					[maxbounty getStats:(NSString*)networkEmail2 password:(NSString*)networkPassword2] ;
				}
				@catch(NSObject * ex) {
					//NSLog([ex description]);
				}

				
			}
			
			
			
		
		
		
		else if([titleString2 isEqualToString: @"Offerfusion"]) {
			calculateTotals = NO;
			networkPasswordKey2 = CFSTR("offerfusionPassword");		
			networkPassword2 = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey2, kCFPreferencesCurrentApplication);
			networkEmailKey2 = CFSTR("offerfusionEmail");		
			networkEmail2 = (CFStringRef)CFPreferencesCopyAppValue(networkEmailKey2, kCFPreferencesCurrentApplication);		
			
			NSString * networkEmailOfferfusion = [(NSString*)networkEmail2 stringByReplacingOccurrencesOfString:@"@" withString:@"%40"];
			//networkEmail2 = (NSString*)
			
			
			//calculate stats now since it's not direct track
			if(networkPassword2 && networkEmailOfferfusion) {		
				//myStats = [[Neverblue getStats:networkEmailNeverblue password:(NSString*)networkPassword2] retain];
				
				@try {
					[self startIndicator];
					
					[offerfusion getStats:networkEmailOfferfusion password:(NSString*)networkPassword2] ;
				}
				@catch(NSObject * ex) {
					//NSLog([ex description]);
				}
				//[db executeUpdate:@"update networks set today = ?, yesterday = ?, month = ?, last_updated = ? where name = ?" , [myStats objectAtIndex:0], [myStats objectAtIndex:1], [myStats objectAtIndex:2], [myStats objectAtIndex:3], titleString2, nil];
				//NSLog(@"db updated");
				
				
				
			}
			
			
			
		}
		
	
	else if([titleString2 isEqualToString: @"Totals"]) {
		calculateTotals = YES;
		NSArray *totalNetworks = [self getEnabledNetworks];
			
		NSEnumerator * enumerator = [totalNetworks objectEnumerator];
		id element;
		myStats = nil; // [NSArray arrayWithObjects: @"", @"",  @"",  @"", nil];
		[self.tableView reloadData];
		
		//while ([rs next]) {
		while(element = [enumerator nextObject]) {
			if([element isEqualToString: @"NeverblueAds"]) {
					networkPasswordKey2 = CFSTR("neverbluePassword");		
					networkPassword2 = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey2, kCFPreferencesCurrentApplication);
					networkEmailKey2 = CFSTR("neverblueEmail");		
					networkEmail2 = (CFStringRef)CFPreferencesCopyAppValue(networkEmailKey2, kCFPreferencesCurrentApplication);		
					//networkEmail2 = [networkEmail2 stringByReplacingOccurrencesOfString:@"@" withString:@"%40"];

					NSString * networkEmailNeverblue = [(NSString*)networkEmail2 stringByReplacingOccurrencesOfString:@"@" withString:@"%40"];

					//myStats = 
					@try {
						[self startIndicator];
						[neverblue getStats:networkEmailNeverblue password:(NSString*)networkPassword2];
					}
					@catch(NSObject * ex) {
						//NSLog([ex description]);
					}
					
				}
			else if([element isEqualToString: @"Convert2Media"]) {
				networkAddCodeKey2 = CFSTR("convert2mediaAddCode");		
				networkAddCode2 = (CFStringRef)CFPreferencesCopyAppValue(networkAddCodeKey2, kCFPreferencesCurrentApplication);
				networkUrl2 = @"http://reporting.c2mclicks.com";				
				@try {
					[self startIndicator];
					[hitpath getStats:(NSString*)networkClientCode2 key:(NSString*)networkApiKey url:(NSString*)networkUrl2] ;

				}
				@catch(NSObject * ex) {
					//NSLog([ex description]);
				}
			}

			else if([element isEqualToString: @"Maxbounty"]) {
				networkPasswordKey2 = CFSTR("maxbountyPassword");		
				networkPassword2 = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey2, kCFPreferencesCurrentApplication);
				networkEmailKey2 = CFSTR("maxbountyEmail");		
				networkEmail2 = (CFStringRef)CFPreferencesCopyAppValue(networkEmailKey2, kCFPreferencesCurrentApplication);		
				//networkEmail2 = [networkEmail2 stringByReplacingOccurrencesOfString:@"@" withString:@"%40"];
				
				//NSString * networkEmailMaxbounty = [(NSString*)networkEmail2 stringByReplacingOccurrencesOfString:@"@" withString:@"%40"];
				
				//myStats = 
				@try {
					[self startIndicator];
					[maxbounty getStats:(NSString*)networkEmail2 password:(NSString*)networkPassword2];
				}
				@catch(NSObject * ex) {
					//NSLog([ex description]);
				}
				
			}


			else if([element isEqualToString: @"Offerfusion"]) {
				networkPasswordKey2 = CFSTR("offerfusionPassword");		
				networkPassword2 = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey2, kCFPreferencesCurrentApplication);
				networkEmailKey2 = CFSTR("offerfusionEmail");		
				networkEmail2 = (CFStringRef)CFPreferencesCopyAppValue(networkEmailKey2, kCFPreferencesCurrentApplication);		
				//networkEmail2 = [networkEmail2 stringByReplacingOccurrencesOfString:@"@" withString:@"%40"];
				
				NSString * networkEmailOfferfusion = [(NSString*)networkEmail2 stringByReplacingOccurrencesOfString:@"@" withString:@"%40"];
				
				//myStats = 
				@try {
					[self startIndicator];
					[offerfusion getStats:networkEmailOfferfusion password:(NSString*)networkPassword2];
				}
				@catch(NSObject * ex) {
					//NSLog([ex description]);
				}
				
			}				
			else if([element isEqualToString: @"Zanox"]) {
				networkPasswordKey2 = CFSTR("zanoxPassword");		
				networkPassword2 = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey2, kCFPreferencesCurrentApplication);
				networkEmailKey2 = CFSTR("zanoxEmail");		
				networkEmail2 = (CFStringRef)CFPreferencesCopyAppValue(networkEmailKey2, kCFPreferencesCurrentApplication);		
				//networkEmail2 = [networkEmail2 stringByReplacingOccurrencesOfString:@"@" withString:@"%40"];
				
				NSString * networkEmailZanox = [(NSString*)networkEmail2 stringByReplacingOccurrencesOfString:@"@" withString:@"%40"];
				
				//myStats = 
				@try {
					[self startIndicator];
					[zanox getStats:networkEmailZanox password:(NSString*)networkPassword2];
				}
				@catch(NSObject * ex) {
					//NSLog([ex description]);
				}
				
			}
			else {
		
					if([element isEqualToString: @"Affiliate.com"]) {
						networkPasswordKey2 = CFSTR("cpaempirePassword");		
						networkPassword2 = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey2, kCFPreferencesCurrentApplication);
						networkAddCodeKey2 = CFSTR("cpaempireAddCode");		
						networkAddCode2 = (CFStringRef)CFPreferencesCopyAppValue(networkAddCodeKey2, kCFPreferencesCurrentApplication);
						networkUrl2 = @"https://login.tracking101.com/api/soap_affiliate.php";
						networkClientCode2 = @"cash4creatives";
					}

					else if([element isEqualToString: @"Copeac"]) {
						networkPasswordKey2 = CFSTR("copeacPassword");		
						networkPassword2 = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey2, kCFPreferencesCurrentApplication);
						networkAddCodeKey2 = CFSTR("copeacAddCode");		
						networkAddCode2 = (CFStringRef)CFPreferencesCopyAppValue(networkAddCodeKey2, kCFPreferencesCurrentApplication);
						networkUrl2 = @"https://secure.directtrack.com/api/soap_affiliate.php";	
						//networkUrl2 = @"https://copeac.com/api/soap_affiliate.php";	
						networkClientCode2 = @"intermarkmedia";
					}
					else if([element isEqualToString: @"CPAStorm"]) {
						networkPasswordKey2 = CFSTR("cpastormPassword");		
						networkPassword2 = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey2, kCFPreferencesCurrentApplication);		
						networkAddCodeKey2 = CFSTR("cpastormAddCode");		
						networkAddCode2 = (CFStringRef)CFPreferencesCopyAppValue(networkAddCodeKey2, kCFPreferencesCurrentApplication);
						networkClientCode2 = @"cpastorm";
						networkUrl2 = @"https://media303.com/api/soap_affiliate.php";			
					}
					else if([element isEqualToString: @"DirectLeads"]) {
						networkPasswordKey2 = CFSTR("directleadsPassword");		
						networkPassword2 = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey2, kCFPreferencesCurrentApplication);
						networkAddCodeKey2 = CFSTR("directleadsAddCode");		
						networkAddCode2 = (CFStringRef)CFPreferencesCopyAppValue(networkAddCodeKey2, kCFPreferencesCurrentApplication);
						networkClientCode2 = @"directleads";
						networkUrl2 = @"https://directleads.com/api/soap_affiliate.php";				
					}
					else if([element isEqualToString: @"GlobalDirectMedia"]) {
						networkPasswordKey2 = CFSTR("globaldirectmediaPassword");		
						networkPassword2 = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey2, kCFPreferencesCurrentApplication);
						networkAddCodeKey2 = CFSTR("globaldirectmediaAddCode");		
						networkAddCode2 = (CFStringRef)CFPreferencesCopyAppValue(networkAddCodeKey2, kCFPreferencesCurrentApplication);
						networkUrl2 = @"https://secure.directtrack.com/api/soap_affiliate.php";					
						networkClientCode2 = @"globaldirectmedia";	
					}
					else if([element isEqualToString: @"MarketLeverage"]) {
						networkPasswordKey2 = CFSTR("marketleveragePassword");		
						networkPassword2 = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey2, kCFPreferencesCurrentApplication);		
						networkAddCodeKey2 = CFSTR("marketleverageAddCode");		
						networkAddCode2 = (CFStringRef)CFPreferencesCopyAppValue(networkAddCodeKey2, kCFPreferencesCurrentApplication);
						networkUrl2 =@"https://users.marketleverage.com/api/soap_affiliate.php";
						networkClientCode2 = @"marketleverage";	
					}
				
				
				
					
					@try{ 
						DirectTrack *directtrack2 = [[DirectTrack alloc] init];   
						[self startIndicator];
						
						[directtrack2 getStats:networkUrl2 client:networkClientCode2 addCode:(NSString*)networkAddCode2 password:(NSString*)networkPassword2 networkName: element];
						
					}
					@catch(NSObject * ex) {
						//NSLog([ex description]);
					}
		
					
					
				}
			

	}
	
	
	


	if(networkPassword2 && networkAddCode2 && ![titleString2 isEqualToString: @"NeverblueAds"]  &&
	   ![titleString2 isEqualToString: @"Maxbounty"]  && ![titleString2 isEqualToString: @"Offerfusion"] &&
	   ![titleString2 isEqualToString: @"Zanox"] && ![titleString2 isEqualToString: @"Totals"]  &&
	   ![titleString2 isEqualToString: @"Convert2Media"] && ![titleString2 isEqualToString: @"Ads4Dough"]) {		
		[self startIndicator];

		[directtrack getStats:networkUrl2 client:networkClientCode2 addCode:(NSString*)networkAddCode2 password:(NSString*)networkPassword2 networkName: titleString2];

	}

	
	}

	[db close];
}

}

- (void)reloadWithStats:(NSMutableArray *)stats {

	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"affiliatestats.sql"];
	db = [[FMDatabase databaseWithPath:writableDBPath] retain];
	
	if (![db open]) {
		NSLog(@"Could not open db.");
		//return 0;
	}
	
	
	//db = [FMDatabase databaseWithPath:writableDBPath];

	//NSLog(@"reloading");
	if(calculateTotals) {
		if(myStats == nil) {
			myStats = [NSMutableArray new];
			
			myStats = [(NSMutableArray *)stats retain];
			
		}
		
		//NSLog(@"calculate totals!!");
		
		//NSString *titleString = [(NSDictionary *)detailItem objectForKey:@"title"];
		
		//NSLog(titleString);
		[db executeUpdate:@"insert or replace into networks (name) values (?)" , [stats objectAtIndex:4]];

		[db executeUpdate:@"update networks set today = ?, yesterday = ?, month = ?, last_updated = ? where name = ?" , [stats objectAtIndex:0], [stats objectAtIndex:1], [stats objectAtIndex:2], [stats objectAtIndex:3], [stats objectAtIndex:4], nil];

		
		rs = [db executeQuery:@"select sum(today) sumtoday, sum(yesterday) sumyesterday, sum(month) summonth from networks where name != 'Totals'"];
		if ([rs next]) {
			
			NSData * sumtoday = [rs dataForColumn:@"sumtoday"];
			NSString *sumtodayString = [NSString stringWithCString:[sumtoday bytes] length:[sumtoday length]];
			
			NSData *sumyesterday = [rs dataForColumn:@"sumyesterday"];
			NSString *sumyesterdayString = [NSString stringWithCString:[sumyesterday bytes] length:[sumyesterday length]];
			
			NSData *summonth = [rs dataForColumn:@"summonth"];
			NSString *summonthString = [NSString stringWithCString:[summonth bytes] length:[summonth length]];
			
			CFAbsoluteTime currentTime = CFAbsoluteTimeGetCurrent();
			myStats = [[NSMutableArray alloc] initWithObjects: sumtodayString, sumyesterdayString, summonthString,  [[NSNumber numberWithInt:currentTime] stringValue], nil];
			
		}
		[rs close];
		//*/

		
		
		/*
		int arrayCount = [myStats count];
		NSAutoreleasePool *pool =  [[NSAutoreleasePool alloc] init];
		for (int i = 0; i < arrayCount; i++) {
			
			
			
			float v =   [[stats objectAtIndex:i] floatValue] + [[myStats objectAtIndex:i] floatValue];
			
			[myStats replaceObjectAtIndex:i withObject: [NSNumber numberWithFloat:v]];
			
			//[myStats removeObjectAtIndex:i];
			//[myStats insertObject:[NSNumber numberWithFloat:v] atIndex: i];
			
		}
		[pool release];
		 */
		
		
	}
	else {
		myStats = [stats retain];
	
		//NSString *titleString = [(NSDictionary *)detailItem objectForKey:@"title"];

		//NSLog(titleString);
		[db executeUpdate:@"update networks set today = ?, yesterday = ?, month = ?, last_updated = ? where name = ?" , [myStats objectAtIndex:0], [myStats objectAtIndex:1], [myStats objectAtIndex:2], [myStats objectAtIndex:3], [myStats objectAtIndex:4], nil];

	}	

	[self.tableView reloadData];
	[self stopIndicator];

	[db close];
}

- (id)initWithStyle:(UITableViewStyle)style {
	if ((self = [super initWithStyle:style])) {
		canRefresh = 1;		
	}
	

	
	neverblue = [[Neverblue alloc] init];   
	maxbounty = [[Maxbounty alloc] init];   
	azoogle = [[Azoogle alloc] init];   
	offerfusion = [[Offerfusion alloc] init];   
	zanox = [[Zanox alloc] init];   
	directtrack = [[DirectTrack alloc] init];   
	hitpath = [[HitPath alloc] init];   
	
	//myStats = [[NSArray alloc] initWithObjects: nil];
	
	return self;
	calculateTotals = NO;
}

- (void)viewWillAppear:(BOOL)animated {
	myStats = nil; // [NSArray arrayWithObjects: @"", @"",  @"",  @"", nil];
	[self.tableView reloadData];

	self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
    NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"affiliatestats.sql"];
	db = [FMDatabase databaseWithPath:writableDBPath];

	if (![db open]) {
		NSLog(@"Could not open db.");
		//return 0;
	}

	
	//[db executeUpdate:@"create table test (a text, b text, c integer, d double, e double)"];
    [db executeUpdate:@"create table networks (name text primary key, last_updated double, today double, yesterday double, month double)"];

	
	UIBarButtonItem *addButton = [[[UIBarButtonItem alloc]
								   initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
								   target:self
								   action:@selector(refreshAction)] autorelease];
	self.navigationItem.rightBarButtonItem = addButton;
	
	
	
	// Update the view with current data before it is displayed
	[super viewWillAppear:animated];

	// Scroll the table view to the top before it appears
	[self.tableView setContentOffset:CGPointZero animated:animated];
	self.title = [(NSDictionary *)detailItem objectForKey:@"title"];

	NSString *titleString = [(NSDictionary *)detailItem objectForKey:@"title"];

	CFStringRef networkPasswordKey; 
	CFStringRef networkPassword;
	CFStringRef networkAddCodeKey; 
	CFStringRef networkAddCode;
	CFStringRef networkEmailKey; 
	CFStringRef networkEmail;
	CFStringRef networkUsernameKey; 
	CFStringRef networkUsername;
	CFStringRef networkAccountidKey; 
	CFStringRef networkAccountid;

	
	NSString * networkUrl;
	NSString * networkClientCode;

	FMResultSet *rs3;
	NSData *d;
	NSData *cachedTime;
	//NSData *networkName;
	NSData *e;
	NSData *f;
	NSData *g;
	
	//[rs close]; 
	
	//[db close];
	
	rs = [db executeQuery:@"select last_updated from networks where name = ?", titleString];
	if ([rs next]) {
		d = [rs dataForColumn:@"last_updated"];
		[rs close];
	}
	else {
		rs3 = [db executeQuery:@"select name from networks where name = ?", titleString];
		if ([rs3 next]) {
			d = [rs3 dataForColumn:@"b"];
			[rs3 close];
		//just need to get the data as it's never been gotten
		}
		else {
			//need to add this network to the db
			if(![titleString isEqualToString: @"Totals"]) {
				[db executeUpdate:@"insert into networks (name) values (?)" , titleString];
			}
		}
	}
	

	
	if([titleString isEqualToString: @"Ads4Dough"]) {
		calculateTotals = NO;

		networkPasswordKey = CFSTR("ads4doughPassword");		
		networkPassword = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey, kCFPreferencesCurrentApplication);		
		networkAddCodeKey = CFSTR("ads4doughAddCode");		
		networkAddCode = (CFStringRef)CFPreferencesCopyAppValue(networkAddCodeKey, kCFPreferencesCurrentApplication);
		networkClientCode = @"ads4dough";
		networkUrl = @"https://secure.directtrack.com/api/soap_affiliate.php";

	}
 else if([titleString isEqualToString: @"Azoogle"]) {
	 
	 
	 calculateTotals = NO;
	 networkPasswordKey = CFSTR("azooglePassword");		
	 networkPassword = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey, kCFPreferencesCurrentApplication);
	 networkUsernameKey = CFSTR("azoogleUser");		
	 networkUsername = (CFStringRef)CFPreferencesCopyAppValue(networkUsernameKey, kCFPreferencesCurrentApplication);		
	 networkAccountidKey = CFSTR("azoogleId");		
	 networkAccountid = (CFStringRef)CFPreferencesCopyAppValue(networkAccountidKey, kCFPreferencesCurrentApplication);		
	 
	 //NSString * networkEmailString = (NSString *) [(NSString *)networkEmail stringByReplacingOccurrencesOfString:@"" withString:@""];		
	 //calculate stats now since it's not direct track
	 if(networkPassword && networkUsername && networkAccountid) {		
		 rs = [db executeQuery:@"select last_updated from networks where name = ?", titleString];
		 if ([rs next]) {
			 cachedTime = [rs dataForColumn:@"last_updated"];
			 NSString *stringFromASC = [NSString stringWithCString:[cachedTime bytes] length:[cachedTime length]];
			 float cachedFloat = [stringFromASC floatValue];
			 CFAbsoluteTime currentTime = CFAbsoluteTimeGetCurrent();
			 CFAbsoluteTime cutoffTime = currentTime - 300;
			 
			 if ([cachedTime length] == 0 || cachedFloat < cutoffTime) {
				 
				 @try {
					 [self startIndicator];
					 [azoogle getStats:(NSString *)networkAccountid username:(NSString *)networkUsername password:(NSString *)networkPassword];
				 }
				 @catch(NSObject * ex) {
					 //NSLog([ex description]);
				 }
				 
			 }
			 else {
				 [rs close];
				 rs = [db executeQuery:@"select today, yesterday, month from networks where name = ?", titleString];
				 if ([rs next]) {
					 e = [rs dataForColumn:@"today"];
					 NSString *stringFromE = [NSString stringWithCString:[e bytes] length:[e length]];
					 f = [rs dataForColumn:@"yesterday"];
					 NSString *stringFromF = [NSString stringWithCString:[f bytes] length:[f length]];
					 
					 g = [rs dataForColumn:@"month"];
					 NSString *stringFromG = [NSString stringWithCString:[g bytes] length:[g length]];
					 [rs close];	
					 myStats = [[NSMutableArray alloc] initWithObjects: stringFromE, stringFromF, stringFromG, stringFromASC, nil];
				 }
			 }
		 }
		 else {
			 @try {
				 [self startIndicator];
				 
				 [azoogle getStats:(NSString *)networkAccountid username:(NSString *)networkUsername password:(NSString *)networkPassword];
			 }
			 @catch(NSObject * ex) {
				 //NSLog([ex description]);
			 }
		 }
	 }
 
	

	
	
	
	 
	}	
	
else if([titleString isEqualToString: @"Affiliate.com"]) {
	calculateTotals = NO;
	
	networkPasswordKey = CFSTR("cpaempirePassword");		
	networkPassword = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey, kCFPreferencesCurrentApplication);
	networkAddCodeKey = CFSTR("cpaempireAddCode");		
	networkAddCode = (CFStringRef)CFPreferencesCopyAppValue(networkAddCodeKey, kCFPreferencesCurrentApplication);
	networkUrl = @"https://login.tracking101.com/api/soap_affiliate.php";
	networkClientCode = @"cash4creatives";
	
	//myStats = [[DirectTrack getStats:networkUrl client:networkClientCode addcode:networkAddCode password:networkPassword] retain];
}
	else if([titleString isEqualToString: @"ClickBooth"]) {
		calculateTotals = NO;
	
		networkPasswordKey = CFSTR("clickboothPassword");		
		networkPassword = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey, kCFPreferencesCurrentApplication);
		networkAddCodeKey = CFSTR("clickboothAddCode");		
		networkAddCode = (CFStringRef)CFPreferencesCopyAppValue(networkAddCodeKey, kCFPreferencesCurrentApplication);
		networkUrl = @"http://publishers.clickbooth.com/api/soap_affiliate.php?wsdl";
		networkClientCode = @"integraclick";
	
		//myStats = [[DirectTrack getStats:networkUrl client:networkClientCode addcode:networkAddCode password:networkPassword] retain];
	}

	
	else if([titleString isEqualToString: @"Convert2Media"]) {
		calculateTotals = NO;
		
		//networkPasswordKey = CFSTR("convert2mediaPassword");		
		//networkPassword = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey, kCFPreferencesCurrentApplication);
		networkAddCodeKey = CFSTR("convert2mediaAddCode");		
		networkAddCode = (CFStringRef)CFPreferencesCopyAppValue(networkAddCodeKey, kCFPreferencesCurrentApplication);
		networkUrl = @"http://reporting.c2mclicks.com";
		//networkClientCode = @"convert2media";
		
	}
	
	else if([titleString isEqualToString: @"Copeac"]) {
		calculateTotals = NO;
		
		networkPasswordKey = CFSTR("copeacPassword");		
		networkPassword = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey, kCFPreferencesCurrentApplication);
		networkAddCodeKey = CFSTR("copeacAddCode");		
		networkAddCode = (CFStringRef)CFPreferencesCopyAppValue(networkAddCodeKey, kCFPreferencesCurrentApplication);
		networkUrl = @"https://secure.directtrack.com/api/soap_affiliate.php";
		networkClientCode = @"intermarkmedia";
		
	}
	else if([titleString isEqualToString: @"CPAStorm"]) {
		calculateTotals = NO;
		
		networkPasswordKey = CFSTR("cpastormPassword");		
		networkPassword = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey, kCFPreferencesCurrentApplication);		
		networkAddCodeKey = CFSTR("cpastormAddCode");		
		networkAddCode = (CFStringRef)CFPreferencesCopyAppValue(networkAddCodeKey, kCFPreferencesCurrentApplication);
		networkClientCode = @"cpastorm";
		networkUrl = @"https://media303.com/api/soap_affiliate.php";
	}	
	else if([titleString isEqualToString: @"DirectLeads"]) {
		calculateTotals = NO;
		
		networkPasswordKey = CFSTR("directleadsPassword");		
		networkPassword = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey, kCFPreferencesCurrentApplication);
		networkAddCodeKey = CFSTR("directleadsAddCode");		
		networkAddCode = (CFStringRef)CFPreferencesCopyAppValue(networkAddCodeKey, kCFPreferencesCurrentApplication);
		networkClientCode = @"directleads";
		networkUrl = @"https://directleads.com/api/soap_affiliate.php";
		
	}		
	
	
	else if([titleString isEqualToString: @"GlobalDirectMedia"]) {
		calculateTotals = NO;
		
		networkPasswordKey = CFSTR("globaldirectmediaPassword");		
		networkPassword = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey, kCFPreferencesCurrentApplication);		
		networkAddCodeKey = CFSTR("globaldirectmediaAddCode");		
		networkAddCode = (CFStringRef)CFPreferencesCopyAppValue(networkAddCodeKey, kCFPreferencesCurrentApplication);
		networkClientCode = @"globaldirectmedia";
		networkUrl = @"https://secure.directtrack.com/api/soap_affiliate.php";
		
	}
	
	else if([titleString isEqualToString: @"MarketLeverage"]) {
		calculateTotals = NO;
	
		networkPasswordKey = CFSTR("marketleveragePassword");		
		networkPassword = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey, kCFPreferencesCurrentApplication);		
		networkAddCodeKey = CFSTR("marketleverageAddCode");		
		networkAddCode = (CFStringRef)CFPreferencesCopyAppValue(networkAddCodeKey, kCFPreferencesCurrentApplication);
		networkUrl =@"https://users.marketleverage.com/api/soap_affiliate.php";
		networkClientCode = @"marketleverage";
		
	}	
	else if([titleString isEqualToString: @"Totals"]) {
		[self refreshAction];
	}
	
	
	
	else if([titleString isEqualToString: @"NeverblueAds"]) {
		calculateTotals = NO;
		networkPasswordKey = CFSTR("neverbluePassword");		
		networkPassword = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey, kCFPreferencesCurrentApplication);
		networkEmailKey = CFSTR("neverblueEmail");		
		networkEmail = (CFStringRef)CFPreferencesCopyAppValue(networkEmailKey, kCFPreferencesCurrentApplication);		
		
		NSString * networkEmailString = (NSString *) [(NSString *)networkEmail stringByReplacingOccurrencesOfString:@"" withString:@""];		
		//calculate stats now since it's not direct track
		if(networkPassword && networkEmailString) {		
			rs = [db executeQuery:@"select last_updated from networks where name = ?", titleString];
			if ([rs next]) {
				cachedTime = [rs dataForColumn:@"last_updated"];
				NSString *stringFromASC = [NSString stringWithCString:[cachedTime bytes] length:[cachedTime length]];
				float cachedFloat = [stringFromASC floatValue];
				CFAbsoluteTime currentTime = CFAbsoluteTimeGetCurrent();
				CFAbsoluteTime cutoffTime = currentTime - 300;
				
				if ([cachedTime length] == 0 || cachedFloat < cutoffTime) {
				
					@try {
						[self startIndicator];
						[neverblue getStats:networkEmailString password:(NSString *)networkPassword];
					}
					@catch(NSObject * ex) {
						//NSLog([ex description]);
					}
	
				}
				else {
					[rs close];
					rs = [db executeQuery:@"select today, yesterday, month from networks where name = ?", titleString];
					if ([rs next]) {
						e = [rs dataForColumn:@"today"];
						NSString *stringFromE = [NSString stringWithCString:[e bytes] length:[e length]];
						f = [rs dataForColumn:@"yesterday"];
						NSString *stringFromF = [NSString stringWithCString:[f bytes] length:[f length]];
						
						g = [rs dataForColumn:@"month"];
						NSString *stringFromG = [NSString stringWithCString:[g bytes] length:[g length]];
						[rs close];	
						myStats = [[NSMutableArray alloc] initWithObjects: stringFromE, stringFromF, stringFromG, stringFromASC, nil];
					}
				}
			}
			else {
				@try {
					[self startIndicator];
					
					[neverblue getStats:networkEmailString password:(NSString *)networkPassword];
			}
			@catch(NSObject * ex) {
				//NSLog([ex description]);
			}
			}
		}
	}


	else if([titleString isEqualToString: @"Zanox"]) {
		calculateTotals = NO;
		networkPasswordKey = CFSTR("zanoxPassword");		
		networkPassword = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey, kCFPreferencesCurrentApplication);
		networkEmailKey = CFSTR("zanoxEmail");		
		networkEmail = (CFStringRef)CFPreferencesCopyAppValue(networkEmailKey, kCFPreferencesCurrentApplication);		
		
		NSString * networkEmailString = (NSString *) [(NSString *)networkEmail stringByReplacingOccurrencesOfString:@"" withString:@""];		
		//calculate stats now since it's not direct track
		if(networkPassword && networkEmailString) {		
			rs = [db executeQuery:@"select last_updated from networks where name = ?", titleString];
			if ([rs next]) {
				cachedTime = [rs dataForColumn:@"last_updated"];
				NSString *stringFromASC = [NSString stringWithCString:[cachedTime bytes] length:[cachedTime length]];
				float cachedFloat = [stringFromASC floatValue];
				CFAbsoluteTime currentTime = CFAbsoluteTimeGetCurrent();
				CFAbsoluteTime cutoffTime = currentTime - 300;
				
				if ([cachedTime length] == 0 || cachedFloat < cutoffTime) {
					
					@try {
						[self startIndicator];
						[zanox getStats:networkEmailString password:(NSString *)networkPassword];
					}
					@catch(NSObject * ex) {
						//NSLog([ex description]);
					}
					
				}
				else {
					[rs close];
					rs = [db executeQuery:@"select today, yesterday, month from networks where name = ?", titleString];
					if ([rs next]) {
						e = [rs dataForColumn:@"today"];
						NSString *stringFromE = [NSString stringWithCString:[e bytes] length:[e length]];
						f = [rs dataForColumn:@"yesterday"];
						NSString *stringFromF = [NSString stringWithCString:[f bytes] length:[f length]];
						
						g = [rs dataForColumn:@"month"];
						NSString *stringFromG = [NSString stringWithCString:[g bytes] length:[g length]];
						[rs close];	
						myStats = [[NSMutableArray alloc] initWithObjects: stringFromE, stringFromF, stringFromG, stringFromASC, nil];
					}
				}
			}
			else {
				@try {
					[self startIndicator];
					
					[zanox getStats:networkEmailString password:(NSString *)networkPassword];
				}
				@catch(NSObject * ex) {
					//NSLog([ex description]);
				}
			}
		}
	}
	
	
	
	
	else if([titleString isEqualToString: @"Maxbounty"]) {
		calculateTotals = NO;
		networkPasswordKey = CFSTR("maxbountyPassword");		
		networkPassword = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey, kCFPreferencesCurrentApplication);
		networkEmailKey = CFSTR("maxbountyEmail");		
		networkEmail = (CFStringRef)CFPreferencesCopyAppValue(networkEmailKey, kCFPreferencesCurrentApplication);		
		
		NSString * networkEmailString = (NSString *) [(NSString *)networkEmail stringByReplacingOccurrencesOfString:@"" withString:@""];		
		//calculate stats now since it's not direct track
		if(networkPassword && networkEmailString) {		
			rs = [db executeQuery:@"select last_updated from networks where name = ?", titleString];
			if ([rs next]) {
				cachedTime = [rs dataForColumn:@"last_updated"];
				NSString *stringFromASC = [NSString stringWithCString:[cachedTime bytes] length:[cachedTime length]];
				float cachedFloat = [stringFromASC floatValue];
				CFAbsoluteTime currentTime = CFAbsoluteTimeGetCurrent();
				CFAbsoluteTime cutoffTime = currentTime - 300;
				
				if ([cachedTime length] == 0 || cachedFloat < cutoffTime) {
					
					@try {
						[self startIndicator];
						[maxbounty getStats:networkEmailString password:(NSString *)networkPassword];
					}
					@catch(NSObject * ex) {
						//NSLog([ex description]);
					}
					
				}
				else {
					[rs close];
					rs = [db executeQuery:@"select today, yesterday, month from networks where name = ?", titleString];
					if ([rs next]) {
						e = [rs dataForColumn:@"today"];
						NSString *stringFromE = [NSString stringWithCString:[e bytes] length:[e length]];
						f = [rs dataForColumn:@"yesterday"];
						NSString *stringFromF = [NSString stringWithCString:[f bytes] length:[f length]];
						
						g = [rs dataForColumn:@"month"];
						NSString *stringFromG = [NSString stringWithCString:[g bytes] length:[g length]];
						[rs close];	
						myStats = [[NSMutableArray alloc] initWithObjects: stringFromE, stringFromF, stringFromG, stringFromASC, nil];
					}
				}
			}
			else {
				@try {
					[self startIndicator];
					
					[maxbounty getStats:networkEmailString password:(NSString *)networkPassword];
				}
				@catch(NSObject * ex) {
					//NSLog([ex description]);
				}
			}
		}
	}
	
	
	
	
	
	
	else if([titleString isEqualToString: @"Convert2Media"]) {
		calculateTotals = NO;
		
		
		CFStringRef networkAddCodeKey2; 
		CFStringRef networkAddCode2;
		NSString* networkUrl2;
		
		NSString * networkClientCode2;

		
		networkAddCodeKey2 = CFSTR("convert2mediaAddCode");		
		networkAddCode2 = (CFStringRef)CFPreferencesCopyAppValue(networkAddCodeKey2, kCFPreferencesCurrentApplication);
		networkUrl2 = @"http://reporting.c2mclicks.com";				
		
		networkClientCode2 = @"convert2media";
		
		
		CFStringRef networkApiKey;
		CFStringRef networkApiKeyKey;
		networkApiKeyKey = CFSTR("convert2mediaApiKey");		
		networkApiKey = (CFStringRef)CFPreferencesCopyAppValue(networkApiKeyKey, kCFPreferencesCurrentApplication);

		
		//calculate stats now since it's not direct track
			rs = [db executeQuery:@"select last_updated from networks where name = ?", titleString];
			if ([rs next]) {
				cachedTime = [rs dataForColumn:@"last_updated"];
				NSString *stringFromASC = [NSString stringWithCString:[cachedTime bytes] length:[cachedTime length]];
				float cachedFloat = [stringFromASC floatValue];
				CFAbsoluteTime currentTime = CFAbsoluteTimeGetCurrent();
				CFAbsoluteTime cutoffTime = currentTime - 300;
				
				if ([cachedTime length] == 0 || cachedFloat < cutoffTime) {
					
					@try {
						[self startIndicator];
						
						[hitpath getStats:(NSString*)networkClientCode2 key:(NSString*)networkApiKey url:(NSString*)networkUrl2] ;
					}
					@catch(NSObject * ex) {
						//NSLog([ex description]);
					}
					
				}
				else {
					[rs close];
					rs = [db executeQuery:@"select today, yesterday, month from networks where name = ?", titleString];
					if ([rs next]) {
						e = [rs dataForColumn:@"today"];
						NSString *stringFromE = [NSString stringWithCString:[e bytes] length:[e length]];
						f = [rs dataForColumn:@"yesterday"];
						NSString *stringFromF = [NSString stringWithCString:[f bytes] length:[f length]];
						
						g = [rs dataForColumn:@"month"];
						NSString *stringFromG = [NSString stringWithCString:[g bytes] length:[g length]];
						[rs close];	
						myStats = [[NSMutableArray alloc] initWithObjects: stringFromE, stringFromF, stringFromG, stringFromASC, nil];
					}
				}
			}
			else {
				@try {
					[self startIndicator];
					
					
					[hitpath getStats:(NSString*)networkClientCode2 key:(NSString*)networkApiKey url:(NSString*)networkUrl2] ;
				}
				@catch(NSObject * ex) {
					//NSLog([ex description]);
				}
			}
		
	}
	
	
	
	
	
	
	
	
	else if([titleString isEqualToString: @"Offerfusion"]) {
		calculateTotals = NO;
		networkPasswordKey = CFSTR("offerfusionPassword");		
		networkPassword = (CFStringRef)CFPreferencesCopyAppValue(networkPasswordKey, kCFPreferencesCurrentApplication);
		networkEmailKey = CFSTR("offerfusionEmail");		
		networkEmail = (CFStringRef)CFPreferencesCopyAppValue(networkEmailKey, kCFPreferencesCurrentApplication);		
		
		NSString * networkEmailString = (NSString *) [(NSString *)networkEmail stringByReplacingOccurrencesOfString:@"" withString:@""];		
		//calculate stats now since it's not direct track
		if(networkPassword && networkEmailString) {		
			rs = [db executeQuery:@"select last_updated from networks where name = ?", titleString];
			if ([rs next]) {
				cachedTime = [rs dataForColumn:@"last_updated"];
				NSString *stringFromASC = [NSString stringWithCString:[cachedTime bytes] length:[cachedTime length]];
				float cachedFloat = [stringFromASC floatValue];
				CFAbsoluteTime currentTime = CFAbsoluteTimeGetCurrent();
				CFAbsoluteTime cutoffTime = currentTime - 300;
				
				if ([cachedTime length] == 0 || cachedFloat < cutoffTime) {
					
					@try {
						[self startIndicator];
						[offerfusion getStats:networkEmailString password:(NSString *)networkPassword];
					}
					@catch(NSObject * ex) {
						//NSLog([ex description]);
					}
					
				}
				else {
					[rs close];
					rs = [db executeQuery:@"select today, yesterday, month from networks where name = ?", titleString];
					if ([rs next]) {
						e = [rs dataForColumn:@"today"];
						NSString *stringFromE = [NSString stringWithCString:[e bytes] length:[e length]];
						f = [rs dataForColumn:@"yesterday"];
						NSString *stringFromF = [NSString stringWithCString:[f bytes] length:[f length]];
						
						g = [rs dataForColumn:@"month"];
						NSString *stringFromG = [NSString stringWithCString:[g bytes] length:[g length]];
						[rs close];	
						myStats = [[NSMutableArray alloc] initWithObjects: stringFromE, stringFromF, stringFromG, stringFromASC, nil];
					}
				}
			}
			else {
				@try {
					[self startIndicator];
					
					[offerfusion getStats:networkEmailString password:(NSString *)networkPassword];
				}
				@catch(NSObject * ex) {
					//NSLog([ex description]);
				}
			}
		}
	}
	
	
	
	
	else {
		//shouldn't happen
	}
	
	
	
	if(networkPassword && networkAddCode && ![titleString isEqualToString: @"NeverblueAds"]  && ![titleString isEqualToString: @"Offerfusion"]  && 
	   ![titleString isEqualToString: @"Maxbounty"]  && ![titleString isEqualToString: @"Zanox"] && ![titleString isEqualToString: @"Totals" ]   &&
	   ![titleString isEqualToString: @"Convert2Media" ]  && ![titleString isEqualToString: @"Ads4Dough"] && 
		![titleString isEqualToString: @"Azoogle" ] && ![titleString isEqualToString: @"Commission Junction" ]       ) {		
		
		//DIRECT TRACK
		//check for cache
		rs = [db executeQuery:@"select last_updated from networks where name = ?", titleString];
		if ([rs next]) {
			cachedTime = [rs dataForColumn:@"last_updated"];
			NSString *stringFromASC = [NSString stringWithCString:[cachedTime bytes] length:[cachedTime length]];
			//float cachedFloat2 = [stringFromASC floatValue];
			//CFAbsoluteTime currentTime2 = CFAbsoluteTimeGetCurrent();
			//CFAbsoluteTime cutoffTime2 = currentTime2 - 60;
			//[cachedTime length] == 0 || cachedFloat2 < cutoffTime2
			if (true) {
				//NSLog(@"empty cachetime retrieving stats");
				[self startIndicator];
				[directtrack getStats:networkUrl client:networkClientCode addCode:(NSString *)networkAddCode password:(NSString *)networkPassword networkName: titleString];
				//[rs close];
				//[db executeUpdate:@"update networks set today = ?, yesterday = ?, month = ?, last_updated = ? where name = ?" , [myStats objectAtIndex:0], [myStats objectAtIndex:1], [myStats objectAtIndex:2], [myStats objectAtIndex:3], titleString, nil];
				//NSLog(@"db updated");			
			}
			else {
				[rs close];
				rs = [db executeQuery:@"select today, yesterday, month from networks where name = ?", titleString];
				if ([rs next]) {
					e = [rs dataForColumn:@"today"];
					NSString *stringFromE = [NSString stringWithCString:[e bytes] length:[e length]];
					f = [rs dataForColumn:@"yesterday"];
					NSString *stringFromF = [NSString stringWithCString:[f bytes] length:[f length]];
					
					g = [rs dataForColumn:@"month"];
					NSString *stringFromG = [NSString stringWithCString:[g bytes] length:[g length]];
					[rs close];	
					myStats = [[NSMutableArray alloc] initWithObjects: stringFromE, stringFromF, stringFromG, stringFromASC, nil];
				}
			}
			
		}
		else {
			[self startIndicator];
			[directtrack getStats:networkUrl client:networkClientCode addCode:(NSString *)networkAddCode password:(NSString *)networkPassword networkName: titleString];
			//[db executeUpdate:@"update networks set today = ?, yesterday = ?, month = ?, last_updated = ? where name = ?" , [myStats objectAtIndex:0], [myStats objectAtIndex:1], [myStats objectAtIndex:2], [myStats objectAtIndex:3], titleString, nil];
			//NSLog(@"db updated");
		}
		
		
	}
	
	
	//[rs close];
	
	//[db close];

	
	
	//[self.tableView reloadData];
	
}



// Standard table view data source and delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// There are three sections, for characters, genre, and date, in that order
	return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//NSLog(@"number of rows in section");
	
	NSInteger rows = 0;
	switch (section) {
		case 0:
		case 1:
			// For genre and date there is just one row
			rows = 1;
			break;
		case 2:
			// For the characters section, there are as many rows as there are characters
			//rows = [[detailItem objectForKey:@"mainCharacters"] count];
			rows = 1;
			break;
		case 3:
			// For the characters section, there are as many rows as there are characters
			//rows = [[detailItem objectForKey:@"mainCharacters"] count];
			rows = 1;
			break;			
		default:
			break;
	}
	return rows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	//NSLog(@"cell for row at index path begin");
	static NSString *CellIdentifier = @"tvc";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	
	// Cache a date formatter to create a string representation of the date object
	static NSDateFormatter *dateFormatter = nil;
	if (dateFormatter == nil) {
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"yyyy"];
	}
	
	NSString *cellText = nil;
	id temp;
	//id temp2;
	float temp3;
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	
	
	//NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	//[formatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	//[formatter setCurrencySymbol:@"$"];
	//[formatter setCurrencyCode:@"USD"];
	
	//[formatter setFormat:@"$#,##0.00"];
	
	//NSLog(@"Fourty-Two: %@", [formatter stringFromNumber:[NSNumber numberWithFloat:42.0]]);
	//myStats = nil;
	if(myStats) {
	switch (indexPath.section) {
		case 0: //revenue today
			temp = [myStats objectAtIndex:0];
			
			if([temp isKindOfClass:[NSString class]])
			{
				temp3 = [temp floatValue];
				cellText = [formatter stringFromNumber:[NSNumber numberWithFloat:temp3]];
			
			}
			
			else if ([temp isKindOfClass:[NSNumber class]])
			{
				//cellText = [formatter stringFromNumber:cellText];
				//temp3 = [temp floatValue];
				
				cellText = [formatter stringFromNumber:temp];

			}
			
	
			break;
		case 1: //revenue yesterday
			temp = [myStats objectAtIndex:1];
			
			if([temp isKindOfClass:[NSString class]])
			{
				temp3 = [temp floatValue];
				cellText = [formatter stringFromNumber:[NSNumber numberWithFloat:temp3]];
				
			}
			
			else if ([temp isKindOfClass:[NSNumber class]])
			{
				
				//cellText = [formatter stringFromNumber:cellText];
				cellText = [formatter stringFromNumber:temp];

			}
			
			
			
			break;
		case 2: //revenue this month
			//cellText = [(NSArray *)[detailItem objectForKey:@"mainCharacters"] objectAtIndex:indexPath.row];
			//cellText = [myStats objectAtIndex:2];
			
			temp = [myStats objectAtIndex:2];
			
			if([temp isKindOfClass:[NSString class]])
			{
				temp3 = [temp floatValue];
				cellText = [formatter stringFromNumber:[NSNumber numberWithFloat:temp3]];
				
			}
			
			else if ([temp isKindOfClass:[NSNumber class]])
			{
				cellText = [formatter stringFromNumber:temp];
			}
			
			
			
			//cellText = @"$255.00"; 
			break;
		
		default:
			break;
	}
	//NSLog(@"cell for row at index path end");
	
	//canRefresh = 1;

	cell.text = cellText;
	return cell;
	}
	else {
		cell.text = @"";
		return cell;
		
	}	
}


// Provide section titles
// HIG note: In this case, since the content of each section is obvious, there's probably no need to provide a title, but the code is useful for illustration
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

	NSString *title = nil;
	switch (section) {
		case 0:
			title = NSLocalizedString(@"Revenue Today", @"Revenue Today Title");
			break;
		case 1:
			title = NSLocalizedString(@"Revenue Yesterday", @"Revenue Yesterday Title");
			break;
		case 2:
			title = NSLocalizedString(@"Revenue This Month", @"Revenue This Month Title");
			break;
		case 3:
			title = NSLocalizedString(@"Last Updated", @"Last Updated Title");
			break;			
		default:
			break;
	}
	return title;
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// In this case, you don't want the user to be able to select individual items, so return nil
	return nil;
}





@end
