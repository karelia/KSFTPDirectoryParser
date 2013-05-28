//
//  KSFTPParserTests.m
//  KSFTPParserTests
//
//  Created by Sam Deane on 16/05/2013.
//  Copyright (c) 2013 Karelia. All rights reserved.
//

#import "BufferParserTests.h"
#import "FTPParseLineParser.h"

@interface BufferParserWithFTPParseTests : BufferParserTests

@end

@implementation BufferParserWithFTPParseTests

- (id<KSFTPLineParser>)newParser
{
    FTPParseLineParser* parser = [[FTPParseLineParser alloc] init];

    return parser;
}

@end