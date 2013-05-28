This library generalises the process of parsing the listing that you get back from an FTP server.

It currently wraps two alternative solutions to this problem:

- FTPDirectoryParser
- ftpparse

These are separate open source projects, with different licensing requirements.

# Usage

Make a parser, either FTPParseLineParser or FTPDirectoryParserLineParser:

    id<KSFTPLineParser> lineParser = [[FTPParseLineParser alloc] init];


Either feed it individual lines:

    NSDictionary* info = [lineParser parseLine:line includingExtraEntries:NO];


Or use KSFTPBufferParser to feed it a whole listing:

    NSArray* items = [KSFTPBufferParser parseString:listing parser:lineParser includingExtraEntries:NO];


# Items

Each returned item is a dictionary containing a few potential keys.

The exact keys depend on the parser used, but the following keys should be returned by all parsers:

- type: a KSFTPEntryType constant describing the item type
- name: the item's name (NSString)
- size: the item's size (NSNumber)
- modified: the modification date of the item (NSDate)


# Parsers

## FTPDirectoryParser

This is part of WebCore, and thus is distributed as LGPL:

    https://github.com/WebKit/webkit/blob/master/Source/WebCore/loader/FTPDirectoryParser.h
    https://github.com/WebKit/webkit/blob/master/Source/WebCore/loader/FTPDirectoryParser.cpp

The code relies on the wtf String, and a few other utilities.

The KSFTPDirectoryParser wrapper doesn't pull in wtf - instead it provides a fake String implementation with just enough functionality for the parsing.

## ftpparse

This is a C implementation, available here:

    http://cr.yp.to/ftpparse.html
    

The licensing terms are somewhat vague: 

    "Commercial use of ftpparse is fine, as long as you let me know what programs you're using it in."
    
