//
//  KSFTPParserTests.m
//  KSFTPParserTests
//
//  Created by Sam Deane on 16/05/2013.
//  Copyright (c) 2013 Karelia. All rights reserved.
//

#import "KSFTPParserTests.h"

#import "FTPDirectoryParser.h"

using namespace WebCore;

@implementation KSFTPParserTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    const char* input = "This is a test";

    struct ListState state;
    memset(&state, 0, sizeof(state));

    struct ListResult result;
    memset(&result, 0, sizeof(result));

    FTPEntryType type = parseOneFTPLine(input, state, result);

    STAssertEquals(type, FTPMiscEntry, @"expected junk type got %d", type);
}

@end
