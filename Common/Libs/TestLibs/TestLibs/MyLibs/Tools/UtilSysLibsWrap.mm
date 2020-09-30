#import "MyLibs/Tools/UtilSysLibsWrap.h"

@implementation UtilSysLibsWrap

static final String CR_LF = "\\r\\n";

+ (MEncoding) convGkEncode2EncodingEncoding:(GkEncode) gkEncode
{
    MEncoding retEncode = MEncoding.UTF8;

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

    return retEncode;
}

// 判断两个 GameObject 地址是否相等
+ (BOOL) isAddressEqual:(Object) a b:(Object) b
{
    return a.equals(b);
}

// 判断两个函数是否相等，不能使用 isAddressEqual 判断函数是否相等
+ (BOOL) isDelegateEqual:(IDispatchObject) a b:(IDispatchObject) b
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

+ (NSString) getFormatTime
{
    Date currentTime = new Date();
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String dateString = formatter.format(currentTime);
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
