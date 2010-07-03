#import <UIKit/UIkit.h>;
#import "ZWURLConnection.h";
#import "Maxbounty.h";
#import "Neverblue.h";
#import "Maxbounty.h";
#import "Azoogle.h";
#import "Offerfusion.h";
#import "Zanox.h";
#import "Advaliant.h";
#import "DirectTrack.h";
#import "Azoogle.h";
#import "FMDatabase.h";
#import "FMDatabaseAdditions.h";
#import "HitPath.h";
#import <sqlite3.h>

@interface DetailViewController : UITableViewController {
	NSDictionary *detailItem;
	id receivedData;
	NSMutableURLRequest *request;
	NSURLConnection *conn;
	ZWURLConnection *currentConnection;
	NSMutableArray *myStats;
    sqlite3 *database;
	FMDatabase* db;
	Neverblue *neverblue;
	Maxbounty *maxbounty;
	Azoogle *azoogle;
	HitPath *hitpath;
	Offerfusion *offerfusion;
	Zanox *zanox;

	DirectTrack *directtrack;
	FMResultSet	* rs;
	BOOL	 canRefresh;
	BOOL	 calculateTotals;
	
}

@property (nonatomic, retain) NSDictionary *detailItem;
@property (nonatomic, retain) NSMutableArray *myStats;
@property (nonatomic, retain) Neverblue *neverblue;
@property (nonatomic, retain) Maxbounty *maxbounty;
@property (nonatomic, retain) Azoogle *azoogle;
@property (nonatomic, retain) Offerfusion *offerfusion;
@property (nonatomic, retain) HitPath *hitpath;
@property (nonatomic, retain) Zanox *zanox;

@property (nonatomic, retain) DirectTrack *directtrack;
@property (nonatomic) BOOL canRefresh;
@property (nonatomic) BOOL calculateTotals;
@property (nonatomic, retain) FMDatabase *db;
//@property (nonatomic, retain) FMDatabase *db;

-( void )refreshAction;
- (void)reloadWithStats:(NSMutableArray *)stats;

@end
