//
//  KSFTPParserTests.m
//  KSFTPParserTests
//
//  Created by Sam Deane on 16/05/2013.
//  Copyright (c) 2013 Karelia. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "ftpparse.h"

@interface ftpParseTests : SenTestCase

@end

@implementation ftpParseTests

- (void)testJunk
{
    const char* input = "total 1"; // typical clutter at the beginning of a unix-style listing

    struct ftpparse info;
    memset(&info, 0, sizeof(info));

    int result = ftpparse(&info, (char*)input, strlen(input));

    STAssertEquals(result, 0, @"didn't expect to find a filename");
}

- (void)testDOSFile
{
    const char* input = "11-12-69  03:04AM                7352 file1.txt";

    struct ftpparse info;
    memset(&info, 0, sizeof(info));

    int result = ftpparse(&info, (char*)input, strlen(input));

    STAssertEquals(result, 1, @"expected to find a filename");
    STAssertTrue(strcmp(info.name, "file1.txt") == 0, @"unexpected name %s", info.name);
    STAssertEquals(info.mtimetype, FTPPARSE_MTIME_REMOTEMINUTE, @"unexpected time type %d", info.mtimetype);
    STAssertEquals(info.mtime, (time_t) -4308960, @"expected time value %d", info.mtime);
    STAssertEquals(info.sizetype, FTPPARSE_SIZE_BINARY, @"expected size type %d", info.sizetype);
    STAssertEquals(info.size, 7352L, @"expected size %d", info.size);

    NSDate* date = [NSDate dateWithTimeIntervalSince1970:info.mtime];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];

    STAssertEquals(components.year, (NSInteger)1969, @"unexpected year %d", components.year);
    STAssertEquals(components.month, (NSInteger)11, @"unexpected month %d", components.month);
    STAssertEquals(components.day, (NSInteger)12, @"unexpected day %d", components.day);
}

- (void)testDOSDirectory
{
    const char* input = "11-12-69  01:02PM      <DIR>          directory";

    struct ftpparse info;
    memset(&info, 0, sizeof(info));

    int result = ftpparse(&info, (char*)input, strlen(input));

    STAssertEquals(result, 1, @"expected to find a filename");
    STAssertTrue(strcmp(info.name, "directory") == 0, @"unexpected name %s", info.name);
    STAssertEquals(info.mtimetype, FTPPARSE_MTIME_REMOTEMINUTE, @"unexpected time type %d", info.mtimetype);
    STAssertEquals(info.mtime, (time_t) -4273080, @"expected time value %d", info.mtime);

    NSDate* date = [NSDate dateWithTimeIntervalSince1970:info.mtime];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];

    STAssertEquals(components.year, (NSInteger)1969, @"unexpected year %d", components.year);
    STAssertEquals(components.month, (NSInteger)11, @"unexpected month %d", components.month);
    STAssertEquals(components.day, (NSInteger)12, @"unexpected day %d", components.day);
}

- (void)testUnixFile
{
    const char* input = "-rw-------   1 ftptest  staff  2774 Nov 12 02:16 file2.txt";

    struct ftpparse info;
    memset(&info, 0, sizeof(info));

    int result = ftpparse(&info, (char*)input, strlen(input));

    STAssertEquals(result, 1, @"expected to find a filename");
    STAssertTrue(strcmp(info.name, "file2.txt") == 0, @"unexpected name %s", info.name);
    STAssertEquals(info.mtimetype, FTPPARSE_MTIME_REMOTEMINUTE, @"unexpected time type %d", info.mtimetype);
    STAssertEquals(info.mtime, (time_t) 1352686560, @"unexpected time value %d", info.mtime);
    STAssertEquals(info.sizetype, FTPPARSE_SIZE_BINARY, @"expected size type %d", info.sizetype);
    STAssertEquals(info.size, 2774L, @"expected size %d", info.size);

    NSDate* date = [NSDate dateWithTimeIntervalSince1970:info.mtime];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];

    STAssertEquals(components.month, (NSInteger)11, @"unexpected month %d", components.month);
    STAssertEquals(components.day, (NSInteger)12, @"unexpected day %d", components.day);
}

- (void)testUnixDirectory
{
    const char* input = "drwx------   3 ftptest  staff   102 Nov  12 14:54 directory";

    struct ftpparse info;
    memset(&info, 0, sizeof(info));

    int result = ftpparse(&info, (char*)input, strlen(input));

    STAssertEquals(result, 1, @"expected to find a filename");
    STAssertTrue(strcmp(info.name, "directory") == 0, @"unexpected name %s", info.name);
    STAssertEquals(info.mtimetype, FTPPARSE_MTIME_REMOTEMINUTE, @"unexpected time type %d", info.mtimetype);
    STAssertEquals(info.mtime, (time_t) 1352732040, @"unexpected time value %d", info.mtime);

    NSDate* date = [NSDate dateWithTimeIntervalSince1970:info.mtime];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];

    STAssertEquals(components.month, (NSInteger)11, @"unexpected month %d", components.month);
    STAssertEquals(components.day, (NSInteger)12, @"unexpected day %d", components.day);
}

@end

