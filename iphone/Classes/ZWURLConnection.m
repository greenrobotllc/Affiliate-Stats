#import "ZWURLConnection.h"


@implementation ZWURLConnection

@synthesize theEmail;

@synthesize thePassword;

#pragma mark Object Life Cycle


/*
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
*/

+ (ZWURLConnection *)connectionWithRequest:(NSURLRequest *)request email:(NSString *)email password:(NSString *)password delegate:(id )delegate
{
	return [[[self alloc] initWithRequest:request email:email password:password delegate:delegate] autorelease];
}

+ (ZWURLConnection *)connectionWithRequest:(NSURLRequest *)request
{

    return [[[self alloc] initWithRequest:request] autorelease];
}


- (id)initWithRequest:(NSURLRequest *)request email:(NSString *)email password:(NSString *)password delegate:(id)delegate
{

	theEmail = email;
	thePassword = password;
	
    if (self = [super initWithRequest:request delegate:self]) {
        running = YES;
    }
    
    return self;
}

- (id)initWithRequest:(NSURLRequest *)request
{
	

	
    if (self = [super initWithRequest:request delegate:self]) {
        running = YES;
    }
    
    return self;
}

- (void)dealloc
{
    [data release];
    [response release];
    [error release];
    [super dealloc];
}

#pragma mark NSURLConnection

- (void)cancel
{
    cancelled = YES;
    [super cancel];
    running = NO;
    // TODO: figure out how to receive myself from the freaking run loop here
}

#pragma mark Accessors

- (BOOL)isRunning
{
    return running;
}

- (NSData *)data
{
    return data;
}

- (NSError *)error
{
    return error;
}

- (NSURLResponse *)response
{
    return response;
}

- (BOOL)isCancelled
{
    return cancelled;
}



@end