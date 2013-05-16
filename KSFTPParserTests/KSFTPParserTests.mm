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
    NSString* testInput = @"Blah\nBlah\nBlah";
    NSArray* items = [KSFTPParser parseString:testInput];

    STAssertEquals([items count], 3UL, @"expected 3 results, got %ld", [items count]);
    for (NSDictionary* item in items)
    {
        KSFTPEntryType type = (KSFTPEntryType) [item[@"type"] integerValue];
        STAssertEquals(type, KSFTPMiscEntry, @"expected type 3, got %ld", type);
    }
    
}

@end
