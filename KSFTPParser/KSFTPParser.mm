//
//  KSFTPParser.m
//  
//
//  Created by Sam Deane on 16/05/2013.
//
//

#import "KSFTPParser.h"
#import "FTPDirectoryParser.h"

#import <time.h>

@interface KSFTPParser()

@end

using namespace WebCore;

@implementation KSFTPParser

+ (NSArray*)parseData:(NSData*)data includingExtraEntries:(BOOL)includingExtraEntries
{
    NSString* string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    NSArray* result = [self parseString:string includingExtraEntries:includingExtraEntries];

    [string release];

    return result;
}

+ (NSArray*)parseString:(NSString*)string includingExtraEntries:(BOOL)includingExtraEntries
{
    struct ListState state;
    memset(&state, 0, sizeof(state));

    struct ListResult result;
    memset(&result, 0, sizeof(result));

    NSMutableArray* results = [NSMutableArray array];
    NSArray* lines = [string componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    for (NSString* line in lines)
    {
        FTPEntryType type = parseOneFTPLine([line UTF8String], state, result);
        if (includingExtraEntries || ((type != FTPJunkEntry) && (type != FTPMiscEntry)))
        {
            NSDateComponents* components = [[NSDateComponents alloc] init];
            components.year = result.modifiedTime.tm_year;
            components.month = result.modifiedTime.tm_mon;
            components.day = result.modifiedTime.tm_mday;
            components.hour = result.modifiedTime.tm_hour;
            components.minute = result.modifiedTime.tm_min;
            components.second = result.modifiedTime.tm_sec;
            components.timeZone = [NSTimeZone systemTimeZone];
            NSDate* time = [calendar dateFromComponents:components];
            [components release];
            NSDictionary* info = @{
                                   @"type" : @(type),
                                   @"name" : result.filename ? @(result.filename) : @"",
                                   @"link" : result.linkname ? @(result.linkname) : @"",
                                   @"valid" : @(result.valid),
                                   @"size": result.fileSize.cocoaString(),
                                   @"case" : @(result.caseSensitive),
                                   @"modified" : time
                                   };
            
            [results addObject:info];
        }
    }

    return results;
}

@end
