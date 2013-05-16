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

@interface KSFTPParser : NSObject

+ (NSArray*)parseData:(NSData*)data;
+ (NSArray*)parseString:(NSString*)string;

@end
