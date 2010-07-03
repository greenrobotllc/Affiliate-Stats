//
//  GRNSDataCCAdditions.m
//  flutter
//
//  Created by Adam Markey on 7/1/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "GRNSDataAdditions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (GRNSDataAdditions)

- (NSData *)MD2 {
	unsigned char md[CC_MD2_DIGEST_LENGTH];
	CC_MD2([self bytes], [self length], md);
	
	return [NSData dataWithBytes:md length:CC_MD2_DIGEST_LENGTH];
}

- (NSData *)MD4 {
	unsigned char md[CC_MD4_DIGEST_LENGTH];
	CC_MD4([self bytes], [self length], md);
	
	return [NSData dataWithBytes:md length:CC_MD4_DIGEST_LENGTH];
}

- (NSData *)MD5 {
	unsigned char md[CC_MD5_DIGEST_LENGTH];
	CC_MD5([self bytes], [self length], md);
	
	return [NSData dataWithBytes:md length:CC_MD5_DIGEST_LENGTH];
}

- (NSData *)SHA1 {
	unsigned char md[CC_SHA1_DIGEST_LENGTH];
	CC_SHA1([self bytes], [self length], md);
	
	return [NSData dataWithBytes:md length:CC_SHA1_DIGEST_LENGTH];
}

- (NSData *)SHA224 {
	unsigned char md[CC_SHA224_DIGEST_LENGTH];
	CC_SHA224([self bytes], [self length], md);
	
	return [NSData dataWithBytes:md length:CC_SHA224_DIGEST_LENGTH];
}

- (NSData *)SHA256 {
	unsigned char md[CC_SHA256_DIGEST_LENGTH];
	CC_SHA256([self bytes], [self length], md);
	
	return [NSData dataWithBytes:md length:CC_SHA256_DIGEST_LENGTH];
}

- (NSData *)SHA384 {
	unsigned char md[CC_SHA384_DIGEST_LENGTH];
	CC_SHA384([self bytes], [self length], md);
	
	return [NSData dataWithBytes:md length:CC_SHA384_DIGEST_LENGTH];
}

- (NSData *)SHA512 {
	unsigned char md[CC_SHA512_BLOCK_BYTES];
	CC_SHA512([self bytes], [self length], md);
	
	return [NSData dataWithBytes:md length:CC_SHA512_BLOCK_BYTES];
}

- (NSString*) stringWithHexBytes {
	NSMutableString *stringBuffer = [NSMutableString stringWithCapacity:([self length] * 2)];
	const unsigned char *dataBuffer = [self bytes];
	int i;
	
	for (i = 0; i < [self length]; ++i)
		[stringBuffer appendFormat:@"%02x", (unsigned long)dataBuffer[ i ]];
	
	return [NSString stringWithString:stringBuffer];
}

@end
