#import "DirectTrackWebServicesSvc.h"
#import <libxml/xmlstring.h>
#if TARGET_OS_IPHONE
#import <CFNetwork/CFNetwork.h>
#endif
@implementation DirectTrackWebServicesSvc
+ (void)initialize
{
	[[USGlobals sharedInstance].wsdlStandardNamespaces setObject:@"xsd" forKey:@"http://www.w3.org/2001/XMLSchema"];
	[[USGlobals sharedInstance].wsdlStandardNamespaces setObject:@"DirectTrackWebServicesSvc" forKey:@"http://soapinterop.org/"];
	[[USGlobals sharedInstance].wsdlStandardNamespaces setObject:@"ns1" forKey:@"http://schemas.xmlsoap.org/soap/encoding/"];
	[[USGlobals sharedInstance].wsdlStandardNamespaces setObject:@"ns2" forKey:@"http://schemas.xmlsoap.org/wsdl/"];
}
+ (DirectTrackWebServicesBinding *)DirectTrackWebServicesBinding
{
	return [[[DirectTrackWebServicesBinding alloc] initWithAddress:@"http://publishers.clickbooth.com/api/soap_affiliate.php"] autorelease];
}
@end
@implementation DirectTrackWebServicesBinding
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
- (DirectTrackWebServicesBindingResponse *)performSynchronousOperation:(DirectTrackWebServicesBindingOperation *)operation
{
	synchronousOperationComplete = NO;
	[operation start];
	
	// Now wait for response
	NSRunLoop *theRL = [NSRunLoop currentRunLoop];
	
	while (!synchronousOperationComplete && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
	return operation.response;
}
- (void)performAsynchronousOperation:(DirectTrackWebServicesBindingOperation *)operation
{
	[operation start];
}
- (void) operation:(DirectTrackWebServicesBindingOperation *)operation completedWithResponse:(DirectTrackWebServicesBindingResponse *)response
{
	synchronousOperationComplete = YES;
}
- (DirectTrackWebServicesBindingResponse *)creativeTypesUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword 
{
	return [self performSynchronousOperation:[[(DirectTrackWebServicesBinding_creativeTypes*)[DirectTrackWebServicesBinding_creativeTypes alloc] initWithBinding:self delegate:self
																							client:aClient
																							add_code:aAdd_code
																							password:aPassword
																							] autorelease]];
}
- (void)creativeTypesAsyncUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword  delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate
{
	[self performAsynchronousOperation: [[(DirectTrackWebServicesBinding_creativeTypes*)[DirectTrackWebServicesBinding_creativeTypes alloc] initWithBinding:self delegate:responseDelegate
																							 client:aClient
																							 add_code:aAdd_code
																							 password:aPassword
																							 ] autorelease]];
}
- (DirectTrackWebServicesBindingResponse *)campaignInfoUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword program_id:(NSNumber *)aProgram_id ignore_campaign_images:(NSString *)aIgnore_campaign_images category:(NSString *)aCategory 
{
	return [self performSynchronousOperation:[[(DirectTrackWebServicesBinding_campaignInfo*)[DirectTrackWebServicesBinding_campaignInfo alloc] initWithBinding:self delegate:self
																							client:aClient
																							add_code:aAdd_code
																							password:aPassword
																							program_id:aProgram_id
																							ignore_campaign_images:aIgnore_campaign_images
																							category:aCategory
																							] autorelease]];
}
- (void)campaignInfoAsyncUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword program_id:(NSNumber *)aProgram_id ignore_campaign_images:(NSString *)aIgnore_campaign_images category:(NSString *)aCategory  delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate
{
	[self performAsynchronousOperation: [[(DirectTrackWebServicesBinding_campaignInfo*)[DirectTrackWebServicesBinding_campaignInfo alloc] initWithBinding:self delegate:responseDelegate
																							 client:aClient
																							 add_code:aAdd_code
																							 password:aPassword
																							 program_id:aProgram_id
																							 ignore_campaign_images:aIgnore_campaign_images
																							 category:aCategory
																							 ] autorelease]];
}
- (DirectTrackWebServicesBindingResponse *)creativeInfoUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword program_id:(NSNumber *)aProgram_id opt_info:(NSString *)aOpt_info creativeTypeId:(NSNumber *)aCreativeTypeId search_criteria:(NSString *)aSearch_criteria agreed_to_terms:(NSNumber *)aAgreed_to_terms 
{
	return [self performSynchronousOperation:[[(DirectTrackWebServicesBinding_creativeInfo*)[DirectTrackWebServicesBinding_creativeInfo alloc] initWithBinding:self delegate:self
																							client:aClient
																							add_code:aAdd_code
																							password:aPassword
																							program_id:aProgram_id
																							opt_info:aOpt_info
																							creativeTypeId:aCreativeTypeId
																							search_criteria:aSearch_criteria
																							agreed_to_terms:aAgreed_to_terms
																							] autorelease]];
}
- (void)creativeInfoAsyncUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword program_id:(NSNumber *)aProgram_id opt_info:(NSString *)aOpt_info creativeTypeId:(NSNumber *)aCreativeTypeId search_criteria:(NSString *)aSearch_criteria agreed_to_terms:(NSNumber *)aAgreed_to_terms  delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate
{
	[self performAsynchronousOperation: [[(DirectTrackWebServicesBinding_creativeInfo*)[DirectTrackWebServicesBinding_creativeInfo alloc] initWithBinding:self delegate:responseDelegate
																							 client:aClient
																							 add_code:aAdd_code
																							 password:aPassword
																							 program_id:aProgram_id
																							 opt_info:aOpt_info
																							 creativeTypeId:aCreativeTypeId
																							 search_criteria:aSearch_criteria
																							 agreed_to_terms:aAgreed_to_terms
																							 ] autorelease]];
}
- (DirectTrackWebServicesBindingResponse *)optionalInfoUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword start_date:(NSString *)aStart_date end_date:(NSString *)aEnd_date program_id:(NSNumber *)aProgram_id opt_info:(NSString *)aOpt_info 
{
	return [self performSynchronousOperation:[[(DirectTrackWebServicesBinding_optionalInfo*)[DirectTrackWebServicesBinding_optionalInfo alloc] initWithBinding:self delegate:self
																							client:aClient
																							add_code:aAdd_code
																							password:aPassword
																							start_date:aStart_date
																							end_date:aEnd_date
																							program_id:aProgram_id
																							opt_info:aOpt_info
																							] autorelease]];
}
- (void)optionalInfoAsyncUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword start_date:(NSString *)aStart_date end_date:(NSString *)aEnd_date program_id:(NSNumber *)aProgram_id opt_info:(NSString *)aOpt_info  delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate
{
	[self performAsynchronousOperation: [[(DirectTrackWebServicesBinding_optionalInfo*)[DirectTrackWebServicesBinding_optionalInfo alloc] initWithBinding:self delegate:responseDelegate
																							 client:aClient
																							 add_code:aAdd_code
																							 password:aPassword
																							 start_date:aStart_date
																							 end_date:aEnd_date
																							 program_id:aProgram_id
																							 opt_info:aOpt_info
																							 ] autorelease]];
}
- (DirectTrackWebServicesBindingResponse *)monthlyStatsInfoUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword start_date:(NSString *)aStart_date end_date:(NSString *)aEnd_date program_id:(NSNumber *)aProgram_id 
{
	return [self performSynchronousOperation:[[(DirectTrackWebServicesBinding_monthlyStatsInfo*)[DirectTrackWebServicesBinding_monthlyStatsInfo alloc] initWithBinding:self delegate:self
																							client:aClient
																							add_code:aAdd_code
																							password:aPassword
																							start_date:aStart_date
																							end_date:aEnd_date
																							program_id:aProgram_id
																							] autorelease]];
}
- (void)monthlyStatsInfoAsyncUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword start_date:(NSString *)aStart_date end_date:(NSString *)aEnd_date program_id:(NSNumber *)aProgram_id  delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate
{
	[self performAsynchronousOperation: [[(DirectTrackWebServicesBinding_monthlyStatsInfo*)[DirectTrackWebServicesBinding_monthlyStatsInfo alloc] initWithBinding:self delegate:responseDelegate
																							 client:aClient
																							 add_code:aAdd_code
																							 password:aPassword
																							 start_date:aStart_date
																							 end_date:aEnd_date
																							 program_id:aProgram_id
																							 ] autorelease]];
}
- (DirectTrackWebServicesBindingResponse *)dailyStatsInfoUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword start_date:(NSString *)aStart_date end_date:(NSString *)aEnd_date program_id:(NSNumber *)aProgram_id 
{
	return [self performSynchronousOperation:[[(DirectTrackWebServicesBinding_dailyStatsInfo*)[DirectTrackWebServicesBinding_dailyStatsInfo alloc] initWithBinding:self delegate:self
																							client:aClient
																							add_code:aAdd_code
																							password:aPassword
																							start_date:aStart_date
																							end_date:aEnd_date
																							program_id:aProgram_id
																							] autorelease]];
}
- (void)dailyStatsInfoAsyncUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword start_date:(NSString *)aStart_date end_date:(NSString *)aEnd_date program_id:(NSNumber *)aProgram_id  delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate
{
	[self performAsynchronousOperation: [[(DirectTrackWebServicesBinding_dailyStatsInfo*)[DirectTrackWebServicesBinding_dailyStatsInfo alloc] initWithBinding:self delegate:responseDelegate
																							 client:aClient
																							 add_code:aAdd_code
																							 password:aPassword
																							 start_date:aStart_date
																							 end_date:aEnd_date
																							 program_id:aProgram_id
																							 ] autorelease]];
}
- (DirectTrackWebServicesBindingResponse *)getCCampaignsUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword pool_id:(NSString *)aPool_id info:(NSString *)aInfo 
{
	return [self performSynchronousOperation:[[(DirectTrackWebServicesBinding_getCCampaigns*)[DirectTrackWebServicesBinding_getCCampaigns alloc] initWithBinding:self delegate:self
																							client:aClient
																							add_code:aAdd_code
																							password:aPassword
																							pool_id:aPool_id
																							info:aInfo
																							] autorelease]];
}
- (void)getCCampaignsAsyncUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword pool_id:(NSString *)aPool_id info:(NSString *)aInfo  delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate
{
	[self performAsynchronousOperation: [[(DirectTrackWebServicesBinding_getCCampaigns*)[DirectTrackWebServicesBinding_getCCampaigns alloc] initWithBinding:self delegate:responseDelegate
																							 client:aClient
																							 add_code:aAdd_code
																							 password:aPassword
																							 pool_id:aPool_id
																							 info:aInfo
																							 ] autorelease]];
}
- (DirectTrackWebServicesBindingResponse *)recordHostedLeadUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword lead:(NSString *)aLead 
{
	return [self performSynchronousOperation:[[(DirectTrackWebServicesBinding_recordHostedLead*)[DirectTrackWebServicesBinding_recordHostedLead alloc] initWithBinding:self delegate:self
																							client:aClient
																							add_code:aAdd_code
																							password:aPassword
																							lead:aLead
																							] autorelease]];
}
- (void)recordHostedLeadAsyncUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword lead:(NSString *)aLead  delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate
{
	[self performAsynchronousOperation: [[(DirectTrackWebServicesBinding_recordHostedLead*)[DirectTrackWebServicesBinding_recordHostedLead alloc] initWithBinding:self delegate:responseDelegate
																							 client:aClient
																							 add_code:aAdd_code
																							 password:aPassword
																							 lead:aLead
																							 ] autorelease]];
}
- (DirectTrackWebServicesBindingResponse *)getAffiliateAggregateStatisticsUsingClient:(NSString *)aClient password:(NSString *)aPassword add_code:(NSString *)aAdd_code start_date:(NSDate *)aStart_date end_date:(NSDate *)aEnd_date campaign_id:(NSNumber *)aCampaign_id 
{
	return [self performSynchronousOperation:[[(DirectTrackWebServicesBinding_getAffiliateAggregateStatistics*)[DirectTrackWebServicesBinding_getAffiliateAggregateStatistics alloc] initWithBinding:self delegate:self
																							client:aClient
																							password:aPassword
																							add_code:aAdd_code
																							start_date:aStart_date
																							end_date:aEnd_date
																							campaign_id:aCampaign_id
																							] autorelease]];
}
- (void)getAffiliateAggregateStatisticsAsyncUsingClient:(NSString *)aClient password:(NSString *)aPassword add_code:(NSString *)aAdd_code start_date:(NSDate *)aStart_date end_date:(NSDate *)aEnd_date campaign_id:(NSNumber *)aCampaign_id  delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate
{
	[self performAsynchronousOperation: [[(DirectTrackWebServicesBinding_getAffiliateAggregateStatistics*)[DirectTrackWebServicesBinding_getAffiliateAggregateStatistics alloc] initWithBinding:self delegate:responseDelegate
																							 client:aClient
																							 password:aPassword
																							 add_code:aAdd_code
																							 start_date:aStart_date
																							 end_date:aEnd_date
																							 campaign_id:aCampaign_id
																							 ] autorelease]];
}
- (DirectTrackWebServicesBindingResponse *)getAffiliateDeployStatisticsUsingClient:(NSString *)aClient password:(NSString *)aPassword add_code:(NSString *)aAdd_code start_date:(NSDate *)aStart_date end_date:(NSDate *)aEnd_date campaign_id:(NSNumber *)aCampaign_id 
{
	return [self performSynchronousOperation:[[(DirectTrackWebServicesBinding_getAffiliateDeployStatistics*)[DirectTrackWebServicesBinding_getAffiliateDeployStatistics alloc] initWithBinding:self delegate:self
																							client:aClient
																							password:aPassword
																							add_code:aAdd_code
																							start_date:aStart_date
																							end_date:aEnd_date
																							campaign_id:aCampaign_id
																							] autorelease]];
}
- (void)getAffiliateDeployStatisticsAsyncUsingClient:(NSString *)aClient password:(NSString *)aPassword add_code:(NSString *)aAdd_code start_date:(NSDate *)aStart_date end_date:(NSDate *)aEnd_date campaign_id:(NSNumber *)aCampaign_id  delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate
{
	[self performAsynchronousOperation: [[(DirectTrackWebServicesBinding_getAffiliateDeployStatistics*)[DirectTrackWebServicesBinding_getAffiliateDeployStatistics alloc] initWithBinding:self delegate:responseDelegate
																							 client:aClient
																							 password:aPassword
																							 add_code:aAdd_code
																							 start_date:aStart_date
																							 end_date:aEnd_date
																							 campaign_id:aCampaign_id
																							 ] autorelease]];
}
- (DirectTrackWebServicesBindingResponse *)getSubIDStatsUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword primary:(NSString *)aPrimary secondary:(NSString *)aSecondary tertiary:(NSString *)aTertiary quaternary:(NSString *)aQuaternary keyword:(NSString *)aKeyword program_id:(NSNumber *)aProgram_id start_date:(NSDate *)aStart_date end_date:(NSDate *)aEnd_date 
{
	return [self performSynchronousOperation:[[(DirectTrackWebServicesBinding_getSubIDStats*)[DirectTrackWebServicesBinding_getSubIDStats alloc] initWithBinding:self delegate:self
																							client:aClient
																							add_code:aAdd_code
																							password:aPassword
																							primary:aPrimary
																							secondary:aSecondary
																							tertiary:aTertiary
																							quaternary:aQuaternary
																							keyword:aKeyword
																							program_id:aProgram_id
																							start_date:aStart_date
																							end_date:aEnd_date
																							] autorelease]];
}
- (void)getSubIDStatsAsyncUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword primary:(NSString *)aPrimary secondary:(NSString *)aSecondary tertiary:(NSString *)aTertiary quaternary:(NSString *)aQuaternary keyword:(NSString *)aKeyword program_id:(NSNumber *)aProgram_id start_date:(NSDate *)aStart_date end_date:(NSDate *)aEnd_date  delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate
{
	[self performAsynchronousOperation: [[(DirectTrackWebServicesBinding_getSubIDStats*)[DirectTrackWebServicesBinding_getSubIDStats alloc] initWithBinding:self delegate:responseDelegate
																							 client:aClient
																							 add_code:aAdd_code
																							 password:aPassword
																							 primary:aPrimary
																							 secondary:aSecondary
																							 tertiary:aTertiary
																							 quaternary:aQuaternary
																							 keyword:aKeyword
																							 program_id:aProgram_id
																							 start_date:aStart_date
																							 end_date:aEnd_date
																							 ] autorelease]];
}
- (void)sendHTTPCallUsingBody:(NSString *)outputBody soapAction:(NSString *)soapAction forOperation:(DirectTrackWebServicesBindingOperation *)operation
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
@implementation DirectTrackWebServicesBindingOperation
@synthesize binding;
@synthesize response;
@synthesize delegate;
@synthesize responseData;
@synthesize urlConnection;
- (id)initWithBinding:(DirectTrackWebServicesBinding *)aBinding delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)aDelegate
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
				
			error = [NSError errorWithDomain:@"DirectTrackWebServicesBindingResponseHTTP" code:[httpResponse statusCode] userInfo:userInfo];
		} else {
                        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
	 												[NSString stringWithFormat: @"Unexpected response MIME type to SOAP call:%@", urlResponse.MIMEType],NSLocalizedDescriptionKey,
                                                                          httpResponse.URL.absoluteString, @"URL",nil];
			error = [NSError errorWithDomain:@"DirectTrackWebServicesBindingResponseHTTP" code:1 userInfo:userInfo];
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
@implementation DirectTrackWebServicesBinding_creativeTypes
@synthesize client;
@synthesize add_code;
@synthesize password;
- (id)initWithBinding:(DirectTrackWebServicesBinding *)aBinding delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate
client:(NSString *)aClient
add_code:(NSString *)aAdd_code
password:(NSString *)aPassword
{
	if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
		self.client = aClient;
		self.add_code = aAdd_code;
		self.password = aPassword;
	}
	
	return self;
}
- (void)dealloc
{
	if(client != nil) [client release];
	if(add_code != nil) [add_code release];
	if(password != nil) [password release];
	
	[super dealloc];
}
- (void)main
{
	[response autorelease];
	response = [DirectTrackWebServicesBindingResponse new];
	
	DirectTrackWebServicesBinding_envelope *envelope = [DirectTrackWebServicesBinding_envelope sharedInstance];
	
	NSMutableDictionary *headerElements = nil;
	headerElements = [NSMutableDictionary dictionary];
	
	NSMutableDictionary *bodyElements = nil;
	bodyElements = [NSMutableDictionary dictionary];
	if(client != nil) [bodyElements setObject:client forKey:@"client"];
	if(add_code != nil) [bodyElements setObject:add_code forKey:@"add_code"];
	if(password != nil) [bodyElements setObject:password forKey:@"password"];
	
	NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
	
	[binding sendHTTPCallUsingBody:operationXMLString soapAction:@"http://publishers.clickbooth.com/api/soap_affiliate.php/creativeTypes" forOperation:self];
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
			
			response.error = [NSError errorWithDomain:@"DirectTrackWebServicesBindingResponseXML" code:1 userInfo:userInfo];
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
								if(xmlStrEqual(bodyNode->name, (const xmlChar *) "return")) {
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
@implementation DirectTrackWebServicesBinding_campaignInfo
@synthesize client;
@synthesize add_code;
@synthesize password;
@synthesize program_id;
@synthesize ignore_campaign_images;
@synthesize category;
- (id)initWithBinding:(DirectTrackWebServicesBinding *)aBinding delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate
client:(NSString *)aClient
add_code:(NSString *)aAdd_code
password:(NSString *)aPassword
program_id:(NSNumber *)aProgram_id
ignore_campaign_images:(NSString *)aIgnore_campaign_images
category:(NSString *)aCategory
{
	if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
		self.client = aClient;
		self.add_code = aAdd_code;
		self.password = aPassword;
		self.program_id = aProgram_id;
		self.ignore_campaign_images = aIgnore_campaign_images;
		self.category = aCategory;
	}
	
	return self;
}
- (void)dealloc
{
	if(client != nil) [client release];
	if(add_code != nil) [add_code release];
	if(password != nil) [password release];
	if(program_id != nil) [program_id release];
	if(ignore_campaign_images != nil) [ignore_campaign_images release];
	if(category != nil) [category release];
	
	[super dealloc];
}
- (void)main
{
	[response autorelease];
	response = [DirectTrackWebServicesBindingResponse new];
	
	DirectTrackWebServicesBinding_envelope *envelope = [DirectTrackWebServicesBinding_envelope sharedInstance];
	
	NSMutableDictionary *headerElements = nil;
	headerElements = [NSMutableDictionary dictionary];
	
	NSMutableDictionary *bodyElements = nil;
	bodyElements = [NSMutableDictionary dictionary];
	if(client != nil) [bodyElements setObject:client forKey:@"client"];
	if(add_code != nil) [bodyElements setObject:add_code forKey:@"add_code"];
	if(password != nil) [bodyElements setObject:password forKey:@"password"];
	if(program_id != nil) [bodyElements setObject:program_id forKey:@"program_id"];
	if(ignore_campaign_images != nil) [bodyElements setObject:ignore_campaign_images forKey:@"ignore_campaign_images"];
	if(category != nil) [bodyElements setObject:category forKey:@"category"];
	
	NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
	
	[binding sendHTTPCallUsingBody:operationXMLString soapAction:@"http://publishers.clickbooth.com/api/soap_affiliate.php/campaignInfo" forOperation:self];
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
			
			response.error = [NSError errorWithDomain:@"DirectTrackWebServicesBindingResponseXML" code:1 userInfo:userInfo];
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
								if(xmlStrEqual(bodyNode->name, (const xmlChar *) "return")) {
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
@implementation DirectTrackWebServicesBinding_creativeInfo
@synthesize client;
@synthesize add_code;
@synthesize password;
@synthesize program_id;
@synthesize opt_info;
@synthesize creativeTypeId;
@synthesize search_criteria;
@synthesize agreed_to_terms;
- (id)initWithBinding:(DirectTrackWebServicesBinding *)aBinding delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate
client:(NSString *)aClient
add_code:(NSString *)aAdd_code
password:(NSString *)aPassword
program_id:(NSNumber *)aProgram_id
opt_info:(NSString *)aOpt_info
creativeTypeId:(NSNumber *)aCreativeTypeId
search_criteria:(NSString *)aSearch_criteria
agreed_to_terms:(NSNumber *)aAgreed_to_terms
{
	if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
		self.client = aClient;
		self.add_code = aAdd_code;
		self.password = aPassword;
		self.program_id = aProgram_id;
		self.opt_info = aOpt_info;
		self.creativeTypeId = aCreativeTypeId;
		self.search_criteria = aSearch_criteria;
		self.agreed_to_terms = aAgreed_to_terms;
	}
	
	return self;
}
- (void)dealloc
{
	if(client != nil) [client release];
	if(add_code != nil) [add_code release];
	if(password != nil) [password release];
	if(program_id != nil) [program_id release];
	if(opt_info != nil) [opt_info release];
	if(creativeTypeId != nil) [creativeTypeId release];
	if(search_criteria != nil) [search_criteria release];
	if(agreed_to_terms != nil) [agreed_to_terms release];
	
	[super dealloc];
}
- (void)main
{
	[response autorelease];
	response = [DirectTrackWebServicesBindingResponse new];
	
	DirectTrackWebServicesBinding_envelope *envelope = [DirectTrackWebServicesBinding_envelope sharedInstance];
	
	NSMutableDictionary *headerElements = nil;
	headerElements = [NSMutableDictionary dictionary];
	
	NSMutableDictionary *bodyElements = nil;
	bodyElements = [NSMutableDictionary dictionary];
	if(client != nil) [bodyElements setObject:client forKey:@"client"];
	if(add_code != nil) [bodyElements setObject:add_code forKey:@"add_code"];
	if(password != nil) [bodyElements setObject:password forKey:@"password"];
	if(program_id != nil) [bodyElements setObject:program_id forKey:@"program_id"];
	if(opt_info != nil) [bodyElements setObject:opt_info forKey:@"opt_info"];
	if(creativeTypeId != nil) [bodyElements setObject:creativeTypeId forKey:@"creativeTypeId"];
	if(search_criteria != nil) [bodyElements setObject:search_criteria forKey:@"search_criteria"];
	if(agreed_to_terms != nil) [bodyElements setObject:agreed_to_terms forKey:@"agreed_to_terms"];
	
	NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
	
	[binding sendHTTPCallUsingBody:operationXMLString soapAction:@"http://publishers.clickbooth.com/api/soap_affiliate.php/creativeInfo" forOperation:self];
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
			
			response.error = [NSError errorWithDomain:@"DirectTrackWebServicesBindingResponseXML" code:1 userInfo:userInfo];
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
								if(xmlStrEqual(bodyNode->name, (const xmlChar *) "return")) {
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
@implementation DirectTrackWebServicesBinding_optionalInfo
@synthesize client;
@synthesize add_code;
@synthesize password;
@synthesize start_date;
@synthesize end_date;
@synthesize program_id;
@synthesize opt_info;
- (id)initWithBinding:(DirectTrackWebServicesBinding *)aBinding delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate
client:(NSString *)aClient
add_code:(NSString *)aAdd_code
password:(NSString *)aPassword
start_date:(NSString *)aStart_date
end_date:(NSString *)aEnd_date
program_id:(NSNumber *)aProgram_id
opt_info:(NSString *)aOpt_info
{
	if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
		self.client = aClient;
		self.add_code = aAdd_code;
		self.password = aPassword;
		self.start_date = aStart_date;
		self.end_date = aEnd_date;
		self.program_id = aProgram_id;
		self.opt_info = aOpt_info;
	}
	
	return self;
}
- (void)dealloc
{
	if(client != nil) [client release];
	if(add_code != nil) [add_code release];
	if(password != nil) [password release];
	if(start_date != nil) [start_date release];
	if(end_date != nil) [end_date release];
	if(program_id != nil) [program_id release];
	if(opt_info != nil) [opt_info release];
	
	[super dealloc];
}
- (void)main
{
	[response autorelease];
	response = [DirectTrackWebServicesBindingResponse new];
	
	DirectTrackWebServicesBinding_envelope *envelope = [DirectTrackWebServicesBinding_envelope sharedInstance];
	
	NSMutableDictionary *headerElements = nil;
	headerElements = [NSMutableDictionary dictionary];
	
	NSMutableDictionary *bodyElements = nil;
	bodyElements = [NSMutableDictionary dictionary];
	if(client != nil) [bodyElements setObject:client forKey:@"client"];
	if(add_code != nil) [bodyElements setObject:add_code forKey:@"add_code"];
	if(password != nil) [bodyElements setObject:password forKey:@"password"];
	if(start_date != nil) [bodyElements setObject:start_date forKey:@"start_date"];
	if(end_date != nil) [bodyElements setObject:end_date forKey:@"end_date"];
	if(program_id != nil) [bodyElements setObject:program_id forKey:@"program_id"];
	if(opt_info != nil) [bodyElements setObject:opt_info forKey:@"opt_info"];
	
	NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
	
	[binding sendHTTPCallUsingBody:operationXMLString soapAction:@"http://publishers.clickbooth.com/api/soap_affiliate.php/optionalInfo" forOperation:self];
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
			
			response.error = [NSError errorWithDomain:@"DirectTrackWebServicesBindingResponseXML" code:1 userInfo:userInfo];
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
								if(xmlStrEqual(bodyNode->name, (const xmlChar *) "return")) {
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
@implementation DirectTrackWebServicesBinding_monthlyStatsInfo
@synthesize client;
@synthesize add_code;
@synthesize password;
@synthesize start_date;
@synthesize end_date;
@synthesize program_id;
- (id)initWithBinding:(DirectTrackWebServicesBinding *)aBinding delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate
client:(NSString *)aClient
add_code:(NSString *)aAdd_code
password:(NSString *)aPassword
start_date:(NSString *)aStart_date
end_date:(NSString *)aEnd_date
program_id:(NSNumber *)aProgram_id
{
	if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
		self.client = aClient;
		self.add_code = aAdd_code;
		self.password = aPassword;
		self.start_date = aStart_date;
		self.end_date = aEnd_date;
		self.program_id = aProgram_id;
	}
	
	return self;
}
- (void)dealloc
{
	if(client != nil) [client release];
	if(add_code != nil) [add_code release];
	if(password != nil) [password release];
	if(start_date != nil) [start_date release];
	if(end_date != nil) [end_date release];
	if(program_id != nil) [program_id release];
	
	[super dealloc];
}
- (void)main
{
	[response autorelease];
	response = [DirectTrackWebServicesBindingResponse new];
	
	DirectTrackWebServicesBinding_envelope *envelope = [DirectTrackWebServicesBinding_envelope sharedInstance];
	
	NSMutableDictionary *headerElements = nil;
	headerElements = [NSMutableDictionary dictionary];
	
	NSMutableDictionary *bodyElements = nil;
	bodyElements = [NSMutableDictionary dictionary];
	if(client != nil) [bodyElements setObject:client forKey:@"client"];
	if(add_code != nil) [bodyElements setObject:add_code forKey:@"add_code"];
	if(password != nil) [bodyElements setObject:password forKey:@"password"];
	if(start_date != nil) [bodyElements setObject:start_date forKey:@"start_date"];
	if(end_date != nil) [bodyElements setObject:end_date forKey:@"end_date"];
	if(program_id != nil) [bodyElements setObject:program_id forKey:@"program_id"];
	
	NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
	
	[binding sendHTTPCallUsingBody:operationXMLString soapAction:@"http://publishers.clickbooth.com/api/soap_affiliate.php/monthlyStatsInfo" forOperation:self];
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
			
			response.error = [NSError errorWithDomain:@"DirectTrackWebServicesBindingResponseXML" code:1 userInfo:userInfo];
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
								if(xmlStrEqual(bodyNode->name, (const xmlChar *) "return")) {
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
@implementation DirectTrackWebServicesBinding_dailyStatsInfo
@synthesize client;
@synthesize add_code;
@synthesize password;
@synthesize start_date;
@synthesize end_date;
@synthesize program_id;
- (id)initWithBinding:(DirectTrackWebServicesBinding *)aBinding delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate
client:(NSString *)aClient
add_code:(NSString *)aAdd_code
password:(NSString *)aPassword
start_date:(NSString *)aStart_date
end_date:(NSString *)aEnd_date
program_id:(NSNumber *)aProgram_id
{
	if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
		self.client = aClient;
		self.add_code = aAdd_code;
		self.password = aPassword;
		self.start_date = aStart_date;
		self.end_date = aEnd_date;
		self.program_id = aProgram_id;
	}
	
	return self;
}
- (void)dealloc
{
	if(client != nil) [client release];
	if(add_code != nil) [add_code release];
	if(password != nil) [password release];
	if(start_date != nil) [start_date release];
	if(end_date != nil) [end_date release];
	if(program_id != nil) [program_id release];
	
	[super dealloc];
}
- (void)main
{
	[response autorelease];
	response = [DirectTrackWebServicesBindingResponse new];
	
	DirectTrackWebServicesBinding_envelope *envelope = [DirectTrackWebServicesBinding_envelope sharedInstance];
	
	NSMutableDictionary *headerElements = nil;
	headerElements = [NSMutableDictionary dictionary];
	
	NSMutableDictionary *bodyElements = nil;
	bodyElements = [NSMutableDictionary dictionary];
	if(client != nil) [bodyElements setObject:client forKey:@"client"];
	if(add_code != nil) [bodyElements setObject:add_code forKey:@"add_code"];
	if(password != nil) [bodyElements setObject:password forKey:@"password"];
	if(start_date != nil) [bodyElements setObject:start_date forKey:@"start_date"];
	if(end_date != nil) [bodyElements setObject:end_date forKey:@"end_date"];
	if(program_id != nil) [bodyElements setObject:program_id forKey:@"program_id"];
	
	NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
	
	[binding sendHTTPCallUsingBody:operationXMLString soapAction:@"http://publishers.clickbooth.com/api/soap_affiliate.php/dailyStatsInfo" forOperation:self];
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
			
			response.error = [NSError errorWithDomain:@"DirectTrackWebServicesBindingResponseXML" code:1 userInfo:userInfo];
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
								if(xmlStrEqual(bodyNode->name, (const xmlChar *) "return")) {
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
@implementation DirectTrackWebServicesBinding_getCCampaigns
@synthesize client;
@synthesize add_code;
@synthesize password;
@synthesize pool_id;
@synthesize info;
- (id)initWithBinding:(DirectTrackWebServicesBinding *)aBinding delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate
client:(NSString *)aClient
add_code:(NSString *)aAdd_code
password:(NSString *)aPassword
pool_id:(NSString *)aPool_id
info:(NSString *)aInfo
{
	if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
		self.client = aClient;
		self.add_code = aAdd_code;
		self.password = aPassword;
		self.pool_id = aPool_id;
		self.info = aInfo;
	}
	
	return self;
}
- (void)dealloc
{
	if(client != nil) [client release];
	if(add_code != nil) [add_code release];
	if(password != nil) [password release];
	if(pool_id != nil) [pool_id release];
	if(info != nil) [info release];
	
	[super dealloc];
}
- (void)main
{
	[response autorelease];
	response = [DirectTrackWebServicesBindingResponse new];
	
	DirectTrackWebServicesBinding_envelope *envelope = [DirectTrackWebServicesBinding_envelope sharedInstance];
	
	NSMutableDictionary *headerElements = nil;
	headerElements = [NSMutableDictionary dictionary];
	
	NSMutableDictionary *bodyElements = nil;
	bodyElements = [NSMutableDictionary dictionary];
	if(client != nil) [bodyElements setObject:client forKey:@"client"];
	if(add_code != nil) [bodyElements setObject:add_code forKey:@"add_code"];
	if(password != nil) [bodyElements setObject:password forKey:@"password"];
	if(pool_id != nil) [bodyElements setObject:pool_id forKey:@"pool_id"];
	if(info != nil) [bodyElements setObject:info forKey:@"info"];
	
	NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
	
	[binding sendHTTPCallUsingBody:operationXMLString soapAction:@"http://publishers.clickbooth.com/api/soap_affiliate.php/getCCampaigns" forOperation:self];
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
			
			response.error = [NSError errorWithDomain:@"DirectTrackWebServicesBindingResponseXML" code:1 userInfo:userInfo];
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
								if(xmlStrEqual(bodyNode->name, (const xmlChar *) "return")) {
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
@implementation DirectTrackWebServicesBinding_recordHostedLead
@synthesize client;
@synthesize add_code;
@synthesize password;
@synthesize lead;
- (id)initWithBinding:(DirectTrackWebServicesBinding *)aBinding delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate
client:(NSString *)aClient
add_code:(NSString *)aAdd_code
password:(NSString *)aPassword
lead:(NSString *)aLead
{
	if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
		self.client = aClient;
		self.add_code = aAdd_code;
		self.password = aPassword;
		self.lead = aLead;
	}
	
	return self;
}
- (void)dealloc
{
	if(client != nil) [client release];
	if(add_code != nil) [add_code release];
	if(password != nil) [password release];
	if(lead != nil) [lead release];
	
	[super dealloc];
}
- (void)main
{
	[response autorelease];
	response = [DirectTrackWebServicesBindingResponse new];
	
	DirectTrackWebServicesBinding_envelope *envelope = [DirectTrackWebServicesBinding_envelope sharedInstance];
	
	NSMutableDictionary *headerElements = nil;
	headerElements = [NSMutableDictionary dictionary];
	
	NSMutableDictionary *bodyElements = nil;
	bodyElements = [NSMutableDictionary dictionary];
	if(client != nil) [bodyElements setObject:client forKey:@"client"];
	if(add_code != nil) [bodyElements setObject:add_code forKey:@"add_code"];
	if(password != nil) [bodyElements setObject:password forKey:@"password"];
	if(lead != nil) [bodyElements setObject:lead forKey:@"lead"];
	
	NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
	
	[binding sendHTTPCallUsingBody:operationXMLString soapAction:@"http://publishers.clickbooth.com/api/soap_affiliate.php/recordHostedLead" forOperation:self];
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
			
			response.error = [NSError errorWithDomain:@"DirectTrackWebServicesBindingResponseXML" code:1 userInfo:userInfo];
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
								if(xmlStrEqual(bodyNode->name, (const xmlChar *) "return")) {
									NSNumber  *bodyObject = [NSNumber  deserializeNode:bodyNode];
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
@implementation DirectTrackWebServicesBinding_getAffiliateAggregateStatistics
@synthesize client;
@synthesize password;
@synthesize add_code;
@synthesize start_date;
@synthesize end_date;
@synthesize campaign_id;
- (id)initWithBinding:(DirectTrackWebServicesBinding *)aBinding delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate
client:(NSString *)aClient
password:(NSString *)aPassword
add_code:(NSString *)aAdd_code
start_date:(NSDate *)aStart_date
end_date:(NSDate *)aEnd_date
campaign_id:(NSNumber *)aCampaign_id
{
	if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
		self.client = aClient;
		self.password = aPassword;
		self.add_code = aAdd_code;
		self.start_date = aStart_date;
		self.end_date = aEnd_date;
		self.campaign_id = aCampaign_id;
	}
	
	return self;
}
- (void)dealloc
{
	if(client != nil) [client release];
	if(password != nil) [password release];
	if(add_code != nil) [add_code release];
	if(start_date != nil) [start_date release];
	if(end_date != nil) [end_date release];
	if(campaign_id != nil) [campaign_id release];
	
	[super dealloc];
}
- (void)main
{
	[response autorelease];
	response = [DirectTrackWebServicesBindingResponse new];
	
	DirectTrackWebServicesBinding_envelope *envelope = [DirectTrackWebServicesBinding_envelope sharedInstance];
	
	NSMutableDictionary *headerElements = nil;
	headerElements = [NSMutableDictionary dictionary];
	
	NSMutableDictionary *bodyElements = nil;
	bodyElements = [NSMutableDictionary dictionary];
	if(client != nil) [bodyElements setObject:client forKey:@"client"];
	if(password != nil) [bodyElements setObject:password forKey:@"password"];
	if(add_code != nil) [bodyElements setObject:add_code forKey:@"add_code"];
	if(start_date != nil) [bodyElements setObject:start_date forKey:@"start_date"];
	if(end_date != nil) [bodyElements setObject:end_date forKey:@"end_date"];
	if(campaign_id != nil) [bodyElements setObject:campaign_id forKey:@"campaign_id"];
	
	NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
	
	[binding sendHTTPCallUsingBody:operationXMLString soapAction:@"http://publishers.clickbooth.com/api/soap_affiliate.php/getAffiliateAggregateStatistics" forOperation:self];
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
			
			response.error = [NSError errorWithDomain:@"DirectTrackWebServicesBindingResponseXML" code:1 userInfo:userInfo];
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
								if(xmlStrEqual(bodyNode->name, (const xmlChar *) "return")) {
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
@implementation DirectTrackWebServicesBinding_getAffiliateDeployStatistics
@synthesize client;
@synthesize password;
@synthesize add_code;
@synthesize start_date;
@synthesize end_date;
@synthesize campaign_id;
- (id)initWithBinding:(DirectTrackWebServicesBinding *)aBinding delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate
client:(NSString *)aClient
password:(NSString *)aPassword
add_code:(NSString *)aAdd_code
start_date:(NSDate *)aStart_date
end_date:(NSDate *)aEnd_date
campaign_id:(NSNumber *)aCampaign_id
{
	if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
		self.client = aClient;
		self.password = aPassword;
		self.add_code = aAdd_code;
		self.start_date = aStart_date;
		self.end_date = aEnd_date;
		self.campaign_id = aCampaign_id;
	}
	
	return self;
}
- (void)dealloc
{
	if(client != nil) [client release];
	if(password != nil) [password release];
	if(add_code != nil) [add_code release];
	if(start_date != nil) [start_date release];
	if(end_date != nil) [end_date release];
	if(campaign_id != nil) [campaign_id release];
	
	[super dealloc];
}
- (void)main
{
	[response autorelease];
	response = [DirectTrackWebServicesBindingResponse new];
	
	DirectTrackWebServicesBinding_envelope *envelope = [DirectTrackWebServicesBinding_envelope sharedInstance];
	
	NSMutableDictionary *headerElements = nil;
	headerElements = [NSMutableDictionary dictionary];
	
	NSMutableDictionary *bodyElements = nil;
	bodyElements = [NSMutableDictionary dictionary];
	if(client != nil) [bodyElements setObject:client forKey:@"client"];
	if(password != nil) [bodyElements setObject:password forKey:@"password"];
	if(add_code != nil) [bodyElements setObject:add_code forKey:@"add_code"];
	if(start_date != nil) [bodyElements setObject:start_date forKey:@"start_date"];
	if(end_date != nil) [bodyElements setObject:end_date forKey:@"end_date"];
	if(campaign_id != nil) [bodyElements setObject:campaign_id forKey:@"campaign_id"];
	
	NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
	
	[binding sendHTTPCallUsingBody:operationXMLString soapAction:@"http://publishers.clickbooth.com/api/soap_affiliate.php/getAffiliateDeployStatistics" forOperation:self];
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
			
			response.error = [NSError errorWithDomain:@"DirectTrackWebServicesBindingResponseXML" code:1 userInfo:userInfo];
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
								if(xmlStrEqual(bodyNode->name, (const xmlChar *) "return")) {
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
@implementation DirectTrackWebServicesBinding_getSubIDStats
@synthesize client;
@synthesize add_code;
@synthesize password;
@synthesize primary;
@synthesize secondary;
@synthesize tertiary;
@synthesize quaternary;
@synthesize keyword;
@synthesize program_id;
@synthesize start_date;
@synthesize end_date;
- (id)initWithBinding:(DirectTrackWebServicesBinding *)aBinding delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate
client:(NSString *)aClient
add_code:(NSString *)aAdd_code
password:(NSString *)aPassword
primary:(NSString *)aPrimary
secondary:(NSString *)aSecondary
tertiary:(NSString *)aTertiary
quaternary:(NSString *)aQuaternary
keyword:(NSString *)aKeyword
program_id:(NSNumber *)aProgram_id
start_date:(NSDate *)aStart_date
end_date:(NSDate *)aEnd_date
{
	if((self = [super initWithBinding:aBinding delegate:responseDelegate])) {
		self.client = aClient;
		self.add_code = aAdd_code;
		self.password = aPassword;
		self.primary = aPrimary;
		self.secondary = aSecondary;
		self.tertiary = aTertiary;
		self.quaternary = aQuaternary;
		self.keyword = aKeyword;
		self.program_id = aProgram_id;
		self.start_date = aStart_date;
		self.end_date = aEnd_date;
	}
	
	return self;
}
- (void)dealloc
{
	if(client != nil) [client release];
	if(add_code != nil) [add_code release];
	if(password != nil) [password release];
	if(primary != nil) [primary release];
	if(secondary != nil) [secondary release];
	if(tertiary != nil) [tertiary release];
	if(quaternary != nil) [quaternary release];
	if(keyword != nil) [keyword release];
	if(program_id != nil) [program_id release];
	if(start_date != nil) [start_date release];
	if(end_date != nil) [end_date release];
	
	[super dealloc];
}
- (void)main
{
	[response autorelease];
	response = [DirectTrackWebServicesBindingResponse new];
	
	DirectTrackWebServicesBinding_envelope *envelope = [DirectTrackWebServicesBinding_envelope sharedInstance];
	
	NSMutableDictionary *headerElements = nil;
	headerElements = [NSMutableDictionary dictionary];
	
	NSMutableDictionary *bodyElements = nil;
	bodyElements = [NSMutableDictionary dictionary];
	if(client != nil) [bodyElements setObject:client forKey:@"client"];
	if(add_code != nil) [bodyElements setObject:add_code forKey:@"add_code"];
	if(password != nil) [bodyElements setObject:password forKey:@"password"];
	if(primary != nil) [bodyElements setObject:primary forKey:@"primary"];
	if(secondary != nil) [bodyElements setObject:secondary forKey:@"secondary"];
	if(tertiary != nil) [bodyElements setObject:tertiary forKey:@"tertiary"];
	if(quaternary != nil) [bodyElements setObject:quaternary forKey:@"quaternary"];
	if(keyword != nil) [bodyElements setObject:keyword forKey:@"keyword"];
	if(program_id != nil) [bodyElements setObject:program_id forKey:@"program_id"];
	if(start_date != nil) [bodyElements setObject:start_date forKey:@"start_date"];
	if(end_date != nil) [bodyElements setObject:end_date forKey:@"end_date"];
	
	NSString *operationXMLString = [envelope serializedFormUsingHeaderElements:headerElements bodyElements:bodyElements];
	
	[binding sendHTTPCallUsingBody:operationXMLString soapAction:@"http://publishers.clickbooth.com/api/soap_affiliate.php/getSubIDStats" forOperation:self];
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
			
			response.error = [NSError errorWithDomain:@"DirectTrackWebServicesBindingResponseXML" code:1 userInfo:userInfo];
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
								if(xmlStrEqual(bodyNode->name, (const xmlChar *) "return")) {
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
static DirectTrackWebServicesBinding_envelope *DirectTrackWebServicesBindingSharedEnvelopeInstance = nil;
@implementation DirectTrackWebServicesBinding_envelope
+ (DirectTrackWebServicesBinding_envelope *)sharedInstance
{
	if(DirectTrackWebServicesBindingSharedEnvelopeInstance == nil) {
		DirectTrackWebServicesBindingSharedEnvelopeInstance = [DirectTrackWebServicesBinding_envelope new];
	}
	
	return DirectTrackWebServicesBindingSharedEnvelopeInstance;
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
	xmlNewNs(root, (const xmlChar*)"http://soapinterop.org/", (const xmlChar*)"DirectTrackWebServicesSvc");
	xmlNewNs(root, (const xmlChar*)"http://schemas.xmlsoap.org/soap/encoding/", (const xmlChar*)"ns1");
	xmlNewNs(root, (const xmlChar*)"http://schemas.xmlsoap.org/wsdl/", (const xmlChar*)"ns2");
	
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
@implementation DirectTrackWebServicesBindingResponse
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
