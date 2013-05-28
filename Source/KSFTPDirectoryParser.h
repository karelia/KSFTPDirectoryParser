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

@protocol KSFTPLineParser;

@interface KSFTPDirectoryParser : NSObject

+ (NSArray*)parseData:(NSData*)data parser:(id<KSFTPLineParser>)parser includingExtraEntries:(BOOL)includingExtraEntries;
+ (NSArray*)parseString:(NSString*)string parser:(id<KSFTPLineParser>)parser includingExtraEntries:(BOOL)includingExtraEntries;

@end
