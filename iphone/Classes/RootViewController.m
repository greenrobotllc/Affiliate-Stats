
#import "RootViewController.h"
#import "AffiliateStatsAppDelegate.h"
#import "DetailViewController.h"
#import "IASKAppSettingsViewController.h"


// specific font metrics used in our text fields and text views
#define kFontName				@"Arial"
#define kTextFieldFontSize		16.0
#define kTextViewFontSize		16.0

#define kHARASSMENT_TIMER 60

@implementation RootViewController

@synthesize detailViewController;
@synthesize appSettingsViewController;


- (id)initWithStyle:(UITableViewStyle)style {
	if (self = [super initWithStyle:style]) {
		self.title = NSLocalizedString(@"Affiliate Stats", @"Master view navigation title");
	}
	
	self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
	self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
	[[Reachability sharedReachability] setNetworkStatusNotificationsEnabled:YES];
	
	internetConnectionStatus = [[Reachability sharedReachability] internetConnectionStatus];  //initialize this
	// Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the
	// method "reachabilityChanged" will be called. 
	
	[self promptForNetworkConnectivity];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:@"kNetworkReachabilityChangedNotification" object:nil];

	//AffiliateStatsAppDelegate *appController = (AffiliateStatsAppDelegate *)[[UIApplication sharedApplication] delegate];

	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(openAccounts)];

	
	return self;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (IASKAppSettingsViewController*)appSettingsViewController {
	if (!appSettingsViewController) {
		appSettingsViewController = [[IASKAppSettingsViewController alloc] initWithNibName:@"IASKAppSettingsView" bundle:nil];
		appSettingsViewController.delegate = self;
		
	}
	return appSettingsViewController;
}

-(void) openAccounts {
	IASKAppSettingsViewController *settings = [[IASKAppSettingsViewController alloc] init];
	[settings setShowCreditsFooter:NO];
	[settings setShowDoneButton:NO];
	[self.navigationController pushViewController:settings animated:YES];
	//[[self navigationController] pushViewController:settings animated:YES];
	
	//[settings release];
	
	//UINavigationController *aNavController = [[UINavigationController alloc] initWithRootViewController:self.appSettingsViewController];
    //[appSettingsViewController setShowCreditsFooter:NO];  
    //self.appSettingsViewController.showDoneButton = YES;
    //[self presentModalViewController:aNavController animated:YES];
    //[aNavController release];
	
	
}
- (void)settingsViewControllerDidEnd:(IASKAppSettingsViewController*)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)postDismissModal
{
	[[self view] removeFromSuperview];
}


- (UITextView *)create_UITextView
{
	
	CGRect cgRect =[[UIScreen mainScreen] bounds];
	CGSize cgSize = cgRect.size;
	
	
	
	CGRect frame = CGRectMake(10.0, 10.0, cgSize.width - 20, cgSize.height - 80);

	UITextView *textView = [[[UITextView alloc] initWithFrame:frame] autorelease];
	
	//textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
	textView.textColor = [UIColor blackColor];
    textView.font = [UIFont fontWithName:kFontName size:kTextViewFontSize];
    //wtextView.delegate = self;
    textView.backgroundColor = [UIColor whiteColor];
	textView.editable = false;
	//textView.autoresizingMask=YES;
	textView.text = @"Thanks for downloading Affilate Stats.\n\nTo get started, enter the credentials for the affiliate networks you work with in 'Settings.app'.\n\n'Settings.app' is located in the main menu.\n\nExit this program, open 'Settings.app', and then enter your network credentials for Affiliate Stats.\n\n('Settings.app' is next to other Apple programs like Calculator and Calendar).\n\nOnce you have entered your credentials in 'Settings.app', come back to see your stats.";
	textView.returnKeyType = UIReturnKeyDefault;
	textView.keyboardType = UIKeyboardTypeDefault;	// use the default type input method (entire keyboard)
	
	// note: for UITextView, if you don't like autocompletion while typing use:
	// myTextView.autocorrectionType = UITextAutocorrectionTypeNo;
	

	
	return textView;
}



- (void)resetUserConnectionAlert {
	userHasBeenAlerted = NO;
	[connectionHarassmentTimer release];
}

- (void)reachabilityChanged:(NSNotification *)note
{
	internetConnectionStatus = [[Reachability sharedReachability] internetConnectionStatus];
	[self promptForNetworkConnectivity];
}

