//
//  FTPDirectoryParser.h
//
//
//  Created by Sam Deane on 28/05/2013.
//
//

@interface FTPDirectoryParser : NSObject
{
    void* _state;
    NSCalendar* _calendar;
    NSTimeZone* _zone;
}
- (NSDictionary*)parseLine:(NSString*)line includingExtraEntries:(BOOL)includingExtraEntries;

@end
