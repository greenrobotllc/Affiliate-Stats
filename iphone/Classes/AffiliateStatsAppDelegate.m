#import "AffiliateStatsAppDelegate.h"
#import "RootViewController.h"
#import "AffiliateStatsAppDelegate.h"
#import "IASKAppSettingsViewController.h"

NSString *DATA_FILENAME = @"List.archive";

@interface AffiliateStatsAppDelegate ()
@property (nonatomic, copy, readwrite) NSArray *list;
@end


@implementation AffiliateStatsAppDelegate

@synthesize window, navigationController, rootViewController, list, downMan;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	// Look for the data file; if it's not there, create some dummy data
	/*
	 NSString *dataFilePath = [self dataFilePath];
	if ([[NSFileManager defaultManager] fileExistsAtPath:dataFilePath]) {
		self.list = [NSKeyedUnarchiver unarchiveObjectWithFile:dataFilePath];
	}
	else {
	 */
	
	
	[self createDemoData];
	//}
	
	// Create the navigation and view controllers
	RootViewController *aRootViewController = [[RootViewController alloc] init];
	UINavigationController *aNavigationController = [[UINavigationController alloc] initWithRootViewController:aRootViewController];
	self.navigationController = aNavigationController;
	rootViewController = aRootViewController;
	[aNavigationController release];
	[rootViewController release];
	
	//self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
	
	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
	
	
	[self setDownMan:[[GRDownloadManager alloc] init]];
	[downMan release];
	[[self downMan] setMaxConcurrentConnections:3];
	
	
	if(![self anyNetworksEnabled]) {
		IASKAppSettingsViewController *settings = [[IASKAppSettingsViewController alloc] init];
		[settings setShowCreditsFooter:NO];
		[settings setShowDoneButton:NO];
		//[self.navigationController pushViewController:settings animated:YES];
		[[self navigationController] pushViewController:settings animated:YES];
		
		[settings release];
		
		//setupView = [self create_UITextView];
		//[[self view] addSubview:setupView];
	}

	
	
	
}


// This method is from the List template, but is not used in this example
- (void)applicationWillTerminate:(UIApplication *)application {
	[self saveData];
}


// This method is from the List template, but is not used in this example
- (void)saveData {
	[NSKeyedArchiver archiveRootObject:list toFile:[self dataFilePath]];
}


- (NSString *)dataFilePath {
	// Get the file-system path to data file in the user's Documents directory
	static NSString *dataFilePath = nil;
	if (dataFilePath != nil) {
		return dataFilePath;
	}
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	dataFilePath = [[documentsDirectory stringByAppendingPathComponent:DATA_FILENAME] retain];
	return dataFilePath;
}


- (void)setList:(NSArray *)newList {
	if (list != newList) {
		[list release];
		list = [newList mutableCopy];
	}
}

- (NSUInteger)countOfList {
	NSLog(@"before list count");
	return [list count];
}


- (BOOL)anyNetworksEnabled {
	return anyNetworksEnabled;
}


- (id)objectInListAtIndex:(NSUInteger)theIndex {
	return [list objectAtIndex:theIndex];
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[list release];
	[super dealloc];
	
}


