//
//  KSFTPParser.m
//  
//
//  Created by Sam Deane on 16/05/2013.
//
//

#import "KSFTPDirectoryParser.h"
#import "FTPDirectoryParserLineParser.h"

@interface KSFTPDirectoryParser()

@end

@implementation KSFTPDirectoryParser

+ (NSArray*)parseData:(NSData*)data includingExtraEntries:(BOOL)includingExtraEntries
{
    NSString* string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    NSArray* result = [self parseString:string includingExtraEntries:includingExtraEntries];

    [string release];

    return result;
}

+ (NSArray*)parseString:(NSString*)string includingExtraEntries:(BOOL)includingExtraEntries
{
    FTPDirectoryParserLineParser* parser = [[FTPDirectoryParserLineParser alloc] init];
    NSMutableArray* results = [NSMutableArray array];
    NSArray* lines = [string componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];

    for (NSString* line in lines)
    {
        NSDictionary* info = [parser parseLine:line includingExtraEntries:includingExtraEntries];
        if (info)
        {
            [results addObject:info];
        }
    }

    [parser release];

    return results;
}

@end
