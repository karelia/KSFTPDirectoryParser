//
//  KSFTPParser.m
//  
//
//  Created by Sam Deane on 16/05/2013.
//
//

#import "KSFTPBufferParser.h"
#import "FTPDirectoryParserLineParser.h"

@interface KSFTPBufferParser()

@end

@implementation KSFTPBufferParser

+ (NSArray*)parseData:(NSData*)data parser:(id<KSFTPLineParser>)parser includingExtraEntries:(BOOL)includingExtraEntries
{
    NSString* string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    NSArray* result = [self parseString:string parser:parser includingExtraEntries:includingExtraEntries];

    [string release];

    return result;
}

+ (NSArray*)parseString:(NSString*)string parser:(id<KSFTPLineParser>)parser includingExtraEntries:(BOOL)includingExtraEntries
{
    NSMutableArray* results = [NSMutableArray array];
    NSArray* lines = [string componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];

    NSCharacterSet* set = [NSCharacterSet newlineCharacterSet];
    for (NSString* line in lines)
    {
        NSString* stripped = [line stringByTrimmingCharactersInSet:set];
        NSDictionary* info = [parser parseLine:stripped includingExtraEntries:includingExtraEntries];
        if (info)
        {
            [results addObject:info];
        }
    }

    return results;
}

@end
