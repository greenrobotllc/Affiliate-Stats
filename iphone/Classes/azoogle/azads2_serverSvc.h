#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
#import <objc/runtime.h>
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "xsd.h"
#import "azads2_serverSvc.h"
#import "ns1.h"
@class azads2_serverBinding;
@interface azads2_serverSvc : NSObject {
	
}
+ (azads2_serverBinding *)azads2_serverBinding;
@end
@class azads2_serverBindingResponse;
@class azads2_serverBindingOperation;
@protocol azads2_serverBindingResponseDelegate <NSObject>
- (void) operation:(azads2_serverBindingOperation *)operation completedWithResponse:(azads2_serverBindingResponse *)response;
@end
@interface azads2_serverBinding : NSObject <azads2_serverBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(azads2_serverBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (azads2_serverBindingResponse *)authenticateUsingAffiliate_id:(NSNumber *)aAffiliate_id login:(NSString *)aLogin password:(NSString *)aPassword ;
- (void)authenticateAsyncUsingAffiliate_id:(NSNumber *)aAffiliate_id login:(NSString *)aLogin password:(NSString *)aPassword  delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate;
- (azads2_serverBindingResponse *)getListUsingLogin_hash2:(NSString *)aLogin_hash2 affiliate_id5:(NSNumber *)aAffiliate_id5 offer_id2:(NSNumber *)aOffer_id2 seperator:(NSString *)aSeperator ;
- (void)getListAsyncUsingLogin_hash2:(NSString *)aLogin_hash2 affiliate_id5:(NSNumber *)aAffiliate_id5 offer_id2:(NSNumber *)aOffer_id2 seperator:(NSString *)aSeperator  delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate;
- (azads2_serverBindingResponse *)getSubHitsUsingLogin_hash3:(NSString *)aLogin_hash3 affiliate_id6:(NSNumber *)aAffiliate_id6 offer_id3:(NSNumber *)aOffer_id3 start_date:(NSString *)aStart_date end_date:(NSString *)aEnd_date traffic_type_id3:(NSNumber *)aTraffic_type_id3 sales_only:(USBoolean *)aSales_only ;
- (void)getSubHitsAsyncUsingLogin_hash3:(NSString *)aLogin_hash3 affiliate_id6:(NSNumber *)aAffiliate_id6 offer_id3:(NSNumber *)aOffer_id3 start_date:(NSString *)aStart_date end_date:(NSString *)aEnd_date traffic_type_id3:(NSNumber *)aTraffic_type_id3 sales_only:(USBoolean *)aSales_only  delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate;
- (azads2_serverBindingResponse *)isSuppressedUsingLogin_hash4:(NSString *)aLogin_hash4 affiliate_id7:(NSNumber *)aAffiliate_id7 offer_id4:(NSNumber *)aOffer_id4 email:(NSString *)aEmail ;
- (void)isSuppressedAsyncUsingLogin_hash4:(NSString *)aLogin_hash4 affiliate_id7:(NSNumber *)aAffiliate_id7 offer_id4:(NSNumber *)aOffer_id4 email:(NSString *)aEmail  delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate;
- (azads2_serverBindingResponse *)leadTotalsUsingLogin_hash5:(NSString *)aLogin_hash5 affiliate_id8:(NSNumber *)aAffiliate_id8 offer_id5:(NSNumber *)aOffer_id5 start_date1:(NSString *)aStart_date1 end_date1:(NSString *)aEnd_date1 sub_id2:(NSString *)aSub_id2 traffic_type_id4:(NSNumber *)aTraffic_type_id4 sales_only1:(USBoolean *)aSales_only1 ;
- (void)leadTotalsAsyncUsingLogin_hash5:(NSString *)aLogin_hash5 affiliate_id8:(NSNumber *)aAffiliate_id8 offer_id5:(NSNumber *)aOffer_id5 start_date1:(NSString *)aStart_date1 end_date1:(NSString *)aEnd_date1 sub_id2:(NSString *)aSub_id2 traffic_type_id4:(NSNumber *)aTraffic_type_id4 sales_only1:(USBoolean *)aSales_only1  delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate;
- (azads2_serverBindingResponse *)generateClickUrlUsingLogin_hash8:(NSString *)aLogin_hash8 affiliate_id11:(NSNumber *)aAffiliate_id11 offer_id7:(NSNumber *)aOffer_id7 traffic_type_id6:(NSNumber *)aTraffic_type_id6 sub_id4:(NSString *)aSub_id4 ;
- (void)generateClickUrlAsyncUsingLogin_hash8:(NSString *)aLogin_hash8 affiliate_id11:(NSNumber *)aAffiliate_id11 offer_id7:(NSNumber *)aOffer_id7 traffic_type_id6:(NSNumber *)aTraffic_type_id6 sub_id4:(NSString *)aSub_id4  delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate;
- (azads2_serverBindingResponse *)logoutUsingLogin_hash6:(NSString *)aLogin_hash6 affiliate_id9:(NSNumber *)aAffiliate_id9 ;
- (void)logoutAsyncUsingLogin_hash6:(NSString *)aLogin_hash6 affiliate_id9:(NSNumber *)aAffiliate_id9  delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate;
- (azads2_serverBindingResponse *)offerDetailsUsingLogin_hash7:(NSString *)aLogin_hash7 affiliate_id10:(NSNumber *)aAffiliate_id10 offer_id6:(NSNumber *)aOffer_id6 traffic_type_id5:(NSNumber *)aTraffic_type_id5 sub_id3:(NSString *)aSub_id3 suppression_delimiter:(NSString *)aSuppression_delimiter keyword_delimiter:(NSString *)aKeyword_delimiter ;
- (void)offerDetailsAsyncUsingLogin_hash7:(NSString *)aLogin_hash7 affiliate_id10:(NSNumber *)aAffiliate_id10 offer_id6:(NSNumber *)aOffer_id6 traffic_type_id5:(NSNumber *)aTraffic_type_id5 sub_id3:(NSString *)aSub_id3 suppression_delimiter:(NSString *)aSuppression_delimiter keyword_delimiter:(NSString *)aKeyword_delimiter  delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate;
- (azads2_serverBindingResponse *)listOffersUsingLogin_hash7:(NSString *)aLogin_hash7 affiliate_id10:(NSNumber *)aAffiliate_id10 ;
- (void)listOffersAsyncUsingLogin_hash7:(NSString *)aLogin_hash7 affiliate_id10:(NSNumber *)aAffiliate_id10  delegate:(id<azads2_serverBindingResponseDelegate>)responseDelegate;
@end
@interface azads2_serverBindingOperation : NSOperation {
	azads2_serverBinding *binding;
	azads2_serverBindingResponse *response;
	id<azads2_serverBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) azads2_serverBinding *binding;
@property (readonly) azads2_serverBindingResponse *response;
@property (nonatomic, assign) id<azads2_serverBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(azads2_serverBinding *)aBinding delegate:(id<azads2_serverBindingResponseDelegate>)aDelegate;
@end
@interface azads2_serverBinding_authenticate : azads2_serverBindingOperation {
	NSNumber * affiliate_id;
	NSString * login;
	NSString * password;
}
@property (retain) NSNumber * affiliate_id;
@property (retain) NSString * login;
@property (retain) NSString * password;
- (id)initWithBinding:(azads2_serverBinding *)aBinding delegate:(id<azads2_serverBindingResponseDelegate>)aDelegate
	affiliate_id:(NSNumber *)aAffiliate_id
	login:(NSString *)aLogin
	password:(NSString *)aPassword
;
@end
@interface azads2_serverBinding_getList : azads2_serverBindingOperation {
	NSString * login_hash2;
	NSNumber * affiliate_id5;
	NSNumber * offer_id2;
	NSString * seperator;
}
@property (retain) NSString * login_hash2;
@property (retain) NSNumber * affiliate_id5;
@property (retain) NSNumber * offer_id2;
@property (retain) NSString * seperator;
- (id)initWithBinding:(azads2_serverBinding *)aBinding delegate:(id<azads2_serverBindingResponseDelegate>)aDelegate
	login_hash2:(NSString *)aLogin_hash2
	affiliate_id5:(NSNumber *)aAffiliate_id5
	offer_id2:(NSNumber *)aOffer_id2
	seperator:(NSString *)aSeperator
;
@end
@interface azads2_serverBinding_getSubHits : azads2_serverBindingOperation {
	NSString * login_hash3;
	NSNumber * affiliate_id6;
	NSNumber * offer_id3;
	NSString * start_date;
	NSString * end_date;
	NSNumber * traffic_type_id3;
	USBoolean * sales_only;
}
@property (retain) NSString * login_hash3;
@property (retain) NSNumber * affiliate_id6;
@property (retain) NSNumber * offer_id3;
@property (retain) NSString * start_date;
@property (retain) NSString * end_date;
@property (retain) NSNumber * traffic_type_id3;
@property (retain) USBoolean * sales_only;
- (id)initWithBinding:(azads2_serverBinding *)aBinding delegate:(id<azads2_serverBindingResponseDelegate>)aDelegate
	login_hash3:(NSString *)aLogin_hash3
	affiliate_id6:(NSNumber *)aAffiliate_id6
	offer_id3:(NSNumber *)aOffer_id3
	start_date:(NSString *)aStart_date
	end_date:(NSString *)aEnd_date
	traffic_type_id3:(NSNumber *)aTraffic_type_id3
	sales_only:(USBoolean *)aSales_only
;
@end
@interface azads2_serverBinding_isSuppressed : azads2_serverBindingOperation {
	NSString * login_hash4;
	NSNumber * affiliate_id7;
	NSNumber * offer_id4;
	NSString * email;
}
@property (retain) NSString * login_hash4;
@property (retain) NSNumber * affiliate_id7;
@property (retain) NSNumber * offer_id4;
@property (retain) NSString * email;
- (id)initWithBinding:(azads2_serverBinding *)aBinding delegate:(id<azads2_serverBindingResponseDelegate>)aDelegate
	login_hash4:(NSString *)aLogin_hash4
	affiliate_id7:(NSNumber *)aAffiliate_id7
	offer_id4:(NSNumber *)aOffer_id4
	email:(NSString *)aEmail
;
@end
@interface azads2_serverBinding_leadTotals : azads2_serverBindingOperation {
	NSString * login_hash5;
	NSNumber * affiliate_id8;
	NSNumber * offer_id5;
	NSString * start_date1;
	NSString * end_date1;
	NSString * sub_id2;
	NSNumber * traffic_type_id4;
	USBoolean * sales_only1;
}
@property (retain) NSString * login_hash5;
@property (retain) NSNumber * affiliate_id8;
@property (retain) NSNumber * offer_id5;
@property (retain) NSString * start_date1;
@property (retain) NSString * end_date1;
@property (retain) NSString * sub_id2;
@property (retain) NSNumber * traffic_type_id4;
@property (retain) USBoolean * sales_only1;
- (id)initWithBinding:(azads2_serverBinding *)aBinding delegate:(id<azads2_serverBindingResponseDelegate>)aDelegate
	login_hash5:(NSString *)aLogin_hash5
	affiliate_id8:(NSNumber *)aAffiliate_id8
	offer_id5:(NSNumber *)aOffer_id5
	start_date1:(NSString *)aStart_date1
	end_date1:(NSString *)aEnd_date1
	sub_id2:(NSString *)aSub_id2
	traffic_type_id4:(NSNumber *)aTraffic_type_id4
	sales_only1:(USBoolean *)aSales_only1
;
@end
@interface azads2_serverBinding_generateClickUrl : azads2_serverBindingOperation {
	NSString * login_hash8;
	NSNumber * affiliate_id11;
	NSNumber * offer_id7;
	NSNumber * traffic_type_id6;
	NSString * sub_id4;
}
@property (retain) NSString * login_hash8;
@property (retain) NSNumber * affiliate_id11;
@property (retain) NSNumber * offer_id7;
@property (retain) NSNumber * traffic_type_id6;
@property (retain) NSString * sub_id4;
- (id)initWithBinding:(azads2_serverBinding *)aBinding delegate:(id<azads2_serverBindingResponseDelegate>)aDelegate
	login_hash8:(NSString *)aLogin_hash8
	affiliate_id11:(NSNumber *)aAffiliate_id11
	offer_id7:(NSNumber *)aOffer_id7
	traffic_type_id6:(NSNumber *)aTraffic_type_id6
	sub_id4:(NSString *)aSub_id4
;
@end
@interface azads2_serverBinding_logout : azads2_serverBindingOperation {
	NSString * login_hash6;
	NSNumber * affiliate_id9;
}
@property (retain) NSString * login_hash6;
@property (retain) NSNumber * affiliate_id9;
- (id)initWithBinding:(azads2_serverBinding *)aBinding delegate:(id<azads2_serverBindingResponseDelegate>)aDelegate
	login_hash6:(NSString *)aLogin_hash6
	affiliate_id9:(NSNumber *)aAffiliate_id9
;
@end
@interface azads2_serverBinding_offerDetails : azads2_serverBindingOperation {
	NSString * login_hash7;
	NSNumber * affiliate_id10;
	NSNumber * offer_id6;
	NSNumber * traffic_type_id5;
	NSString * sub_id3;
	NSString * suppression_delimiter;
	NSString * keyword_delimiter;
}
@property (retain) NSString * login_hash7;
@property (retain) NSNumber * affiliate_id10;
@property (retain) NSNumber * offer_id6;
@property (retain) NSNumber * traffic_type_id5;
@property (retain) NSString * sub_id3;
@property (retain) NSString * suppression_delimiter;
@property (retain) NSString * keyword_delimiter;
- (id)initWithBinding:(azads2_serverBinding *)aBinding delegate:(id<azads2_serverBindingResponseDelegate>)aDelegate
	login_hash7:(NSString *)aLogin_hash7
	affiliate_id10:(NSNumber *)aAffiliate_id10
	offer_id6:(NSNumber *)aOffer_id6
	traffic_type_id5:(NSNumber *)aTraffic_type_id5
	sub_id3:(NSString *)aSub_id3
	suppression_delimiter:(NSString *)aSuppression_delimiter
	keyword_delimiter:(NSString *)aKeyword_delimiter
;
@end
@interface azads2_serverBinding_listOffers : azads2_serverBindingOperation {
	NSString * login_hash7;
	NSNumber * affiliate_id10;
}
@property (retain) NSString * login_hash7;
@property (retain) NSNumber * affiliate_id10;
- (id)initWithBinding:(azads2_serverBinding *)aBinding delegate:(id<azads2_serverBindingResponseDelegate>)aDelegate
	login_hash7:(NSString *)aLogin_hash7
	affiliate_id10:(NSNumber *)aAffiliate_id10
;
@end
@interface azads2_serverBinding_envelope : NSObject {
}
+ (azads2_serverBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface azads2_serverBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
