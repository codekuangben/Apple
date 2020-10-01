#import "MyLibs/Tools/UtilLog.h"

@implementation UtilLog

+ (void) log:(String) strContent
{
    NSLog(strContent);
}

+ (void) warn:(String) strContent
{
    NSLog(strContent);
}

+ (void) error:(String) strContent
{
    NSLog(strContent);
}

@end