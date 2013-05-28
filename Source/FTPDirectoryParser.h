
@interface FTPDirectoryParser : NSObject

- (NSDictionary*)parseLine:(NSString*)line includingExtraEntries:(BOOL)includingExtraEntries;

@end
