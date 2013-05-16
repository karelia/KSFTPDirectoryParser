//
//  String.h
//  KSFTPParser
//
//  Created by Sam Deane on 16/05/2013.
//  Copyright (c) 2013 Karelia. All rights reserved.
//

#ifndef __KSFTPParser__String__
#define __KSFTPParser__String__

#include <iostream>

/** 
 Just enough of a string class for the FTPDirectoryParser code to compile.
 
 Implementation just wraps an NSString.
 */

@class NSString;

class String
{
public:
    String();
    String(NSString* string);
    String(const char*, int64_t length);
    String(const String& string);
    ~String();

    void truncate(int64_t length);
    static String number(int64_t value);
    uint64_t toUInt();

    String& operator=( const String& rhs );

    NSString* cocoaString();

private:
    NSString* string;
};

#endif /* defined(__KSFTPParser__String__) */
