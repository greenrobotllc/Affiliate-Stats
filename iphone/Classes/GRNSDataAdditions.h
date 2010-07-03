//
//  GRNSDataCCAdditions.h
//  flutter
//
//  Created by Adam Markey on 7/1/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

@interface NSData (GRNSDataAdditions)

- (NSData *)MD2;
- (NSData *)MD4;
- (NSData *)MD5;
- (NSData *)SHA1;
- (NSData *)SHA224;
- (NSData *)SHA256;
- (NSData *)SHA384;
- (NSData *)SHA512;

- (NSString*) stringWithHexBytes;

@end
