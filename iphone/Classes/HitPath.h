//
//  HitPath.h
//  AffiliateStats
//
//  Created by Andy Triboletti on 5/27/09.
//  Copyright 2009 GreenRobot LLC. All rights reserved.
//
#import "GRDownloader.h"


@interface HitPath : NSObject {
	
}

- (void) getStats:(NSString*)networkClientCode2 key:(NSString*)networkApiKey url:(NSString*)networkUrl2;
-(void)gotReportData:(GRDownloader *)downloader;

@end
