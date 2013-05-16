//
//  KSFTPParserTests.m
//  KSFTPParserTests
//
//  Created by Sam Deane on 16/05/2013.
//  Copyright (c) 2013 Karelia. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "KSFTPParser.h"

@interface KSFTPParserTests : SenTestCase

@end

@implementation KSFTPParserTests

- (void)testJunkInput
{
    NSString* input = @"Blah\nBlah\nBlah";
    NSArray* items = [KSFTPParser parseString:input includingExtraEntries:YES];

    STAssertEquals([items count], 3UL, @"expected 3 results, got %ld", [items count]);
    for (NSDictionary* item in items)
    {
        KSFTPEntryType type = (KSFTPEntryType) [item[@"type"] integerValue];
        STAssertEquals(type, KSFTPMiscEntry, @"expected type 3, got %ld", type);
    }
    
}

- (void)testWindows
{
    NSString* input = @"01-03-13  01:03PM      <DIR>          _Media\r\n"
    "01-10-13  11:30AM      <DIR>          _Resources\r\n"
    "12-10-12  10:05PM      <DIR>          App_Data\r\n"
    "01-10-13  11:37AM                7352 contact-form.html\r\n"
    "12-10-12  10:04PM      <DIR>          css\r\n"
    "01-10-13  11:01AM                5246 favicon.ico\r\n"
    "12-10-12  10:04PM                  886 header.js\r\n"
    "12-10-12  10:04PM      <DIR>          img\r\n"
    "01-10-13  11:01AM                7068 index.html\r\n"
    "12-18-12  05:12PM      <DIR>          photo-album\r\n"
    "12-10-12  10:04PM      <DIR>          picture_library\r\n"
    "12-18-12  04:59PM      <DIR>          sandvox_TelegraphOffice_cedar\r\n"
    "12-10-12  10:04PM      <DIR>          test\r\n"
    "01-10-13  11:01AM                12349 the-band.html\r\n"
    "01-10-13  11:02AM                7723 videos.html";

    NSArray* items = [KSFTPParser parseString:input includingExtraEntries:NO];

    NSLog(@"items %@", items);
    
    STAssertEquals([items count], 3UL, @"expected 3 results, got %ld", [items count]);
    for (NSDictionary* item in items)
    {
        KSFTPEntryType type = (KSFTPEntryType) [item[@"type"] integerValue];
        STAssertEquals(type, KSFTPMiscEntry, @"expected type 3, got %ld", type);
    }

    
}

- (void)testUnix
{
    NSString* input = @"total 1\r\n"
    "-rw-------   1 user  staff     3 Mar  6  2012 file1.txt\r\n"
    "-rw-------   1 user  staff     3 Mar  6  2012 file2.txt\r\n\r\n";

    NSArray* items = [KSFTPParser parseString:input includingExtraEntries:NO];

    NSLog(@"items %@", items);

    STAssertEquals([items count], 3UL, @"expected 3 results, got %ld", [items count]);
    for (NSDictionary* item in items)
    {
        KSFTPEntryType type = (KSFTPEntryType) [item[@"type"] integerValue];
        STAssertEquals(type, KSFTPMiscEntry, @"expected type 3, got %ld", type);
    }
    

}
@end
