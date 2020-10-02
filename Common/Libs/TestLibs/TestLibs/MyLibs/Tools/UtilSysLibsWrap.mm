#import "MyLibs/Tools/UtilSysLibsWrap.h"
#import <Foundation/Foundation.h>
#import "MyLibs/Base/GObject.h"
"
static NSString* CR_LF = @"\\r\\n";

@implementation UtilSysLibsWrap

+ (MEncoding*) convGkEncode2EncodingEncoding:(GkEncode) gkEncode
{
    /*
    MEncoding* retEncode = MEncoding.UTF8;

    if (GkEncode.eUTF8 == gkEncode)
    {
        retEncode = MEncoding.UTF8;
    }
    else if (GkEncode.eGB2312 == gkEncode)
    {
        retEncode = MEncoding.UTF8;
    }
    else if (GkEncode.eUnicode == gkEncode)
    {
        retEncode = MEncoding.Unicode;
    }
    else if (GkEncode.eDefault == gkEncode)
    {
        retEncode = MEncoding.Default;
    }
     */

    MEncoding* retEncode = nil;
    return retEncode;
}

// 判断两个 GameObject 地址是否相等
+ (BOOL) isAddressEqual:(GObject*) a b:(GObject*) b
{
    return a == b;
}

// 判断两个函数是否相等，不能使用 isAddressEqual 判断函数是否相等
+ (BOOL) isDelegateEqual:(GObject<IDispatchObject>*) a b:(GObject<IDispatchObject>*) b
{
    return a == b;
}

+ (int) getScreenWidth
{
    return 1000;
}

+ (int) getScreenHeight
{
    return 1000;
}

+ (NSString*) getFormatTime
{
    Date currentTime = new Date();
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    NSString* dateString = formatter.format(currentTime);
    return dateString;
}

+ (void) printCallStack
{
    Throwable ex = new Throwable();

    StackTraceElement[] stackElements = ex.getStackTrace();

    if(stackElements != nil)
    {
        for((int) i = 0; i < stackElements.length; i++)
        {
            System.out.println(stackElements[i].getClassName());
            System.out.println(stackElements[i].getFileName());
            System.out.println(stackElements[i].getLineNumber());
            System.out.println(stackElements[i].getMethodName());
            System.out.println("-----------------------------------");
        }
    }
}

@end
