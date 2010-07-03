#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
#import <objc/runtime.h>
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "xsd.h"
#import "DirectTrackWebServicesSvc.h"
@class DirectTrackWebServicesBinding;
@interface DirectTrackWebServicesSvc : NSObject {
	
}
+ (DirectTrackWebServicesBinding *)DirectTrackWebServicesBinding;
@end
@class DirectTrackWebServicesBindingResponse;
@class DirectTrackWebServicesBindingOperation;
@protocol DirectTrackWebServicesBindingResponseDelegate <NSObject>
- (void) operation:(DirectTrackWebServicesBindingOperation *)operation completedWithResponse:(DirectTrackWebServicesBindingResponse *)response;
@end
@interface DirectTrackWebServicesBinding : NSObject <DirectTrackWebServicesBindingResponseDelegate> {
	NSURL *address;
	NSTimeInterval defaultTimeout;
	NSMutableArray *cookies;
	BOOL logXMLInOut;
	BOOL synchronousOperationComplete;
	NSString *authUsername;
	NSString *authPassword;
}
@property (copy) NSURL *address;
@property (assign) BOOL logXMLInOut;
@property (assign) NSTimeInterval defaultTimeout;
@property (nonatomic, retain) NSMutableArray *cookies;
@property (nonatomic, retain) NSString *authUsername;
@property (nonatomic, retain) NSString *authPassword;
- (id)initWithAddress:(NSString *)anAddress;
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(DirectTrackWebServicesBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (DirectTrackWebServicesBindingResponse *)creativeTypesUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword ;
- (void)creativeTypesAsyncUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword  delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate;
- (DirectTrackWebServicesBindingResponse *)campaignInfoUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword program_id:(NSNumber *)aProgram_id ignore_campaign_images:(NSString *)aIgnore_campaign_images category:(NSString *)aCategory ;
- (void)campaignInfoAsyncUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword program_id:(NSNumber *)aProgram_id ignore_campaign_images:(NSString *)aIgnore_campaign_images category:(NSString *)aCategory  delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate;
- (DirectTrackWebServicesBindingResponse *)creativeInfoUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword program_id:(NSNumber *)aProgram_id opt_info:(NSString *)aOpt_info creativeTypeId:(NSNumber *)aCreativeTypeId search_criteria:(NSString *)aSearch_criteria agreed_to_terms:(NSNumber *)aAgreed_to_terms ;
- (void)creativeInfoAsyncUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword program_id:(NSNumber *)aProgram_id opt_info:(NSString *)aOpt_info creativeTypeId:(NSNumber *)aCreativeTypeId search_criteria:(NSString *)aSearch_criteria agreed_to_terms:(NSNumber *)aAgreed_to_terms  delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate;
- (DirectTrackWebServicesBindingResponse *)optionalInfoUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword start_date:(NSString *)aStart_date end_date:(NSString *)aEnd_date program_id:(NSNumber *)aProgram_id opt_info:(NSString *)aOpt_info ;
- (void)optionalInfoAsyncUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword start_date:(NSString *)aStart_date end_date:(NSString *)aEnd_date program_id:(NSNumber *)aProgram_id opt_info:(NSString *)aOpt_info  delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate;
- (DirectTrackWebServicesBindingResponse *)monthlyStatsInfoUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword start_date:(NSString *)aStart_date end_date:(NSString *)aEnd_date program_id:(NSNumber *)aProgram_id ;
- (void)monthlyStatsInfoAsyncUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword start_date:(NSString *)aStart_date end_date:(NSString *)aEnd_date program_id:(NSNumber *)aProgram_id  delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate;
- (DirectTrackWebServicesBindingResponse *)dailyStatsInfoUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword start_date:(NSString *)aStart_date end_date:(NSString *)aEnd_date program_id:(NSNumber *)aProgram_id ;
- (void)dailyStatsInfoAsyncUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword start_date:(NSString *)aStart_date end_date:(NSString *)aEnd_date program_id:(NSNumber *)aProgram_id  delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate;
- (DirectTrackWebServicesBindingResponse *)getCCampaignsUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword pool_id:(NSString *)aPool_id info:(NSString *)aInfo ;
- (void)getCCampaignsAsyncUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword pool_id:(NSString *)aPool_id info:(NSString *)aInfo  delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate;
- (DirectTrackWebServicesBindingResponse *)recordHostedLeadUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword lead:(NSString *)aLead ;
- (void)recordHostedLeadAsyncUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword lead:(NSString *)aLead  delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate;
- (DirectTrackWebServicesBindingResponse *)getAffiliateAggregateStatisticsUsingClient:(NSString *)aClient password:(NSString *)aPassword add_code:(NSString *)aAdd_code start_date:(NSDate *)aStart_date end_date:(NSDate *)aEnd_date campaign_id:(NSNumber *)aCampaign_id ;
- (void)getAffiliateAggregateStatisticsAsyncUsingClient:(NSString *)aClient password:(NSString *)aPassword add_code:(NSString *)aAdd_code start_date:(NSDate *)aStart_date end_date:(NSDate *)aEnd_date campaign_id:(NSNumber *)aCampaign_id  delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate;
- (DirectTrackWebServicesBindingResponse *)getAffiliateDeployStatisticsUsingClient:(NSString *)aClient password:(NSString *)aPassword add_code:(NSString *)aAdd_code start_date:(NSDate *)aStart_date end_date:(NSDate *)aEnd_date campaign_id:(NSNumber *)aCampaign_id ;
- (void)getAffiliateDeployStatisticsAsyncUsingClient:(NSString *)aClient password:(NSString *)aPassword add_code:(NSString *)aAdd_code start_date:(NSDate *)aStart_date end_date:(NSDate *)aEnd_date campaign_id:(NSNumber *)aCampaign_id  delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate;
- (DirectTrackWebServicesBindingResponse *)getSubIDStatsUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword primary:(NSString *)aPrimary secondary:(NSString *)aSecondary tertiary:(NSString *)aTertiary quaternary:(NSString *)aQuaternary keyword:(NSString *)aKeyword program_id:(NSNumber *)aProgram_id start_date:(NSDate *)aStart_date end_date:(NSDate *)aEnd_date ;
- (void)getSubIDStatsAsyncUsingClient:(NSString *)aClient add_code:(NSString *)aAdd_code password:(NSString *)aPassword primary:(NSString *)aPrimary secondary:(NSString *)aSecondary tertiary:(NSString *)aTertiary quaternary:(NSString *)aQuaternary keyword:(NSString *)aKeyword program_id:(NSNumber *)aProgram_id start_date:(NSDate *)aStart_date end_date:(NSDate *)aEnd_date  delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)responseDelegate;
@end
@interface DirectTrackWebServicesBindingOperation : NSOperation {
	DirectTrackWebServicesBinding *binding;
	DirectTrackWebServicesBindingResponse *response;
	id<DirectTrackWebServicesBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) DirectTrackWebServicesBinding *binding;
