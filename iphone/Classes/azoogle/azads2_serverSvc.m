#import "azads2_serverSvc.h"
#import <libxml/xmlstring.h>
#if TARGET_OS_IPHONE
#import <CFNetwork/CFNetwork.h>
#endif
@implementation azads2_serverSvc
+ (void)initialize
{
	[[USGlobals sharedInstance].wsdlStandardNamespaces setObject:@"xsd" forKey:@"http://www.w3.org/2001/XMLSchema"];
	[[USGlobals sharedInstance].wsdlStandardNamespaces setObject:@"azads2_serverSvc" forKey:@"urn:azads2_server"];
	[[USGlobals sharedInstance].wsdlStandardNamespaces setObject:@"ns1" forKey:@"urn:hellowsdl"];
	[[USGlobals sharedInstance].wsdlStandardNamespaces setObject:@"ns2" forKey:@"http://schemas.xmlsoap.org/soap/encoding/"];
	[[USGlobals sharedInstance].wsdlStandardNamespaces setObject:@"ns3" forKey:@"http://schemas.xmlsoap.org/wsdl/"];
}
+ (azads2_serverBinding *)azads2_serverBinding
{
	return [[[azads2_serverBinding alloc] initWithAddress:@"https://login.azoogleads.com/soap/azads2_server.php"] autorelease];
}
@end
@implementation azads2_serverBinding
@synthesize address;
@synthesize defaultTimeout;
@synthesize logXMLInOut;
@synthesize cookies;
@synthesize authUsername;
@synthesize authPassword;
- (id)init
{
	if((self = [super init])) {
		address = nil;
		cookies = nil;
		defaultTimeout = 10;//seconds
		logXMLInOut = NO;
		synchronousOperationComplete = NO;
	}
	
	return self;
}
- (id)initWithAddress:(NSString *)anAddress
{
	if((self = [self init])) {
		self.address = [NSURL URLWithString:anAddress];
	}
	
	return self;
}
- (void)addCookie:(NSHTTPCookie *)toAdd
{
	if(toAdd != nil) {
		if(cookies == nil) cookies = [[NSMutableArray alloc] init];
		[cookies addObject:toAdd];
	}
}
- (azads2_serverBindingResponse *)performSynchronousOperation:(azads2_serverBindingOperation *)operation
{
	synchronousOperationComplete = NO;
	[operation start];
	
	// Now wait for response
	NSRunLoop *theRL = [NSRunLoop currentRunLoop];
	
	while (!synchronousOperationComplete && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
	return operation.response;
}
- (void)performAsynchronousOperation:(azads2_serverBindingOperation *)operation
{
	[operation start];
}
- (void) operation:(azads2_serverBindingOperation *)operation completedWithResponse:(azads2_serverBindingResponse *)response
{
	synchronousOperationComplete = YES;
}
- (azads2_serverBindingResponse *)authenticateUsingAffiliate_id:(NSNumber *)aAffiliate_id login:(NSString *)aLogin password:(NSString *)aPassword 
{
	return [self performSynchronousOperation:[[(azads2_serverBinding_authenticate*)[azads2_serverBinding_authenticate alloc] initWithBinding:self delegate:self
																							affiliate_id:aAffiliate_id
																							login:aLogin
																							password:aPassword
																							] autorelease]];
}
- (void)authenticateAsyncUsingAffiliate_id:(NSNumber *)aAffiliate_id login:(NSString *)aLogin password:(NSString *)aPassword  delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate
{
	[self performAsynchronousOperation: [[(azads2_serverBinding_authenticate*)[azads2_serverBinding_authenticate alloc] initWithBinding:self delegate:responseDelegate
																							 affiliate_id:aAffiliate_id
																							 login:aLogin
																							 password:aPassword
																							 ] autorelease]];
}
- (azads2_serverBindingResponse *)getListUsingLogin_hash2:(NSString *)aLogin_hash2 affiliate_id5:(NSNumber *)aAffiliate_id5 offer_id2:(NSNumber *)aOffer_id2 seperator:(NSString *)aSeperator 
{
	return [self performSynchronousOperation:[[(azads2_serverBinding_getList*)[azads2_serverBinding_getList alloc] initWithBinding:self delegate:self
																							login_hash2:aLogin_hash2
																							affiliate_id5:aAffiliate_id5
																							offer_id2:aOffer_id2
																							seperator:aSeperator
																							] autorelease]];
}
- (void)getListAsyncUsingLogin_hash2:(NSString *)aLogin_hash2 affiliate_id5:(NSNumber *)aAffiliate_id5 offer_id2:(NSNumber *)aOffer_id2 seperator:(NSString *)aSeperator  delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate
{
	[self performAsynchronousOperation: [[(azads2_serverBinding_getList*)[azads2_serverBinding_getList alloc] initWithBinding:self delegate:responseDelegate
																							 login_hash2:aLogin_hash2
																							 affiliate_id5:aAffiliate_id5
																							 offer_id2:aOffer_id2
																							 seperator:aSeperator
																							 ] autorelease]];
}
- (azads2_serverBindingResponse *)getSubHitsUsingLogin_hash3:(NSString *)aLogin_hash3 affiliate_id6:(NSNumber *)aAffiliate_id6 offer_id3:(NSNumber *)aOffer_id3 start_date:(NSString *)aStart_date end_date:(NSString *)aEnd_date traffic_type_id3:(NSNumber *)aTraffic_type_id3 sales_only:(USBoolean *)aSales_only 
{
	return [self performSynchronousOperation:[[(azads2_serverBinding_getSubHits*)[azads2_serverBinding_getSubHits alloc] initWithBinding:self delegate:self
																							login_hash3:aLogin_hash3
																							affiliate_id6:aAffiliate_id6
																							offer_id3:aOffer_id3
																							start_date:aStart_date
																							end_date:aEnd_date
																							traffic_type_id3:aTraffic_type_id3
																							sales_only:aSales_only
																							] autorelease]];
}
- (void)getSubHitsAsyncUsingLogin_hash3:(NSString *)aLogin_hash3 affiliate_id6:(NSNumber *)aAffiliate_id6 offer_id3:(NSNumber *)aOffer_id3 start_date:(NSString *)aStart_date end_date:(NSString *)aEnd_date traffic_type_id3:(NSNumber *)aTraffic_type_id3 sales_only:(USBoolean *)aSales_only  delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate
{
	[self performAsynchronousOperation: [[(azads2_serverBinding_getSubHits*)[azads2_serverBinding_getSubHits alloc] initWithBinding:self delegate:responseDelegate
																							 login_hash3:aLogin_hash3
																							 affiliate_id6:aAffiliate_id6
																							 offer_id3:aOffer_id3
																							 start_date:aStart_date
																							 end_date:aEnd_date
																							 traffic_type_id3:aTraffic_type_id3
																							 sales_only:aSales_only
																							 ] autorelease]];
}
- (azads2_serverBindingResponse *)isSuppressedUsingLogin_hash4:(NSString *)aLogin_hash4 affiliate_id7:(NSNumber *)aAffiliate_id7 offer_id4:(NSNumber *)aOffer_id4 email:(NSString *)aEmail 
{
	return [self performSynchronousOperation:[[(azads2_serverBinding_isSuppressed*)[azads2_serverBinding_isSuppressed alloc] initWithBinding:self delegate:self
																							login_hash4:aLogin_hash4
																							affiliate_id7:aAffiliate_id7
																							offer_id4:aOffer_id4
																							email:aEmail
																							] autorelease]];
}
- (void)isSuppressedAsyncUsingLogin_hash4:(NSString *)aLogin_hash4 affiliate_id7:(NSNumber *)aAffiliate_id7 offer_id4:(NSNumber *)aOffer_id4 email:(NSString *)aEmail  delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate
{
	[self performAsynchronousOperation: [[(azads2_serverBinding_isSuppressed*)[azads2_serverBinding_isSuppressed alloc] initWithBinding:self delegate:responseDelegate
																							 login_hash4:aLogin_hash4
																							 affiliate_id7:aAffiliate_id7
																							 offer_id4:aOffer_id4
																							 email:aEmail
																							 ] autorelease]];
}
- (azads2_serverBindingResponse *)leadTotalsUsingLogin_hash5:(NSString *)aLogin_hash5 affiliate_id8:(NSNumber *)aAffiliate_id8 offer_id5:(NSNumber *)aOffer_id5 start_date1:(NSString *)aStart_date1 end_date1:(NSString *)aEnd_date1 sub_id2:(NSString *)aSub_id2 traffic_type_id4:(NSNumber *)aTraffic_type_id4 sales_only1:(USBoolean *)aSales_only1 
{
	return [self performSynchronousOperation:[[(azads2_serverBinding_leadTotals*)[azads2_serverBinding_leadTotals alloc] initWithBinding:self delegate:self
																							login_hash5:aLogin_hash5
																							affiliate_id8:aAffiliate_id8
																							offer_id5:aOffer_id5
																							start_date1:aStart_date1
																							end_date1:aEnd_date1
																							sub_id2:aSub_id2
																							traffic_type_id4:aTraffic_type_id4
																							sales_only1:aSales_only1
																							] autorelease]];
}
- (void)leadTotalsAsyncUsingLogin_hash5:(NSString *)aLogin_hash5 affiliate_id8:(NSNumber *)aAffiliate_id8 offer_id5:(NSNumber *)aOffer_id5 start_date1:(NSString *)aStart_date1 end_date1:(NSString *)aEnd_date1 sub_id2:(NSString *)aSub_id2 traffic_type_id4:(NSNumber *)aTraffic_type_id4 sales_only1:(USBoolean *)aSales_only1  delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate
{
	[self performAsynchronousOperation: [[(azads2_serverBinding_leadTotals*)[azads2_serverBinding_leadTotals alloc] initWithBinding:self delegate:responseDelegate
																							 login_hash5:aLogin_hash5
																							 affiliate_id8:aAffiliate_id8
																							 offer_id5:aOffer_id5
																							 start_date1:aStart_date1
																							 end_date1:aEnd_date1
																							 sub_id2:aSub_id2
																							 traffic_type_id4:aTraffic_type_id4
																							 sales_only1:aSales_only1
																							 ] autorelease]];
}
- (azads2_serverBindingResponse *)generateClickUrlUsingLogin_hash8:(NSString *)aLogin_hash8 affiliate_id11:(NSNumber *)aAffiliate_id11 offer_id7:(NSNumber *)aOffer_id7 traffic_type_id6:(NSNumber *)aTraffic_type_id6 sub_id4:(NSString *)aSub_id4 
{
	return [self performSynchronousOperation:[[(azads2_serverBinding_generateClickUrl*)[azads2_serverBinding_generateClickUrl alloc] initWithBinding:self delegate:self
																							login_hash8:aLogin_hash8
																							affiliate_id11:aAffiliate_id11
																							offer_id7:aOffer_id7
																							traffic_type_id6:aTraffic_type_id6
																							sub_id4:aSub_id4
																							] autorelease]];
}
- (void)generateClickUrlAsyncUsingLogin_hash8:(NSString *)aLogin_hash8 affiliate_id11:(NSNumber *)aAffiliate_id11 offer_id7:(NSNumber *)aOffer_id7 traffic_type_id6:(NSNumber *)aTraffic_type_id6 sub_id4:(NSString *)aSub_id4  delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate
{
	[self performAsynchronousOperation: [[(azads2_serverBinding_generateClickUrl*)[azads2_serverBinding_generateClickUrl alloc] initWithBinding:self delegate:responseDelegate
																							 login_hash8:aLogin_hash8
																							 affiliate_id11:aAffiliate_id11
																							 offer_id7:aOffer_id7
																							 traffic_type_id6:aTraffic_type_id6
																							 sub_id4:aSub_id4
																							 ] autorelease]];
}
- (azads2_serverBindingResponse *)logoutUsingLogin_hash6:(NSString *)aLogin_hash6 affiliate_id9:(NSNumber *)aAffiliate_id9 
{
	return [self performSynchronousOperation:[[(azads2_serverBinding_logout*)[azads2_serverBinding_logout alloc] initWithBinding:self delegate:self
																							login_hash6:aLogin_hash6
																							affiliate_id9:aAffiliate_id9
																							] autorelease]];
}
- (void)logoutAsyncUsingLogin_hash6:(NSString *)aLogin_hash6 affiliate_id9:(NSNumber *)aAffiliate_id9  delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate
{
	[self performAsynchronousOperation: [[(azads2_serverBinding_logout*)[azads2_serverBinding_logout alloc] initWithBinding:self delegate:responseDelegate
																							 login_hash6:aLogin_hash6
																							 affiliate_id9:aAffiliate_id9
																							 ] autorelease]];
}
- (azads2_serverBindingResponse *)offerDetailsUsingLogin_hash7:(NSString *)aLogin_hash7 affiliate_id10:(NSNumber *)aAffiliate_id10 offer_id6:(NSNumber *)aOffer_id6 traffic_type_id5:(NSNumber *)aTraffic_type_id5 sub_id3:(NSString *)aSub_id3 suppression_delimiter:(NSString *)aSuppression_delimiter keyword_delimiter:(NSString *)aKeyword_delimiter 
{
	return [self performSynchronousOperation:[[(azads2_serverBinding_offerDetails*)[azads2_serverBinding_offerDetails alloc] initWithBinding:self delegate:self
																							login_hash7:aLogin_hash7
																							affiliate_id10:aAffiliate_id10
																							offer_id6:aOffer_id6
																							traffic_type_id5:aTraffic_type_id5
																							sub_id3:aSub_id3
																							suppression_delimiter:aSuppression_delimiter
																							keyword_delimiter:aKeyword_delimiter
																							] autorelease]];
}
- (void)offerDetailsAsyncUsingLogin_hash7:(NSString *)aLogin_hash7 affiliate_id10:(NSNumber *)aAffiliate_id10 offer_id6:(NSNumber *)aOffer_id6 traffic_type_id5:(NSNumber *)aTraffic_type_id5 sub_id3:(NSString *)aSub_id3 suppression_delimiter:(NSString *)aSuppression_delimiter keyword_delimiter:(NSString *)aKeyword_delimiter  delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate
{
	[self performAsynchronousOperation: [[(azads2_serverBinding_offerDetails*)[azads2_serverBinding_offerDetails alloc] initWithBinding:self delegate:responseDelegate
																							 login_hash7:aLogin_hash7
																							 affiliate_id10:aAffiliate_id10
																							 offer_id6:aOffer_id6
																							 traffic_type_id5:aTraffic_type_id5
																							 sub_id3:aSub_id3
																							 suppression_delimiter:aSuppression_delimiter
																							 keyword_delimiter:aKeyword_delimiter
																							 ] autorelease]];
}
- (azads2_serverBindingResponse *)listOffersUsingLogin_hash7:(NSString *)aLogin_hash7 affiliate_id10:(NSNumber *)aAffiliate_id10 
{
	return [self performSynchronousOperation:[[(azads2_serverBinding_listOffers*)[azads2_serverBinding_listOffers alloc] initWithBinding:self delegate:self
																							login_hash7:aLogin_hash7
																							affiliate_id10:aAffiliate_id10
																							] autorelease]];
}
- (void)listOffersAsyncUsingLogin_hash7:(NSString *)aLogin_hash7 affiliate_id10:(NSNumber *)aAffiliate_id10  delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate
{
	[self performAsynchronousOperation: [[(azads2_serverBinding_listOffers*)[azads2_serverBinding_listOffers alloc] initWithBinding:self delegate:responseDelegate
																							 login_hash7:aLogin_hash7
																							 affiliate_id10:aAffiliate_id10
																							 ] autorelease]];
}
- (void)sendHTTPCallUsingBody:(NSString *)outputBody soapAction:(NSString *)soapAction forOperation:(azads2_serverBindingOperation *)operation
{
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.address 
																												 cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
																										 timeoutInterval:self.defaultTimeout];
	NSData *bodyData = [outputBody dataUsingEncoding:NSUTF8StringEncoding];
	
	if(cookies != nil) {
		[request setAllHTTPHeaderFields:[NSHTTPCookie requestHeaderFieldsWithCookies:cookies]];
	}
	[request setValue:@"wsdl2objc" forHTTPHeaderField:@"User-Agent"];
	[request setValue:soapAction forHTTPHeaderField:@"SOAPAction"];
	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%u", [bodyData length]] forHTTPHeaderField:@"Content-Length"];
	[request setValue:self.address.host forHTTPHeaderField:@"Host"];
	[request setHTTPMethod: @"POST"];
	// set version 1.1 - how?
	[request setHTTPBody: bodyData];
		
	if(self.logXMLInOut) {
		NSLog(@"OutputHeaders:\n%@", [request allHTTPHeaderFields]);
		NSLog(@"OutputBody:\n%@", outputBody);
	}
	
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:operation];
	
	operation.urlConnection = connection;
	[connection release];
}
- (void) dealloc
{
	[address release];
	[cookies release];
	[super dealloc];
}
@end
@implementation azads2_serverBindingOperation
@synthesize binding;
@synthesize response;
@synthesize delegate;
@synthesize responseData;
@synthesize urlConnection;
- (id)initWithBinding:(azads2_serverBinding *)aBinding delegate:(id<azads2_serverBindingResponseDelegate>)aDelegate
{
	if ((self = [super init])) {
		self.binding = aBinding;
		response = nil;
		self.delegate = aDelegate;
		self.responseData = nil;
		self.urlConnection = nil;
	}
	
	return self;
}
-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	if ([challenge previousFailureCount] == 0) {
		NSURLCredential *newCredential;
		newCredential=[NSURLCredential credentialWithUser:self.binding.authUsername
												 password:self.binding.authPassword
											  persistence:NSURLCredentialPersistenceForSession];
		[[challenge sender] useCredential:newCredential
			   forAuthenticationChallenge:challenge];
	} else {
		[[challenge sender] cancelAuthenticationChallenge:challenge];
		NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Authentication Error" forKey:NSLocalizedDescriptionKey];
		NSError *authError = [NSError errorWithDomain:@"Connection Authentication" code:0 userInfo:userInfo];
		[self connection:connection didFailWithError:authError];
	}
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)urlResponse
{
	NSHTTPURLResponse *httpResponse;
	if ([urlResponse isKindOfClass:[NSHTTPURLResponse class]]) {
		httpResponse = (NSHTTPURLResponse *) urlResponse;
	} else {
		httpResponse = nil;
	}
	
	if(binding.logXMLInOut) {
		NSLog(@"ResponseStatus: %u\n", [httpResponse statusCode]);
		NSLog(@"ResponseHeaders:\n%@", [httpResponse allHeaderFields]);
	}
	
  if ([urlResponse.MIMEType rangeOfString:@"text/xml"].length == 0) {
		NSError *error = nil;
		[connection cancel];
		if ([httpResponse statusCode] >= 400) {
                        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSHTTPURLResponse localizedStringForStatusCode:[httpResponse statusCode]],NSLocalizedDescriptionKey,
                                                                          httpResponse.URL.absoluteString, @"URL",nil];
				
			error = [NSError errorWithDomain:@"azads2_serverBindingResponseHTTP" code:[httpResponse statusCode] userInfo:userInfo];
		} else {
                        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
	 												[NSString stringWithFormat: @"Unexpected response MIME type to SOAP call:%@", urlResponse.MIMEType],NSLocalizedDescriptionKey,
                                                                          httpResponse.URL.absoluteString, @"URL",nil];
			error = [NSError errorWithDomain:@"azads2_serverBindingResponseHTTP" code:1 userInfo:userInfo];
		}
				
		[self connection:connection didFailWithError:error];
  }
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
  if (responseData == nil) {
		responseData = [data mutableCopy];
	} else {
		[responseData appendData:data];
	}
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	if (binding.logXMLInOut) {
		NSLog(@"ResponseError:\n%@", error);
	}
	response.error = error;
	[delegate operation:self completedWithResponse:response];
}
- (void)dealloc
{
	[binding release];
	[response release];
	delegate = nil;
	[responseData release];
	[urlConnection release];
	
	[super dealloc];
}
@end
@implementation azads2_serverBinding_authenticate
@synthesize affiliate_id;
@synthesize login;
@synthesize password;
- (id)initWithBinding:(azads2_serverBinding *)aBinding delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate
affiliate_id:(NSNumber *)aAffiliate_id
login:(NSString *)aLogin
password:(NSString *)aPassword
{
	if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
		self.affiliate_id = aAffiliate_id;
		self.login = aLogin;
		self.password = aPassword;
	}
	
	return self;
}
- (void)dealloc
{
	if(affiliate_id != nil) [affiliate_id release];
	if(login != nil) [login release];
	if(password != nil) [password release];
	
	[super dealloc];
}
- (void)main
{
	[response autorelease];
	response = [azads2_serverBindingResponse new];
	
	azads2_serverBinding_envelope *envelope = [azads2_serverBinding_envelope sharedInstance];
	
	NSMutableDictionary *headerElements = nil;
	headerElements = [NSMutableDictionary dictionary];
	
	NSMutableDictionary *bodyElements = nil;
	bodyElements = [NSMutableDictionary dictionary];
	if(affiliate_id != nil) [bodyElements setObject:affiliate_id forKey:@"affiliate_id"];
	if(login != nil) [bodyElements setObject:login forKey:@"login"];
	if(password != nil) [bodyElements setObject:password forKey:@"password"];
	
	NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
	
	[binding sendHTTPCallUsingBody:operationXMLString soapAction:@"urn:azads2_server#authenticate" forOperation:self];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if (responseData != nil && delegate != nil)
	{
		xmlDocPtr doc;
		xmlNodePtr cur;
		
		if (binding.logXMLInOut) {
			NSLog(@"ResponseBody:\n%@", [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease]);
		}
		
		doc = xmlParseMemory([responseData bytes], [responseData length]);
		
		if (doc == NULL) {
			NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Errors while parsing returned XML" forKey:NSLocalizedDescriptionKey];
			
			response.error = [NSError errorWithDomain:@"azads2_serverBindingResponseXML" code:1 userInfo:userInfo];
			[delegate operation:self completedWithResponse:response];
		} else {
			cur = xmlDocGetRootElement(doc);
			cur = cur->children;
			
			for( ; cur != NULL ; cur = cur->next) {
				if(cur->type == XML_ELEMENT_NODE) {
					
					if(xmlStrEqual(cur->name, (const xmlChar *) "Body")) {
						NSMutableArray *responseBodyParts = [NSMutableArray array];
						
						xmlNodePtr bodyNode;
						for(bodyNode=cur->children ; bodyNode != NULL ; bodyNode = bodyNode->next) {
							if(cur->type == XML_ELEMENT_NODE) {
								if(xmlStrEqual(bodyNode->name, (const xmlChar *) "authenticateReturn")) {
									NSString  *bodyObject = [NSString  deserializeNode:bodyNode];
									//NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
									if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
								}
								if (xmlStrEqual(bodyNode->ns->prefix, cur->ns->prefix) && 
									xmlStrEqual(bodyNode->name, (const xmlChar *) "Fault")) {
									SOAPFault *bodyObject = [SOAPFault deserializeNode:bodyNode];
									//NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
									if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
								}
							}
						}
						
						response.bodyParts = responseBodyParts;
					}
				}
			}
			
			xmlFreeDoc(doc);
		}
		
		xmlCleanupParser();
		[delegate operation:self completedWithResponse:response];
	}
}
@end
@implementation azads2_serverBinding_getList
@synthesize login_hash2;
@synthesize affiliate_id5;
@synthesize offer_id2;
@synthesize seperator;
- (id)initWithBinding:(azads2_serverBinding *)aBinding delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate
login_hash2:(NSString *)aLogin_hash2
affiliate_id5:(NSNumber *)aAffiliate_id5
offer_id2:(NSNumber *)aOffer_id2
seperator:(NSString *)aSeperator
{
	if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
		self.login_hash2 = aLogin_hash2;
		self.affiliate_id5 = aAffiliate_id5;
		self.offer_id2 = aOffer_id2;
		self.seperator = aSeperator;
	}
	
	return self;
}
- (void)dealloc
{
	if(login_hash2 != nil) [login_hash2 release];
	if(affiliate_id5 != nil) [affiliate_id5 release];
	if(offer_id2 != nil) [offer_id2 release];
	if(seperator != nil) [seperator release];
	
	[super dealloc];
}
- (void)main
{
	[response autorelease];
	response = [azads2_serverBindingResponse new];
	
	azads2_serverBinding_envelope *envelope = [azads2_serverBinding_envelope sharedInstance];
	
	NSMutableDictionary *headerElements = nil;
	headerElements = [NSMutableDictionary dictionary];
	
	NSMutableDictionary *bodyElements = nil;
	bodyElements = [NSMutableDictionary dictionary];
	if(login_hash2 != nil) [bodyElements setObject:login_hash2 forKey:@"login_hash2"];
	if(affiliate_id5 != nil) [bodyElements setObject:affiliate_id5 forKey:@"affiliate_id5"];
	if(offer_id2 != nil) [bodyElements setObject:offer_id2 forKey:@"offer_id2"];
	if(seperator != nil) [bodyElements setObject:seperator forKey:@"seperator"];
	
	NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
	
	[binding sendHTTPCallUsingBody:operationXMLString soapAction:@"urn:azads2_server#getList" forOperation:self];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if (responseData != nil && delegate != nil)
	{
		xmlDocPtr doc;
		xmlNodePtr cur;
		
		if (binding.logXMLInOut) {
			NSLog(@"ResponseBody:\n%@", [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease]);
		}
		
		doc = xmlParseMemory([responseData bytes], [responseData length]);
		
		if (doc == NULL) {
			NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Errors while parsing returned XML" forKey:NSLocalizedDescriptionKey];
			
			response.error = [NSError errorWithDomain:@"azads2_serverBindingResponseXML" code:1 userInfo:userInfo];
			[delegate operation:self completedWithResponse:response];
		} else {
			cur = xmlDocGetRootElement(doc);
			cur = cur->children;
			
			for( ; cur != NULL ; cur = cur->next) {
				if(cur->type == XML_ELEMENT_NODE) {
					
					if(xmlStrEqual(cur->name, (const xmlChar *) "Body")) {
						NSMutableArray *responseBodyParts = [NSMutableArray array];
						
						xmlNodePtr bodyNode;
						for(bodyNode=cur->children ; bodyNode != NULL ; bodyNode = bodyNode->next) {
							if(cur->type == XML_ELEMENT_NODE) {
								if(xmlStrEqual(bodyNode->name, (const xmlChar *) "getListReturn")) {
									NSString  *bodyObject = [NSString  deserializeNode:bodyNode];
									//NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
									if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
								}
								if (xmlStrEqual(bodyNode->ns->prefix, cur->ns->prefix) && 
									xmlStrEqual(bodyNode->name, (const xmlChar *) "Fault")) {
									SOAPFault *bodyObject = [SOAPFault deserializeNode:bodyNode];
									//NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
									if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
								}
							}
						}
						
						response.bodyParts = responseBodyParts;
					}
				}
			}
			
			xmlFreeDoc(doc);
		}
		
		xmlCleanupParser();
		[delegate operation:self completedWithResponse:response];
	}
}
@end
@implementation azads2_serverBinding_getSubHits
@synthesize login_hash3;
@synthesize affiliate_id6;
@synthesize offer_id3;
@synthesize start_date;
@synthesize end_date;
@synthesize traffic_type_id3;
@synthesize sales_only;
- (id)initWithBinding:(azads2_serverBinding *)aBinding delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate
login_hash3:(NSString *)aLogin_hash3
affiliate_id6:(NSNumber *)aAffiliate_id6
offer_id3:(NSNumber *)aOffer_id3
start_date:(NSString *)aStart_date
end_date:(NSString *)aEnd_date
traffic_type_id3:(NSNumber *)aTraffic_type_id3
sales_only:(USBoolean *)aSales_only
{
	if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
		self.login_hash3 = aLogin_hash3;
		self.affiliate_id6 = aAffiliate_id6;
		self.offer_id3 = aOffer_id3;
		self.start_date = aStart_date;
		self.end_date = aEnd_date;
		self.traffic_type_id3 = aTraffic_type_id3;
		self.sales_only = aSales_only;
	}
	
	return self;
}
- (void)dealloc
{
	if(login_hash3 != nil) [login_hash3 release];
	if(affiliate_id6 != nil) [affiliate_id6 release];
	if(offer_id3 != nil) [offer_id3 release];
	if(start_date != nil) [start_date release];
	if(end_date != nil) [end_date release];
	if(traffic_type_id3 != nil) [traffic_type_id3 release];
	if(sales_only != nil) [sales_only release];
	
	[super dealloc];
}
- (void)main
{
	[response autorelease];
	response = [azads2_serverBindingResponse new];
	
	azads2_serverBinding_envelope *envelope = [azads2_serverBinding_envelope sharedInstance];
	
	NSMutableDictionary *headerElements = nil;
	headerElements = [NSMutableDictionary dictionary];
	
	NSMutableDictionary *bodyElements = nil;
	bodyElements = [NSMutableDictionary dictionary];
	if(login_hash3 != nil) [bodyElements setObject:login_hash3 forKey:@"login_hash3"];
	if(affiliate_id6 != nil) [bodyElements setObject:affiliate_id6 forKey:@"affiliate_id6"];
	if(offer_id3 != nil) [bodyElements setObject:offer_id3 forKey:@"offer_id3"];
	if(start_date != nil) [bodyElements setObject:start_date forKey:@"start_date"];
	if(end_date != nil) [bodyElements setObject:end_date forKey:@"end_date"];
	if(traffic_type_id3 != nil) [bodyElements setObject:traffic_type_id3 forKey:@"traffic_type_id3"];
	if(sales_only != nil) [bodyElements setObject:sales_only forKey:@"sales_only"];
	
	NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
	
	[binding sendHTTPCallUsingBody:operationXMLString soapAction:@"urn:azads2_server#getSubHits" forOperation:self];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if (responseData != nil && delegate != nil)
	{
		xmlDocPtr doc;
		xmlNodePtr cur;
		
		if (binding.logXMLInOut) {
			NSLog(@"ResponseBody:\n%@", [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease]);
		}
		
		doc = xmlParseMemory([responseData bytes], [responseData length]);
		
		if (doc == NULL) {
			NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Errors while parsing returned XML" forKey:NSLocalizedDescriptionKey];
			
			response.error = [NSError errorWithDomain:@"azads2_serverBindingResponseXML" code:1 userInfo:userInfo];
			[delegate operation:self completedWithResponse:response];
		} else {
			cur = xmlDocGetRootElement(doc);
			cur = cur->children;
			
			for( ; cur != NULL ; cur = cur->next) {
				if(cur->type == XML_ELEMENT_NODE) {
					
					if(xmlStrEqual(cur->name, (const xmlChar *) "Body")) {
						NSMutableArray *responseBodyParts = [NSMutableArray array];
						
						xmlNodePtr bodyNode;
						for(bodyNode=cur->children ; bodyNode != NULL ; bodyNode = bodyNode->next) {
							if(cur->type == XML_ELEMENT_NODE) {
								if(xmlStrEqual(bodyNode->name, (const xmlChar *) "getSubHitsReturn")) {
									NSString  *bodyObject = [NSString  deserializeNode:bodyNode];
									//NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
									if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
								}
								if (xmlStrEqual(bodyNode->ns->prefix, cur->ns->prefix) && 
									xmlStrEqual(bodyNode->name, (const xmlChar *) "Fault")) {
									SOAPFault *bodyObject = [SOAPFault deserializeNode:bodyNode];
									//NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
									if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
								}
							}
						}
						
						response.bodyParts = responseBodyParts;
					}
				}
			}
			
			xmlFreeDoc(doc);
		}
		
		xmlCleanupParser();
		[delegate operation:self completedWithResponse:response];
	}
}
@end
@implementation azads2_serverBinding_isSuppressed
@synthesize login_hash4;
@synthesize affiliate_id7;
@synthesize offer_id4;
@synthesize email;
- (id)initWithBinding:(azads2_serverBinding *)aBinding delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate
login_hash4:(NSString *)aLogin_hash4
affiliate_id7:(NSNumber *)aAffiliate_id7
offer_id4:(NSNumber *)aOffer_id4
email:(NSString *)aEmail
{
	if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
		self.login_hash4 = aLogin_hash4;
		self.affiliate_id7 = aAffiliate_id7;
		self.offer_id4 = aOffer_id4;
		self.email = aEmail;
	}
	
	return self;
}
- (void)dealloc
{
	if(login_hash4 != nil) [login_hash4 release];
	if(affiliate_id7 != nil) [affiliate_id7 release];
	if(offer_id4 != nil) [offer_id4 release];
	if(email != nil) [email release];
	
	[super dealloc];
}
- (void)main
{
	[response autorelease];
	response = [azads2_serverBindingResponse new];
	
	azads2_serverBinding_envelope *envelope = [azads2_serverBinding_envelope sharedInstance];
	
	NSMutableDictionary *headerElements = nil;
	headerElements = [NSMutableDictionary dictionary];
	
	NSMutableDictionary *bodyElements = nil;
	bodyElements = [NSMutableDictionary dictionary];
	if(login_hash4 != nil) [bodyElements setObject:login_hash4 forKey:@"login_hash4"];
	if(affiliate_id7 != nil) [bodyElements setObject:affiliate_id7 forKey:@"affiliate_id7"];
	if(offer_id4 != nil) [bodyElements setObject:offer_id4 forKey:@"offer_id4"];
	if(email != nil) [bodyElements setObject:email forKey:@"email"];
	
	NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
	
	[binding sendHTTPCallUsingBody:operationXMLString soapAction:@"urn:azads2_server#isSuppressed" forOperation:self];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if (responseData != nil && delegate != nil)
	{
		xmlDocPtr doc;
		xmlNodePtr cur;
		
		if (binding.logXMLInOut) {
			NSLog(@"ResponseBody:\n%@", [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease]);
		}
		
		doc = xmlParseMemory([responseData bytes], [responseData length]);
		
		if (doc == NULL) {
			NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Errors while parsing returned XML" forKey:NSLocalizedDescriptionKey];
			
			response.error = [NSError errorWithDomain:@"azads2_serverBindingResponseXML" code:1 userInfo:userInfo];
			[delegate operation:self completedWithResponse:response];
		} else {
			cur = xmlDocGetRootElement(doc);
			cur = cur->children;
			
			for( ; cur != NULL ; cur = cur->next) {
				if(cur->type == XML_ELEMENT_NODE) {
					
					if(xmlStrEqual(cur->name, (const xmlChar *) "Body")) {
						NSMutableArray *responseBodyParts = [NSMutableArray array];
						
						xmlNodePtr bodyNode;
						for(bodyNode=cur->children ; bodyNode != NULL ; bodyNode = bodyNode->next) {
							if(cur->type == XML_ELEMENT_NODE) {
								if(xmlStrEqual(bodyNode->name, (const xmlChar *) "isSuppressedReturn")) {
									NSString  *bodyObject = [NSString  deserializeNode:bodyNode];
									//NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
									if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
								}
								if (xmlStrEqual(bodyNode->ns->prefix, cur->ns->prefix) && 
									xmlStrEqual(bodyNode->name, (const xmlChar *) "Fault")) {
									SOAPFault *bodyObject = [SOAPFault deserializeNode:bodyNode];
									//NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
									if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
								}
							}
						}
						
						response.bodyParts = responseBodyParts;
					}
				}
			}
			
			xmlFreeDoc(doc);
		}
		
		xmlCleanupParser();
		[delegate operation:self completedWithResponse:response];
	}
}
@end
@implementation azads2_serverBinding_leadTotals
@synthesize login_hash5;
@synthesize affiliate_id8;
@synthesize offer_id5;
@synthesize start_date1;
@synthesize end_date1;
@synthesize sub_id2;
@synthesize traffic_type_id4;
@synthesize sales_only1;
- (id)initWithBinding:(azads2_serverBinding *)aBinding delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate
login_hash5:(NSString *)aLogin_hash5
affiliate_id8:(NSNumber *)aAffiliate_id8
offer_id5:(NSNumber *)aOffer_id5
start_date1:(NSString *)aStart_date1
end_date1:(NSString *)aEnd_date1
sub_id2:(NSString *)aSub_id2
traffic_type_id4:(NSNumber *)aTraffic_type_id4
sales_only1:(USBoolean *)aSales_only1
{
	if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
		self.login_hash5 = aLogin_hash5;
		self.affiliate_id8 = aAffiliate_id8;
		self.offer_id5 = aOffer_id5;
		self.start_date1 = aStart_date1;
		self.end_date1 = aEnd_date1;
		self.sub_id2 = aSub_id2;
		self.traffic_type_id4 = aTraffic_type_id4;
		self.sales_only1 = aSales_only1;
	}
	
	return self;
}
- (void)dealloc
{
	if(login_hash5 != nil) [login_hash5 release];
	if(affiliate_id8 != nil) [affiliate_id8 release];
	if(offer_id5 != nil) [offer_id5 release];
	if(start_date1 != nil) [start_date1 release];
	if(end_date1 != nil) [end_date1 release];
	if(sub_id2 != nil) [sub_id2 release];
	if(traffic_type_id4 != nil) [traffic_type_id4 release];
	if(sales_only1 != nil) [sales_only1 release];
	
	[super dealloc];
}
- (void)main
{
	[response autorelease];
	response = [azads2_serverBindingResponse new];
	
	azads2_serverBinding_envelope *envelope = [azads2_serverBinding_envelope sharedInstance];
	
	NSMutableDictionary *headerElements = nil;
	headerElements = [NSMutableDictionary dictionary];
	
	NSMutableDictionary *bodyElements = nil;
	bodyElements = [NSMutableDictionary dictionary];
	if(login_hash5 != nil) [bodyElements setObject:login_hash5 forKey:@"login_hash5"];
	if(affiliate_id8 != nil) [bodyElements setObject:affiliate_id8 forKey:@"affiliate_id8"];
	if(offer_id5 != nil) [bodyElements setObject:offer_id5 forKey:@"offer_id5"];
	if(start_date1 != nil) [bodyElements setObject:start_date1 forKey:@"start_date1"];
	if(end_date1 != nil) [bodyElements setObject:end_date1 forKey:@"end_date1"];
	if(sub_id2 != nil) [bodyElements setObject:sub_id2 forKey:@"sub_id2"];
	if(traffic_type_id4 != nil) [bodyElements setObject:traffic_type_id4 forKey:@"traffic_type_id4"];
	if(sales_only1 != nil) [bodyElements setObject:sales_only1 forKey:@"sales_only1"];
	
	NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
	
	[binding sendHTTPCallUsingBody:operationXMLString soapAction:@"urn:azads2_server#leadTotals" forOperation:self];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if (responseData != nil && delegate != nil)
	{
		xmlDocPtr doc;
		xmlNodePtr cur;
		
		if (binding.logXMLInOut) {
			NSLog(@"ResponseBody:\n%@", [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease]);
		}
		
		doc = xmlParseMemory([responseData bytes], [responseData length]);
		
		if (doc == NULL) {
			NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Errors while parsing returned XML" forKey:NSLocalizedDescriptionKey];
			
			response.error = [NSError errorWithDomain:@"azads2_serverBindingResponseXML" code:1 userInfo:userInfo];
			[delegate operation:self completedWithResponse:response];
		} else {
			cur = xmlDocGetRootElement(doc);
			cur = cur->children;
			
			for( ; cur != NULL ; cur = cur->next) {
				if(cur->type == XML_ELEMENT_NODE) {
					
					if(xmlStrEqual(cur->name, (const xmlChar *) "Body")) {
						NSMutableArray *responseBodyParts = [NSMutableArray array];
						
						xmlNodePtr bodyNode;
						for(bodyNode=cur->children ; bodyNode != NULL ; bodyNode = bodyNode->next) {
							if(cur->type == XML_ELEMENT_NODE) {
								if(xmlStrEqual(bodyNode->name, (const xmlChar *) "leadTotalsReturn")) {
									NSString  *bodyObject = [NSString  deserializeNode:bodyNode];
									//NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
									if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
								}
								if (xmlStrEqual(bodyNode->ns->prefix, cur->ns->prefix) && 
									xmlStrEqual(bodyNode->name, (const xmlChar *) "Fault")) {
									SOAPFault *bodyObject = [SOAPFault deserializeNode:bodyNode];
									//NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
									if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
								}
							}
						}
						
						response.bodyParts = responseBodyParts;
					}
				}
			}
			
			xmlFreeDoc(doc);
		}
		
		xmlCleanupParser();
		[delegate operation:self completedWithResponse:response];
	}
}
@end
@implementation azads2_serverBinding_generateClickUrl
@synthesize login_hash8;
@synthesize affiliate_id11;
@synthesize offer_id7;
@synthesize traffic_type_id6;
@synthesize sub_id4;
- (id)initWithBinding:(azads2_serverBinding *)aBinding delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate
login_hash8:(NSString *)aLogin_hash8
affiliate_id11:(NSNumber *)aAffiliate_id11
offer_id7:(NSNumber *)aOffer_id7
traffic_type_id6:(NSNumber *)aTraffic_type_id6
sub_id4:(NSString *)aSub_id4
{
	if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
		self.login_hash8 = aLogin_hash8;
		self.affiliate_id11 = aAffiliate_id11;
		self.offer_id7 = aOffer_id7;
		self.traffic_type_id6 = aTraffic_type_id6;
		self.sub_id4 = aSub_id4;
	}
	
	return self;
}
- (void)dealloc
{
	if(login_hash8 != nil) [login_hash8 release];
	if(affiliate_id11 != nil) [affiliate_id11 release];
	if(offer_id7 != nil) [offer_id7 release];
	if(traffic_type_id6 != nil) [traffic_type_id6 release];
	if(sub_id4 != nil) [sub_id4 release];
	
	[super dealloc];
}
- (void)main
{
	[response autorelease];
	response = [azads2_serverBindingResponse new];
	
	azads2_serverBinding_envelope *envelope = [azads2_serverBinding_envelope sharedInstance];
	
	NSMutableDictionary *headerElements = nil;
	headerElements = [NSMutableDictionary dictionary];
	
	NSMutableDictionary *bodyElements = nil;
	bodyElements = [NSMutableDictionary dictionary];
	if(login_hash8 != nil) [bodyElements setObject:login_hash8 forKey:@"login_hash8"];
	if(affiliate_id11 != nil) [bodyElements setObject:affiliate_id11 forKey:@"affiliate_id11"];
	if(offer_id7 != nil) [bodyElements setObject:offer_id7 forKey:@"offer_id7"];
	if(traffic_type_id6 != nil) [bodyElements setObject:traffic_type_id6 forKey:@"traffic_type_id6"];
	if(sub_id4 != nil) [bodyElements setObject:sub_id4 forKey:@"sub_id4"];
	
	NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
	
	[binding sendHTTPCallUsingBody:operationXMLString soapAction:@"urn:azads2_server#generateClickUrl" forOperation:self];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if (responseData != nil && delegate != nil)
	{
		xmlDocPtr doc;
		xmlNodePtr cur;
		
		if (binding.logXMLInOut) {
			NSLog(@"ResponseBody:\n%@", [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease]);
		}
		
		doc = xmlParseMemory([responseData bytes], [responseData length]);
		
		if (doc == NULL) {
			NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Errors while parsing returned XML" forKey:NSLocalizedDescriptionKey];
			
			response.error = [NSError errorWithDomain:@"azads2_serverBindingResponseXML" code:1 userInfo:userInfo];
			[delegate operation:self completedWithResponse:response];
		} else {
			cur = xmlDocGetRootElement(doc);
			cur = cur->children;
			
			for( ; cur != NULL ; cur = cur->next) {
				if(cur->type == XML_ELEMENT_NODE) {
					
					if(xmlStrEqual(cur->name, (const xmlChar *) "Body")) {
						NSMutableArray *responseBodyParts = [NSMutableArray array];
						
						xmlNodePtr bodyNode;
						for(bodyNode=cur->children ; bodyNode != NULL ; bodyNode = bodyNode->next) {
							if(cur->type == XML_ELEMENT_NODE) {
								if(xmlStrEqual(bodyNode->name, (const xmlChar *) "generateClickUrlReturn")) {
									NSString  *bodyObject = [NSString  deserializeNode:bodyNode];
									//NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
									if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
								}
								if (xmlStrEqual(bodyNode->ns->prefix, cur->ns->prefix) && 
									xmlStrEqual(bodyNode->name, (const xmlChar *) "Fault")) {
									SOAPFault *bodyObject = [SOAPFault deserializeNode:bodyNode];
									//NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
									if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
								}
							}
						}
						
						response.bodyParts = responseBodyParts;
					}
				}
			}
			
			xmlFreeDoc(doc);
		}
		
		xmlCleanupParser();
		[delegate operation:self completedWithResponse:response];
	}
}
@end
@implementation azads2_serverBinding_logout
@synthesize login_hash6;
@synthesize affiliate_id9;
- (id)initWithBinding:(azads2_serverBinding *)aBinding delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate
login_hash6:(NSString *)aLogin_hash6
affiliate_id9:(NSNumber *)aAffiliate_id9
{
	if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
		self.login_hash6 = aLogin_hash6;
		self.affiliate_id9 = aAffiliate_id9;
	}
	
	return self;
}
- (void)dealloc
{
	if(login_hash6 != nil) [login_hash6 release];
	if(affiliate_id9 != nil) [affiliate_id9 release];
	
	[super dealloc];
}
- (void)main
{
	[response autorelease];
	response = [azads2_serverBindingResponse new];
	
	azads2_serverBinding_envelope *envelope = [azads2_serverBinding_envelope sharedInstance];
	
	NSMutableDictionary *headerElements = nil;
	headerElements = [NSMutableDictionary dictionary];
	
	NSMutableDictionary *bodyElements = nil;
	bodyElements = [NSMutableDictionary dictionary];
	if(login_hash6 != nil) [bodyElements setObject:login_hash6 forKey:@"login_hash6"];
	if(affiliate_id9 != nil) [bodyElements setObject:affiliate_id9 forKey:@"affiliate_id9"];
	
	NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
	
	[binding sendHTTPCallUsingBody:operationXMLString soapAction:@"urn:azads2_server#logout" forOperation:self];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if (responseData != nil && delegate != nil)
	{
		xmlDocPtr doc;
		xmlNodePtr cur;
		
		if (binding.logXMLInOut) {
			NSLog(@"ResponseBody:\n%@", [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease]);
		}
		
		doc = xmlParseMemory([responseData bytes], [responseData length]);
		
		if (doc == NULL) {
			NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Errors while parsing returned XML" forKey:NSLocalizedDescriptionKey];
			
			response.error = [NSError errorWithDomain:@"azads2_serverBindingResponseXML" code:1 userInfo:userInfo];
			[delegate operation:self completedWithResponse:response];
		} else {
			cur = xmlDocGetRootElement(doc);
			cur = cur->children;
			
			for( ; cur != NULL ; cur = cur->next) {
				if(cur->type == XML_ELEMENT_NODE) {
					
					if(xmlStrEqual(cur->name, (const xmlChar *) "Body")) {
						NSMutableArray *responseBodyParts = [NSMutableArray array];
						
						xmlNodePtr bodyNode;
						for(bodyNode=cur->children ; bodyNode != NULL ; bodyNode = bodyNode->next) {
							if(cur->type == XML_ELEMENT_NODE) {
								if(xmlStrEqual(bodyNode->name, (const xmlChar *) "logoutReturn")) {
									NSString  *bodyObject = [NSString  deserializeNode:bodyNode];
									//NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
									if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
								}
								if (xmlStrEqual(bodyNode->ns->prefix, cur->ns->prefix) && 
									xmlStrEqual(bodyNode->name, (const xmlChar *) "Fault")) {
									SOAPFault *bodyObject = [SOAPFault deserializeNode:bodyNode];
									//NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
									if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
								}
							}
						}
						
						response.bodyParts = responseBodyParts;
					}
				}
			}
			
			xmlFreeDoc(doc);
		}
		
		xmlCleanupParser();
		[delegate operation:self completedWithResponse:response];
	}
}
@end
@implementation azads2_serverBinding_offerDetails
@synthesize login_hash7;
@synthesize affiliate_id10;
@synthesize offer_id6;
@synthesize traffic_type_id5;
@synthesize sub_id3;
@synthesize suppression_delimiter;
@synthesize keyword_delimiter;
- (id)initWithBinding:(azads2_serverBinding *)aBinding delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate
login_hash7:(NSString *)aLogin_hash7
affiliate_id10:(NSNumber *)aAffiliate_id10
offer_id6:(NSNumber *)aOffer_id6
traffic_type_id5:(NSNumber *)aTraffic_type_id5
sub_id3:(NSString *)aSub_id3
suppression_delimiter:(NSString *)aSuppression_delimiter
keyword_delimiter:(NSString *)aKeyword_delimiter
{
	if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
		self.login_hash7 = aLogin_hash7;
		self.affiliate_id10 = aAffiliate_id10;
		self.offer_id6 = aOffer_id6;
		self.traffic_type_id5 = aTraffic_type_id5;
		self.sub_id3 = aSub_id3;
		self.suppression_delimiter = aSuppression_delimiter;
		self.keyword_delimiter = aKeyword_delimiter;
	}
	
	return self;
}
- (void)dealloc
{
	if(login_hash7 != nil) [login_hash7 release];
	if(affiliate_id10 != nil) [affiliate_id10 release];
	if(offer_id6 != nil) [offer_id6 release];
	if(traffic_type_id5 != nil) [traffic_type_id5 release];
	if(sub_id3 != nil) [sub_id3 release];
	if(suppression_delimiter != nil) [suppression_delimiter release];
	if(keyword_delimiter != nil) [keyword_delimiter release];
	
	[super dealloc];
}
- (void)main
{
	[response autorelease];
	response = [azads2_serverBindingResponse new];
	
	azads2_serverBinding_envelope *envelope = [azads2_serverBinding_envelope sharedInstance];
	
	NSMutableDictionary *headerElements = nil;
	headerElements = [NSMutableDictionary dictionary];
	
	NSMutableDictionary *bodyElements = nil;
	bodyElements = [NSMutableDictionary dictionary];
	if(login_hash7 != nil) [bodyElements setObject:login_hash7 forKey:@"login_hash7"];
	if(affiliate_id10 != nil) [bodyElements setObject:affiliate_id10 forKey:@"affiliate_id10"];
	if(offer_id6 != nil) [bodyElements setObject:offer_id6 forKey:@"offer_id6"];
	if(traffic_type_id5 != nil) [bodyElements setObject:traffic_type_id5 forKey:@"traffic_type_id5"];
	if(sub_id3 != nil) [bodyElements setObject:sub_id3 forKey:@"sub_id3"];
	if(suppression_delimiter != nil) [bodyElements setObject:suppression_delimiter forKey:@"suppression_delimiter"];
	if(keyword_delimiter != nil) [bodyElements setObject:keyword_delimiter forKey:@"keyword_delimiter"];
	
	NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
	
	[binding sendHTTPCallUsingBody:operationXMLString soapAction:@"urn:azads2_server#offerDetails" forOperation:self];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if (responseData != nil && delegate != nil)
	{
		xmlDocPtr doc;
		xmlNodePtr cur;
		
		if (binding.logXMLInOut) {
			NSLog(@"ResponseBody:\n%@", [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease]);
		}
		
		doc = xmlParseMemory([responseData bytes], [responseData length]);
		
		if (doc == NULL) {
			NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Errors while parsing returned XML" forKey:NSLocalizedDescriptionKey];
			
			response.error = [NSError errorWithDomain:@"azads2_serverBindingResponseXML" code:1 userInfo:userInfo];
			[delegate operation:self completedWithResponse:response];
		} else {
			cur = xmlDocGetRootElement(doc);
			cur = cur->children;
			
			for( ; cur != NULL ; cur = cur->next) {
				if(cur->type == XML_ELEMENT_NODE) {
					
					if(xmlStrEqual(cur->name, (const xmlChar *) "Body")) {
						NSMutableArray *responseBodyParts = [NSMutableArray array];
						
						xmlNodePtr bodyNode;
						for(bodyNode=cur->children ; bodyNode != NULL ; bodyNode = bodyNode->next) {
							if(cur->type == XML_ELEMENT_NODE) {
								if(xmlStrEqual(bodyNode->name, (const xmlChar *) "offerDetailsReturn")) {
									NSString  *bodyObject = [NSString  deserializeNode:bodyNode];
									//NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
									if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
								}
								if (xmlStrEqual(bodyNode->ns->prefix, cur->ns->prefix) && 
									xmlStrEqual(bodyNode->name, (const xmlChar *) "Fault")) {
									SOAPFault *bodyObject = [SOAPFault deserializeNode:bodyNode];
									//NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
									if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
								}
							}
						}
						
						response.bodyParts = responseBodyParts;
					}
				}
			}
			
			xmlFreeDoc(doc);
		}
		
		xmlCleanupParser();
		[delegate operation:self completedWithResponse:response];
	}
}
@end
@implementation azads2_serverBinding_listOffers
@synthesize login_hash7;
@synthesize affiliate_id10;
- (id)initWithBinding:(azads2_serverBinding *)aBinding delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate
login_hash7:(NSString *)aLogin_hash7
affiliate_id10:(NSNumber *)aAffiliate_id10
{
	if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
		self.login_hash7 = aLogin_hash7;
		self.affiliate_id10 = aAffiliate_id10;
	}
	
	return self;
}
- (void)dealloc
{
	if(login_hash7 != nil) [login_hash7 release];
	if(affiliate_id10 != nil) [affiliate_id10 release];
	
	[super dealloc];
}
- (void)main
{
	[response autorelease];
	response = [azads2_serverBindingResponse new];
	
	azads2_serverBinding_envelope *envelope = [azads2_serverBinding_envelope sharedInstance];
	
	NSMutableDictionary *headerElements = nil;
	headerElements = [NSMutableDictionary dictionary];
	
	NSMutableDictionary *bodyElements = nil;
	bodyElements = [NSMutableDictionary dictionary];
	if(login_hash7 != nil) [bodyElements setObject:login_hash7 forKey:@"login_hash7"];
	if(affiliate_id10 != nil) [bodyElements setObject:affiliate_id10 forKey:@"affiliate_id10"];
	
	NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
	
	[binding sendHTTPCallUsingBody:operationXMLString soapAction:@"urn:azads2_server#listOffers" forOperation:self];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if (responseData != nil && delegate != nil)
	{
		xmlDocPtr doc;
		xmlNodePtr cur;
		
		if (binding.logXMLInOut) {
			NSLog(@"ResponseBody:\n%@", [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease]);
		}
		
		doc = xmlParseMemory([responseData bytes], [responseData length]);
		
		if (doc == NULL) {
			NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Errors while parsing returned XML" forKey:NSLocalizedDescriptionKey];
			
			response.error = [NSError errorWithDomain:@"azads2_serverBindingResponseXML" code:1 userInfo:userInfo];
			[delegate operation:self completedWithResponse:response];
		} else {
			cur = xmlDocGetRootElement(doc);
			cur = cur->children;
			
			for( ; cur != NULL ; cur = cur->next) {
				if(cur->type == XML_ELEMENT_NODE) {
					
					if(xmlStrEqual(cur->name, (const xmlChar *) "Body")) {
						NSMutableArray *responseBodyParts = [NSMutableArray array];
						
						xmlNodePtr bodyNode;
						for(bodyNode=cur->children ; bodyNode != NULL ; bodyNode = bodyNode->next) {
							if(cur->type == XML_ELEMENT_NODE) {
								if(xmlStrEqual(bodyNode->name, (const xmlChar *) "listOffersReturn")) {
									NSString  *bodyObject = [NSString  deserializeNode:bodyNode];
									//NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
									if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
								}
								if (xmlStrEqual(bodyNode->ns->prefix, cur->ns->prefix) && 
									xmlStrEqual(bodyNode->name, (const xmlChar *) "Fault")) {
									SOAPFault *bodyObject = [SOAPFault deserializeNode:bodyNode];
									//NSAssert1(bodyObject != nil, @"Errors while parsing body %s", bodyNode->name);
									if (bodyObject != nil) [responseBodyParts addObject:bodyObject];
								}
							}
						}
						
						response.bodyParts = responseBodyParts;
					}
				}
			}
			
			xmlFreeDoc(doc);
		}
		
		xmlCleanupParser();
		[delegate operation:self completedWithResponse:response];
	}
}
@end
static azads2_serverBinding_envelope *azads2_serverBindingSharedEnvelopeInstance = nil;
@implementation azads2_serverBinding_envelope
+ (azads2_serverBinding_envelope *)sharedInstance
{
	if(azads2_serverBindingSharedEnvelopeInstance == nil) {
		azads2_serverBindingSharedEnvelopeInstance = [azads2_serverBinding_envelope new];
	}
	
	return azads2_serverBindingSharedEnvelopeInstance;
}
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements
{
    xmlDocPtr doc;
	
	doc = xmlNewDoc((const xmlChar*)XML_DEFAULT_VERSION);
	if (doc == NULL) {
		NSLog(@"Error creating the xml document tree");
		return @"";
	}
	
	xmlNodePtr root = xmlNewDocNode(doc, NULL, (const xmlChar*)"Envelope", NULL);
	xmlDocSetRootElement(doc, root);
	
	xmlNsPtr soapEnvelopeNs = xmlNewNs(root, (const xmlChar*)"http://schemas.xmlsoap.org/soap/envelope/", (const xmlChar*)"soap");
	xmlSetNs(root, soapEnvelopeNs);
	
	xmlNsPtr xslNs = xmlNewNs(root, (const xmlChar*)"http://www.w3.org/1999/XSL/Transform", (const xmlChar*)"xsl");
	xmlNewNs(root, (const xmlChar*)"http://www.w3.org/2001/XMLSchema-instance", (const xmlChar*)"xsi");
	
	xmlNewNsProp(root, xslNs, (const xmlChar*)"version", (const xmlChar*)"1.0");
	
	xmlNewNs(root, (const xmlChar*)"http://www.w3.org/2001/XMLSchema", (const xmlChar*)"xsd");
	xmlNewNs(root, (const xmlChar*)"urn:azads2_server", (const xmlChar*)"azads2_serverSvc");
	xmlNewNs(root, (const xmlChar*)"urn:hellowsdl", (const xmlChar*)"ns1");
	xmlNewNs(root, (const xmlChar*)"http://schemas.xmlsoap.org/soap/encoding/", (const xmlChar*)"ns2");
	xmlNewNs(root, (const xmlChar*)"http://schemas.xmlsoap.org/wsdl/", (const xmlChar*)"ns3");
	
	if((headerElements != nil) && ([headerElements count] > 0)) {
		xmlNodePtr headerNode = xmlNewDocNode(doc, soapEnvelopeNs, (const xmlChar*)"Header", NULL);
		xmlAddChild(root, headerNode);
		
		for(NSString *key in [headerElements allKeys]) {
			id header = [headerElements objectForKey:key];
			xmlAddChild(headerNode, [header xmlNodeForDoc:doc elementName:key elementNSPrefix:nil]);
		}
	}
	
	if((bodyElements != nil) && ([bodyElements count] > 0)) {
		xmlNodePtr bodyNode = xmlNewDocNode(doc, soapEnvelopeNs, (const xmlChar*)"Body", NULL);
		xmlAddChild(root, bodyNode);
		
		for(NSString *key in [bodyElements allKeys]) {
			id body = [bodyElements objectForKey:key];
			xmlAddChild(bodyNode, [body xmlNodeForDoc:doc elementName:key elementNSPrefix:nil]);
		}
	}
	
	xmlChar *buf;
	int size;
	xmlDocDumpFormatMemory(doc, &buf, &size, 1);
	
	NSString *serializedForm = [NSString stringWithCString:(const char*)buf encoding:NSUTF8StringEncoding];
	xmlFree(buf);
	
	xmlFreeDoc(doc);	
	return serializedForm;
}
@end
@implementation azads2_serverBindingResponse
@synthesize headers;
@synthesize bodyParts;
@synthesize error;
- (id)init
{
	if((self = [super init])) {
		headers = nil;
		bodyParts = nil;
		error = nil;
	}
	
	return self;
}
-(void)dealloc {
    self.headers = nil;
    self.bodyParts = nil;
    self.error = nil;	
    [super dealloc];
}
@end
