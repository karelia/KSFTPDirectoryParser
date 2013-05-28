//
//  KSFTPLineParser.h
//  
//
//  Created by Sam Deane on 16/05/2013.
//
//

@protocol KSFTPLineParser <NSObject>

- (NSDictionary*)parseLine:(NSString*)line includingExtraEntries:(BOOL)includingExtraEntries;

@end