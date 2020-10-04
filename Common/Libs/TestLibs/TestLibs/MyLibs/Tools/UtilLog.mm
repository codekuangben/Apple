#import "MyLibs/Tools/UtilLog.h"

@implementation UtilLog

+ (void) log:(NSString*) strContent, ...
{
    NSLog(strContent);
    va_list list;
    va_start(list, strContent);
    NSString* arg = va_arg(list, id);
    
    while(arg)
    {
        strContent = [NSString stringWithFormat:strContent, arg];
        arg = va_arg(list, id);
    }
    
    va_end(list);
}

+ (void) warn:(NSString*) strContent, ...
{
    NSLog(strContent);
}

+ (void) error:(NSString*) strContent, ...
{
    NSLog(strContent);
}

@end
