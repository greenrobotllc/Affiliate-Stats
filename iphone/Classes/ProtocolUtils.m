//
//  GRProtocolAdditions.m
//  flutter
//
//  Created by Adam Markey on 7/1/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <objc/runtime.h>
#import "ProtocolUtils.h"


BOOL protocolImplementsSelector(Protocol *protocol, SEL selector) {
	struct objc_method_description d1 =  protocol_getMethodDescription(protocol, selector, NO, NO);
	struct objc_method_description d2 =  protocol_getMethodDescription(protocol, selector, NO, YES);
	struct objc_method_description d3 =  protocol_getMethodDescription(protocol, selector, YES, NO);
	struct objc_method_description d4 =  protocol_getMethodDescription(protocol, selector, YES, YES);
	
	BOOL protocolMethod = ((d1.name != nil) || (d2.name != nil) || (d3.name != nil) || (d4.name != nil));
	return protocolMethod;
}

BOOL forwardInvocation(NSInvocation *invocation, Protocol *protocol, id target, id object) {
	BOOL ret = NO;
	SEL selector = [invocation selector];
	
	BOOL protocolMethod = protocolImplementsSelector(protocol, selector);
	BOOL implemented = [target conformsToProtocol:protocol];
	
	if ( protocolMethod && implemented) {
		ret = YES;
		@try {
			[invocation invokeWithTarget:target];
		} @catch (NSException *ex) {
			if ([[ex name] isEqualToString:NSInvalidArgumentException])
				ret = NO;
		}
	} else {
		ret = NO;
		[object doesNotRecognizeSelector:selector];
	}
	
	return ret;
}
