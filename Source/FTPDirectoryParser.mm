#import "FTPDirectoryParser.h"
#import "FTPDirectoryParserInternal.h"

using namespace WebCore;

@interface FTPDirectoryParser()

@property (assign, nonatomic) struct ListState state;
@property (strong, nonatomic) NSCalendar* calendar;
@property (strong, nonatomic) NSTimeZone* zone;

@end

@implementation FTPDirectoryParser

- (id)init
{
    if ((self = [super init]) != nil)
    {
        self.calendar = [NSCalendar currentCalendar];
        self.zone = [NSTimeZone timeZoneWithName:@"UTC"];
    }

    return self;
}

- (void)dealloc
{
    [_calendar release];
    [_zone release];

    [super dealloc];
}

- (NSDictionary*)parseLine:(NSString*)line includingExtraEntries:(BOOL)includingExtraEntries
{
    struct ListResult parsed;
    memset(&parsed, 0, sizeof(parsed));

    NSDictionary* result = nil;
    FTPEntryType type = parseOneFTPLine([line UTF8String], _state, parsed);
    if (includingExtraEntries || ((type != FTPJunkEntry) && (type != FTPMiscEntry)))
    {
        NSDateComponents* components = [[NSDateComponents alloc] init];
        components.year = parsed.modifiedTime.tm_year;
        components.month = parsed.modifiedTime.tm_mon + 1;
        components.day = parsed.modifiedTime.tm_mday;
        components.hour = parsed.modifiedTime.tm_hour;
        components.minute = parsed.modifiedTime.tm_min;
        components.second = parsed.modifiedTime.tm_sec;
        components.timeZone = self.zone;
        NSDate* time = [self.calendar dateFromComponents:components];
        [components release];
        result = @{
                               @"type" : @(type),
                               @"name" : parsed.filename ? @(parsed.filename) : @"",
                               @"link" : parsed.linkname ? @(parsed.linkname) : @"",
                               @"valid" : @(parsed.valid),
                               @"size": parsed.fileSize.cocoaString(),
                               @"case" : @(parsed.caseSensitive),
                               @"modified" : time
                               };

    }

    return result;
}

@end