@property (readonly) DirectTrackWebServicesBindingResponse *response;
@property (nonatomic, assign) id<DirectTrackWebServicesBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(DirectTrackWebServicesBinding *)aBinding delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)aDelegate;
@end
@interface DirectTrackWebServicesBinding_creativeTypes : DirectTrackWebServicesBindingOperation {
	NSString * client;
	NSString * add_code;
	NSString * password;
}
@property (retain) NSString * client;
@property (retain) NSString * add_code;
@property (retain) NSString * password;
- (id)initWithBinding:(DirectTrackWebServicesBinding *)aBinding delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)aDelegate
	client:(NSString *)aClient
	add_code:(NSString *)aAdd_code
	password:(NSString *)aPassword
;
@end
@interface DirectTrackWebServicesBinding_campaignInfo : DirectTrackWebServicesBindingOperation {
	NSString * client;
	NSString * add_code;
	NSString * password;
	NSNumber * program_id;
	NSString * ignore_campaign_images;
	NSString * category;
}
@property (retain) NSString * client;
@property (retain) NSString * add_code;
@property (retain) NSString * password;
@property (retain) NSNumber * program_id;
@property (retain) NSString * ignore_campaign_images;
@property (retain) NSString * category;
- (id)initWithBinding:(DirectTrackWebServicesBinding *)aBinding delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)aDelegate
	client:(NSString *)aClient
	add_code:(NSString *)aAdd_code
	password:(NSString *)aPassword
	program_id:(NSNumber *)aProgram_id
	ignore_campaign_images:(NSString *)aIgnore_campaign_images
	category:(NSString *)aCategory
