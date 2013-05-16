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

+ (NSArray*)parseData:(NSData*)data
{
    NSString* string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    NSArray* result = [self parseString:string];

    [string release];

    return result;
}

+ (NSArray*)parseString:(NSString*)string
{
    struct ListState state;
    memset(&state, 0, sizeof(state));

    struct ListResult result;
    memset(&result, 0, sizeof(result));

    NSMutableArray* results = [NSMutableArray array];
    NSArray* lines = [string componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    for (NSString* line in lines)
    {
        FTPEntryType type = parseOneFTPLine([line UTF8String], state, result);

        NSDate* time = [[NSDate alloc] initWithTimeIntervalSince1970:mktime(&result.modifiedTime)];
        NSDictionary* info = @{
                               @"type" : @(type),
                               @"name" : result.filename ? @(result.filename) : @"",
                               @"link" : result.linkname ? @(result.linkname) : @"",
                               @"valid" : @(result.valid),
                               @"size": result.fileSize.cocoaString(),
                               @"case" : @(result.caseSensitive),
                               @"modified" : time
                               };
        [time release];

        [results addObject:info];
    }

    return results;
}

@end
