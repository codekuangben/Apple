#import "MyLibs/Tools/UtilLog.h"

@implementation UtilLog

+ (void) log:(NSString*) strContent ...
{
    NSLog(strContent, ...);
}

+ (void) warn:(NSString*) strContent ...
{
    NSLog(strContent, ...);
}

+ (void) error:(NSString*) strContent ...
{
    NSLog(strContent, ...);
}

@end