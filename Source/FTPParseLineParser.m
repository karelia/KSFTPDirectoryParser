#import "FTPParseLineParser.h"
#import "ftpparse.h"

@interface FTPParseLineParser()

@end

@implementation FTPParseLineParser

- (id)init
{
    if ((self = [super init]) != nil)
    {
    }

    return self;
}

- (NSDictionary*)parseLine:(NSString*)line includingExtraEntries:(BOOL)includingExtraEntries
{
    struct ftpparse info;
    memset(&info, 0, sizeof(info));

    NSDictionary* result = nil;

    int parsed = ftpparse(&info, (char*) [line UTF8String], (int) [line length]);
    if (parsed == 1)
    {
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:info.mtime];

        NSString* name = [[NSString alloc] initWithUTF8String:info.name];
        result = @{
                   @"name" : name,
                   @"size": @(info.size),
                   @"modified" : date
                   };

        [name release];
    }

    return result;
}

@end