- (void)createDemoData {

	NSMutableArray *playList = [[NSMutableArray alloc] init];
	NSMutableDictionary *dictionary;
	
	CFStringRef networkKey; 
	CFBooleanRef networkOn;
	anyNetworksEnabled = FALSE;
	

	
	
	//ADS4DOUGH 	
	networkKey = CFSTR("ads4doughEnabled");
	networkOn = (CFBooleanRef)CFPreferencesCopyAppValue(networkKey, kCFPreferencesCurrentApplication);
	if(networkOn && CFBooleanGetValue(networkOn)) {
		anyNetworksEnabled = TRUE;
		dictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Ads4Dough", @"title", nil];
		[playList addObject:dictionary];
		[dictionary release];		
	}	
	
	//AZOOGLEADS 	
	networkKey = CFSTR("azoogleEnabled");
	networkOn = (CFBooleanRef)CFPreferencesCopyAppValue(networkKey, kCFPreferencesCurrentApplication);
	if(networkOn && CFBooleanGetValue(networkOn)) {
		anyNetworksEnabled = TRUE;
		dictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Azoogle", @"title", nil];
		[playList addObject:dictionary];
		[dictionary release];		
	}	
	
	//CPAEMPIRE 	AFFILIATE.COM
	networkKey = CFSTR("cpaempireEnabled");
	networkOn = (CFBooleanRef)CFPreferencesCopyAppValue(networkKey, kCFPreferencesCurrentApplication);
	if(networkOn && CFBooleanGetValue(networkOn)) {
		anyNetworksEnabled = TRUE;
		dictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Affiliate.com", @"title", nil];
		[playList addObject:dictionary];
		[dictionary release];		
	}
	
	

	
	//CPASTORM 	
	networkKey = CFSTR("cpastormEnabled");
	networkOn = (CFBooleanRef)CFPreferencesCopyAppValue(networkKey, kCFPreferencesCurrentApplication);
	if(networkOn && CFBooleanGetValue(networkOn)) {
		anyNetworksEnabled = TRUE;
		dictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"CPAStorm", @"title", nil];
		[playList addObject:dictionary];
		[dictionary release];		
	}	
	
	//CONVERT2MEDIA 	
	networkKey = CFSTR("convert2mediaEnabled");
	networkOn = (CFBooleanRef)CFPreferencesCopyAppValue(networkKey, kCFPreferencesCurrentApplication);
	if(networkOn && CFBooleanGetValue(networkOn)) {
		anyNetworksEnabled = TRUE;
		dictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Convert2Media", @"title", nil];
		[playList addObject:dictionary];
		[dictionary release];		
	}	
	
	//COPEAC 	
	networkKey = CFSTR("copeacEnabled");
	networkOn = (CFBooleanRef)CFPreferencesCopyAppValue(networkKey, kCFPreferencesCurrentApplication);
	if(networkOn && CFBooleanGetValue(networkOn)) {
		anyNetworksEnabled = TRUE;
		dictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Copeac", @"title", nil];
		[playList addObject:dictionary];
		[dictionary release];		
	}	
	
	//DIRECTLEADS 	
	networkKey = CFSTR("directleadsEnabled");
	networkOn = (CFBooleanRef)CFPreferencesCopyAppValue(networkKey, kCFPreferencesCurrentApplication);
	if(networkOn && CFBooleanGetValue(networkOn)) {
		anyNetworksEnabled = TRUE;
		dictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"DirectLeads", @"title", nil];
		[playList addObject:dictionary];
		[dictionary release];		
	}	
	
	//GLOBALDIRECTMEDIA 	
	networkKey = CFSTR("globaldirectmediaEnabled");
	networkOn = (CFBooleanRef)CFPreferencesCopyAppValue(networkKey, kCFPreferencesCurrentApplication);
	if(networkOn && CFBooleanGetValue(networkOn)) {
		anyNetworksEnabled = TRUE;
		dictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"GlobalDirectMedia", @"title", nil];
		[playList addObject:dictionary];
		[dictionary release];		
	}	
	
	
	//MARKETLEVERAGE 	
	networkKey = CFSTR("marketleverageEnabled");
	networkOn = (CFBooleanRef)CFPreferencesCopyAppValue(networkKey, kCFPreferencesCurrentApplication);
	
	if(networkOn && CFBooleanGetValue(networkOn)) {
		anyNetworksEnabled = TRUE;
		dictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"MarketLeverage", @"title", nil];
		[playList addObject:dictionary];
		[dictionary release];		
	}
	
	//NEVERBLUEADS 
	networkKey = CFSTR("neverblueEnabled");
	networkOn;
	networkOn = (CFBooleanRef)CFPreferencesCopyAppValue(networkKey, kCFPreferencesCurrentApplication);
	NSLog(@"neverblue= %@", networkOn);
	
	if(networkOn && CFBooleanGetValue(networkOn)) {
		anyNetworksEnabled = TRUE;
		dictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"NeverblueAds", @"title", nil];
		[playList addObject:dictionary];
		[dictionary release];
	}																		

	
	//MAXBOUNTY 
	networkKey = CFSTR("maxbountyEnabled");

	networkOn = (CFBooleanRef)CFPreferencesCopyAppValue(networkKey, kCFPreferencesCurrentApplication);
	NSLog(@"maxbounty= %@", networkOn);
	
	if(networkOn && CFBooleanGetValue(networkOn)) {
		anyNetworksEnabled = TRUE;
		dictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Maxbounty", @"title", nil];
		[playList addObject:dictionary];
		[dictionary release];
	}																		
	
	//OFFERFUSION 
	networkKey = CFSTR("offerfusionEnabled");
	networkOn;
	networkOn = (CFBooleanRef)CFPreferencesCopyAppValue(networkKey, kCFPreferencesCurrentApplication);
	NSLog(@"offerfusion= %@", networkOn);
	
	if(networkOn && CFBooleanGetValue(networkOn)) {
		anyNetworksEnabled = TRUE;
		dictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Offerfusion", @"title", nil];
		[playList addObject:dictionary];
		[dictionary release];
	}																		
	

	//ZANOX 
	networkKey = CFSTR("zanoxEnabled");
	networkOn;
	networkOn = (CFBooleanRef)CFPreferencesCopyAppValue(networkKey, kCFPreferencesCurrentApplication);
	NSLog(@"zanox= %@", networkOn);
	
	if(networkOn && CFBooleanGetValue(networkOn)) {
		anyNetworksEnabled = TRUE;
		dictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Zanox", @"title", nil];
		[playList addObject:dictionary];
		[dictionary release];
	}																		
	
	
	if(networkOn) {
		CFRelease(networkOn);
	}
	
	self.list = playList;
	[playList release];
	//[dateComponents release];
	//[calendar release];
}	


@end
