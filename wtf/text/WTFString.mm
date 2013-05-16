//
//  String.cpp
//  KSFTPParser
//
//  Created by Sam Deane on 16/05/2013.
//  Copyright (c) 2013 Karelia. All rights reserved.
//

#include "WTFString.h"

String::String() : string(nil)
{
}

String::String(NSString* string) : string(string)
{

}

String::String(const char* bytes, int64_t length)
{
    string = [[NSString alloc] initWithBytes:bytes length:length encoding:NSASCIIStringEncoding];
}

String::~String()
{
    [string release];
}

void String::truncate(int64_t length)
{
    [string release];
    string = nil;
}

String String::number(int64_t value)
{
    return String([@(value) description]);
}

uint64_t String::toUInt()
{
    return [string integerValue];
}