- (void)promptForNetworkConnectivity {
	if(internetConnectionStatus == NotReachable) {
		if(userHasBeenAlerted == NO) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Internet Connection Required" message:@"You may be in a poor service area or have a weak wireless signal." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];			
			connectionHarassmentTimer = [[NSTimer scheduledTimerWithTimeInterval:kHARASSMENT_TIMER target:self selector:@selector(resetUserConnectionAlert) userInfo:nil repeats:NO] retain];
			userHasBeenAlerted = YES;
		}
	}
}


// Standard table view data source and delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	AffiliateStatsAppDelegate *appController = (AffiliateStatsAppDelegate *)[[UIApplication sharedApplication] delegate];

	if([appController anyNetworksEnabled]) {
		return 2;
	}
	else {
		return 3;
	}
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	AffiliateStatsAppDelegate *appController = (AffiliateStatsAppDelegate *)[[UIApplication sharedApplication] delegate];

	switch (section) {
		case 0: {
			return 1;
		}
		case 1: {
			if([appController anyNetworksEnabled]) {
				AffiliateStatsAppDelegate *appController = (AffiliateStatsAppDelegate *)[[UIApplication sharedApplication] delegate];
				return [appController countOfList];			
			}
			else {
				return 1;
			}

		}
		case 2: {
			return 1;
			//AffiliateStatsAppDelegate *appController = (AffiliateStatsAppDelegate *)[[UIApplication sharedApplication] delegate];
			//return [appController countOfList];			
		}
			
		default: {
			return 1;
		}	
	}
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"MyIdentifier"] autorelease];
	//	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}

	AffiliateStatsAppDelegate *appController = (AffiliateStatsAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	switch (indexPath.section) {
		case 0: {

			//if any affiliate accounts enabled show totals
			
			if([appController anyNetworksEnabled]) {
				cell.textLabel.text = @"Totals";
			}
			else {
				//cell.text = @"No affiliate account data found.";
				//cell.text = @"No affiliate accounts are enabled.";
				cell.textLabel.text = @"No affiliate accounts found.";
				[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
			}
			
			break;
		}
		case 1: {
			if([appController anyNetworksEnabled]) {
				// Get the object to display and set the value in the cell
				AffiliateStatsAppDelegate *appController = (AffiliateStatsAppDelegate *)[[UIApplication sharedApplication] delegate];
				NSDictionary *itemAtIndex = (NSDictionary *)[appController objectInListAtIndex:indexPath.row];
				cell.textLabel.text = [itemAtIndex objectForKey:@"title"];
				break;
				
			}
			else {
				
				cell.textLabel.text = @"Add some affiliate network";
				[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
				break;
				//indexPath.row
			}
		
			
				}
		case 2: {
			cell.textLabel.text = @"accounts to get started.";
			[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
			break;
		}
		default:
			
			break;
	
			
	}
	
		return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	AffiliateStatsAppDelegate *appController = (AffiliateStatsAppDelegate *)[[UIApplication sharedApplication] delegate];

	if([appController anyNetworksEnabled]) {

	
	// Create the detail view lazily
	if (detailViewController == nil) {
		DetailViewController *aDetailViewController = [[DetailViewController alloc] initWithStyle:UITableViewStyleGrouped];
		self.detailViewController = aDetailViewController;
		[aDetailViewController release];
	}
	// Set the detail controller's inspected item to the currently-selected item
	AffiliateStatsAppDelegate *appController = (AffiliateStatsAppDelegate *)[[UIApplication sharedApplication] delegate];
	
		if(indexPath.section == 1) {	
			detailViewController.detailItem = [appController objectInListAtIndex:indexPath.row];
			
			//NSLog(@"networks");
		}
		else {
			//lol seems like a hack
			NSArray *keys = [NSArray arrayWithObjects:@"title", nil];
			NSArray *objects = [NSArray arrayWithObjects:@"Totals", nil];
			NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
			
			
			//NSLog(@"totals");
			//detailViewController.detailItem = [appController objectInListAtIndex:indexPath.row];
			detailViewController.detailItem = dictionary;
		}
		
	[[self navigationController] pushViewController:detailViewController animated:YES];
	 
	 
	}
	
}


- (void)dealloc {
	
	[detailViewController release];
	[super dealloc];
}

@end
