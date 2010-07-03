#import <UIKit/UIKit.h>
#import "AffiliateStatsAppDelegate.h"
#import "GRDownloadManager.h"

@class MyView;

@interface AffiliateStatsAppDelegate : NSObject <UIApplicationDelegate> {
	
	IBOutlet UIWindow *window;
	UINavigationController *navigationController;
	UITableViewController *rootViewController;
	GRDownloadManager *downMan;
	NSMutableArray *list;
	BOOL anyNetworksEnabled;
	
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) UITableViewController *rootViewController;
@property (nonatomic, retain) GRDownloadManager *downMan;

- (NSString *)dataFilePath;
- (void)saveData;
- (void)createDemoData;
- (BOOL)anyNetworksEnabled;

@property (nonatomic, copy, readonly) NSArray *list;

- (NSUInteger)countOfList;
- (id)objectInListAtIndex:(NSUInteger)theIndex;


@end
