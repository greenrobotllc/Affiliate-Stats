//#import <Cocoa/Cocoa.h>


@interface ZWURLConnection : NSURLConnection {
    NSMutableData *data;
    NSURLResponse *response;
    NSError *error;
    BOOL cancelled;
    BOOL running;
	NSString * theEmail;
	NSString * thePassword;
}
//+ (NSArray *)getStats:(NSString *)email password:(NSString *)password;

+ (ZWURLConnection *)connectionWithRequest:(NSURLRequest *)request email:(NSString *)email password:(NSString *)password delegate:(id )delegate;
- (id)initWithRequest:(NSURLRequest *)request;
//- (id)initWithRequest:(NSURLRequest *)request email:(NSString *)email password:(NSString *)password;
- (id)initWithRequest:(NSURLRequest *)request email:(NSString *)email password:(NSString *)password delegate:(id )delegate;

- (NSData *)data;
- (NSURLResponse *)response;
- (NSError *)error;

- (BOOL)isCancelled;
- (BOOL)isRunning;
@property (nonatomic, retain) NSString *thePassword;
@property (nonatomic, retain) NSString *theEmail;

@end