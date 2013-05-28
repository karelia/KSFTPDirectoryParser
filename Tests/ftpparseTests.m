//
//  KSFTPParserTests.m
//  KSFTPParserTests
//
//  Created by Sam Deane on 16/05/2013.
//  Copyright (c) 2013 Karelia. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "ftpparse.h"

@interface FTPDirectoryParserTests : SenTestCase

@end

@implementation FTPDirectoryParserTests

- (void)testJunk
{
    const char* input = "This is a test";

    struct ftpparse info;
    memset(&info, 0, sizeof(info));

    int result = ftpparse(&info, (char*)input, strlen(input));

    STAssertEquals(result, 0, @"didn't expect to find a filename");
}

- (void)testDOSFile
{
    const char* input = "11-12-69  03:04AM                7352 file1.txt\r\n";

    struct ftpparse info;
    memset(&info, 0, sizeof(info));

    int result = ftpparse(&info, (char*)input, strlen(input));

    STAssertEquals(result, 1, @"expected to find a filename");
    STAssertTrue(strcmp(info.name, "file1.txt\r\n") == 0, @"unexpected name %s", info.name);
    STAssertEquals(info.mtimetype, FTPPARSE_MTIME_REMOTEMINUTE, @"unexpected time type %d", info.mtimetype);
    STAssertEquals(info.mtime, (time_t) -4308960, @"expected time value %d", info.mtime);
    STAssertEquals(info.sizetype, FTPPARSE_SIZE_BINARY, @"expected size type %d", info.sizetype);
    STAssertEquals(info.size, 7352L, @"expected size %d", info.size);
}

- (void)testDOSDirectory
{
    const char* input = "11-12-69  01:02PM      <DIR>          directory\r\n";

    struct ftpparse info;
    memset(&info, 0, sizeof(info));

    int result = ftpparse(&info, (char*)input, strlen(input));

    STAssertEquals(result, 1, @"expected to find a filename");
    STAssertTrue(strcmp(info.name, "directory\r\n") == 0, @"unexpected name %s", info.name);
    STAssertEquals(info.mtimetype, FTPPARSE_MTIME_REMOTEMINUTE, @"unexpected time type %d", info.mtimetype);
    STAssertEquals(info.mtime, (time_t) -4273080, @"expected time value %d", info.mtime);

}



#if 0

- (void)testUnix
{
    NSString* input = @"total 1\r\n"
    "drw-------   1 user  staff     3 Nov  12  1969 directory\r\n"
    "-rw-------   1 user  staff     3 Nov  12  1969 file1.txt\r\n"
    "-rw-------   1 user  staff     3 Nov  12  1969 file2.txt\r\n\r\n";

    NSArray* items = [KSFTPDirectoryParser parseString:input includingExtraEntries:NO];
    STAssertTrue([self checkItems:items], @"unexpected output: %@", items);
}

#endif

@end