;
@end
@interface DirectTrackWebServicesBinding_creativeInfo : DirectTrackWebServicesBindingOperation {
	NSString * client;
	NSString * add_code;
	NSString * password;
	NSNumber * program_id;
	NSString * opt_info;
	NSNumber * creativeTypeId;
	NSString * search_criteria;
	NSNumber * agreed_to_terms;
}
@property (retain) NSString * client;
@property (retain) NSString * add_code;
@property (retain) NSString * password;
@property (retain) NSNumber * program_id;
@property (retain) NSString * opt_info;
@property (retain) NSNumber * creativeTypeId;
@property (retain) NSString * search_criteria;
@property (retain) NSNumber * agreed_to_terms;
- (id)initWithBinding:(DirectTrackWebServicesBinding *)aBinding delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)aDelegate
	client:(NSString *)aClient
	add_code:(NSString *)aAdd_code
	password:(NSString *)aPassword
	program_id:(NSNumber *)aProgram_id
	opt_info:(NSString *)aOpt_info
	creativeTypeId:(NSNumber *)aCreativeTypeId
	search_criteria:(NSString *)aSearch_criteria
	agreed_to_terms:(NSNumber *)aAgreed_to_terms
;
@end
@interface DirectTrackWebServicesBinding_optionalInfo : DirectTrackWebServicesBindingOperation {
	NSString * client;
	NSString * add_code;
	NSString * password;
	NSString * start_date;
	NSString * end_date;
	NSNumber * program_id;
	NSString * opt_info;
}
@property (retain) NSString * client;
@property (retain) NSString * add_code;
@property (retain) NSString * password;
@property (retain) NSString * start_date;
@property (retain) NSString * end_date;
@property (retain) NSNumber * program_id;
@property (retain) NSString * opt_info;
- (id)initWithBinding:(DirectTrackWebServicesBinding *)aBinding delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)aDelegate
	client:(NSString *)aClient
	add_code:(NSString *)aAdd_code
	password:(NSString *)aPassword
	start_date:(NSString *)aStart_date
	end_date:(NSString *)aEnd_date
	program_id:(NSNumber *)aProgram_id
	opt_info:(NSString *)aOpt_info
;
@end
@interface DirectTrackWebServicesBinding_monthlyStatsInfo : DirectTrackWebServicesBindingOperation {
	NSString * client;
	NSString * add_code;
	NSString * password;
	NSString * start_date;
	NSString * end_date;
	NSNumber * program_id;
}
@property (retain) NSString * client;
@property (retain) NSString * add_code;
@property (retain) NSString * password;
@property (retain) NSString * start_date;
@property (retain) NSString * end_date;
@property (retain) NSNumber * program_id;
- (id)initWithBinding:(DirectTrackWebServicesBinding *)aBinding delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)aDelegate
	client:(NSString *)aClient
	add_code:(NSString *)aAdd_code
	password:(NSString *)aPassword
	start_date:(NSString *)aStart_date
	end_date:(NSString *)aEnd_date
	program_id:(NSNumber *)aProgram_id
;
@end
@interface DirectTrackWebServicesBinding_dailyStatsInfo : DirectTrackWebServicesBindingOperation {
	NSString * client;
	NSString * add_code;
	NSString * password;
	NSString * start_date;
	NSString * end_date;
	NSNumber * program_id;
}
@property (retain) NSString * client;
@property (retain) NSString * add_code;
@property (retain) NSString * password;
@property (retain) NSString * start_date;
@property (retain) NSString * end_date;
@property (retain) NSNumber * program_id;
- (id)initWithBinding:(DirectTrackWebServicesBinding *)aBinding delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)aDelegate
	client:(NSString *)aClient
	add_code:(NSString *)aAdd_code
	password:(NSString *)aPassword
	start_date:(NSString *)aStart_date
	end_date:(NSString *)aEnd_date
	program_id:(NSNumber *)aProgram_id
