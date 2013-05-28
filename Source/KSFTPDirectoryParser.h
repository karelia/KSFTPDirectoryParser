//
//  KSFTPParser.h
//  
//
//  Created by Sam Deane on 16/05/2013.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, KSFTPEntryType)
{
    KSFTPDirectoryEntry,
    KSFTPFileEntry,
    KSFTPLinkEntry,
    KSFTPMiscEntry,
    KSFTPJunkEntry
};

@interface KSFTPDirectoryParser : NSObject

+ (NSArray*)parseData:(NSData*)data includingExtraEntries:(BOOL)includingExtraEntries;
+ (NSArray*)parseString:(NSString*)string includingExtraEntries:(BOOL)includingExtraEntries;

@end
