//
//  FTPDirectoryParser.h
//
//
//  Created by Sam Deane on 28/05/2013.
//
//

#import "KSFTPLineParser.h"

@interface FTPParseLineParser : NSObject <KSFTPLineParser>

- (NSDictionary*)parseLine:(NSString*)line includingExtraEntries:(BOOL)includingExtraEntries;

@end
