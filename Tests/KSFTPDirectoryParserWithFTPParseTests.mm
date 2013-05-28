//
//  KSFTPParserTests.m
//  KSFTPParserTests
//
//  Created by Sam Deane on 16/05/2013.
//  Copyright (c) 2013 Karelia. All rights reserved.
//

#import "KSFTPDirectoryParserTests.h"
#import "FTPParseLineParser.h"

@interface KSFTPDirectoryParserWithFTPParseTests : KSFTPDirectoryParserTests

@end

@implementation KSFTPDirectoryParserWithFTPParseTests

- (id<KSFTPLineParser>)newParser
{
    FTPParseLineParser* parser = [[FTPParseLineParser alloc] init];

    return parser;
}

@end