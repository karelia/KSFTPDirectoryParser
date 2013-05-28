//
//  FTPDirectoryParser.h
//
//
//  Created by Sam Deane on 28/05/2013.
//
//

#import "KSFTPLineParser.h"

@interface FTPDirectoryParserLineParser : NSObject <KSFTPLineParser>
{
    void* _state;
    NSCalendar* _calendar;
    NSTimeZone* _zone;
}
- (NSDictionary*)parseLine:(NSString*)line includingExtraEntries:(BOOL)includingExtraEntries;

@end