;
@end
@interface DirectTrackWebServicesBinding_getCCampaigns : DirectTrackWebServicesBindingOperation {
	NSString * client;
	NSString * add_code;
	NSString * password;
	NSString * pool_id;
	NSString * info;
}
@property (retain) NSString * client;
@property (retain) NSString * add_code;
@property (retain) NSString * password;
@property (retain) NSString * pool_id;
@property (retain) NSString * info;
- (id)initWithBinding:(DirectTrackWebServicesBinding *)aBinding delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)aDelegate
	client:(NSString *)aClient
	add_code:(NSString *)aAdd_code
	password:(NSString *)aPassword
	pool_id:(NSString *)aPool_id
	info:(NSString *)aInfo
;
@end
@interface DirectTrackWebServicesBinding_recordHostedLead : DirectTrackWebServicesBindingOperation {
	NSString * client;
	NSString * add_code;
	NSString * password;
	NSString * lead;
}
@property (retain) NSString * client;
@property (retain) NSString * add_code;
@property (retain) NSString * password;
@property (retain) NSString * lead;
- (id)initWithBinding:(DirectTrackWebServicesBinding *)aBinding delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)aDelegate
	client:(NSString *)aClient
	add_code:(NSString *)aAdd_code
	password:(NSString *)aPassword
	lead:(NSString *)aLead
;
@end
@interface DirectTrackWebServicesBinding_getAffiliateAggregateStatistics : DirectTrackWebServicesBindingOperation {
	NSString * client;
	NSString * password;
	NSString * add_code;
	NSDate * start_date;
	NSDate * end_date;
	NSNumber * campaign_id;
}
@property (retain) NSString * client;
@property (retain) NSString * password;
@property (retain) NSString * add_code;
@property (retain) NSDate * start_date;
@property (retain) NSDate * end_date;
@property (retain) NSNumber * campaign_id;
- (id)initWithBinding:(DirectTrackWebServicesBinding *)aBinding delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)aDelegate
	client:(NSString *)aClient
	password:(NSString *)aPassword
	add_code:(NSString *)aAdd_code
	start_date:(NSDate *)aStart_date
	end_date:(NSDate *)aEnd_date
	campaign_id:(NSNumber *)aCampaign_id
;
@end
@interface DirectTrackWebServicesBinding_getAffiliateDeployStatistics : DirectTrackWebServicesBindingOperation {
	NSString * client;
	NSString * password;
	NSString * add_code;
	NSDate * start_date;
	NSDate * end_date;
	NSNumber * campaign_id;
}
@property (retain) NSString * client;
@property (retain) NSString * password;
@property (retain) NSString * add_code;
@property (retain) NSDate * start_date;
@property (retain) NSDate * end_date;
@property (retain) NSNumber * campaign_id;
- (id)initWithBinding:(DirectTrackWebServicesBinding *)aBinding delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)aDelegate
	client:(NSString *)aClient
	password:(NSString *)aPassword
	add_code:(NSString *)aAdd_code
	start_date:(NSDate *)aStart_date
	end_date:(NSDate *)aEnd_date
	campaign_id:(NSNumber *)aCampaign_id
;
@end
@interface DirectTrackWebServicesBinding_getSubIDStats : DirectTrackWebServicesBindingOperation {
	NSString * client;
	NSString * add_code;
	NSString * password;
	NSString * primary;
	NSString * secondary;
	NSString * tertiary;
	NSString * quaternary;
	NSString * keyword;
	NSNumber * program_id;
	NSDate * start_date;
	NSDate * end_date;
}
@property (retain) NSString * client;
@property (retain) NSString * add_code;
@property (retain) NSString * password;
@property (retain) NSString * primary;
@property (retain) NSString * secondary;
@property (retain) NSString * tertiary;
@property (retain) NSString * quaternary;
@property (retain) NSString * keyword;
@property (retain) NSNumber * program_id;
@property (retain) NSDate * start_date;
@property (retain) NSDate * end_date;
- (id)initWithBinding:(DirectTrackWebServicesBinding *)aBinding delegate:(id<DirectTrackWebServicesBindingResponseDelegate>)aDelegate
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
;
@end
@interface DirectTrackWebServicesBinding_envelope : NSObject {
}
+ (DirectTrackWebServicesBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface DirectTrackWebServicesBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
