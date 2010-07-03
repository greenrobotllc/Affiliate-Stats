#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "IASKAppSettingsViewController.h"

@class DetailViewController;

@interface RootViewController : UITableViewController <UITextViewDelegate> {
	DetailViewController *detailViewController;
	NetworkStatus internetConnectionStatus;
	BOOL userHasBeenAlerted;
	NSTimer *connectionHarassmentTimer;
	UIView *setupView;
    IASKAppSettingsViewController *appSettingsViewController;

	
}

- (void)promptForNetworkConnectivity;
- (void)resetUserConnectionAlert;
- (UITextView *)create_UITextView;
@property (nonatomic, retain) IASKAppSettingsViewController *appSettingsViewController;

@property (nonatomic, retain) DetailViewController *detailViewController;

@end
