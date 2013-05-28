//
//  KSFTPParserTests.m
//  KSFTPParserTests
//
//  Created by Sam Deane on 16/05/2013.
//  Copyright (c) 2013 Karelia. All rights reserved.
//

#import "BufferParserTests.h"
#import "FTPDirectoryParserLineParser.h"
#import "KSFTPDirectoryParser.h"

@interface BufferParserWithFTPDirectoryParserTests : BufferParserTests

@end

@implementation BufferParserWithFTPDirectoryParserTests

- (id<KSFTPLineParser>)newParser
{
    FTPDirectoryParserLineParser* parser = [[FTPDirectoryParserLineParser alloc] init];

    return parser;
}

- (void)testJunkInput
{
    NSString* input = @"Blah\nBlah\nBlah";
    id<KSFTPLineParser> parser = [self newParser];
    if (parser)
    {
        NSArray* items = [KSFTPBufferParser parseString:input parser:parser includingExtraEntries:YES];

        STAssertEquals([items count], (NSUInteger)3, @"expected 3 results, got %ld", [items count]);
        for (NSDictionary* item in items)
        {
            KSFTPEntryType type = (KSFTPEntryType) [[item objectForKey:@"type"] integerValue];
            STAssertEquals(type, KSFTPMiscEntry, @"expected type 3, got %ld", type);
        }
        [parser release];
    }
}

@end
