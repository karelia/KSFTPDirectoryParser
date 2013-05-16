//
//  KSFTPParser.m
//  
//
//  Created by Sam Deane on 16/05/2013.
//
//

#import "KSFTPParser.h"
#import "FTPDirectoryParser.h"

@interface KSFTPParser()

@end

using namespace WebCore;

@implementation KSFTPParser

+ (NSArray*)parseData:(NSData*)data
{
    NSString* string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    return [self parseString:string];
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
        NSDictionary* info = @{ @"type" : @(type) };
        [results addObject:info];
    }

    return results;
}

@end
