#import <MyLibs/Tools/MEncoding.h>
#import <MyLibs/Tools/GkEncode.h>
#import <MyLibs/EventHandle/IDispatchObject.h>
#import <Foundation/Foundation.h>
/**
 * @brief 对 api 的进一步 wrap
 */
@interface UtilSysLibsWrap
{
@public
    
}

+ (MEncoding) convGkEncode2EncodingEncoding:(GkEncode) gkEncode;
// 判断两个 GameObject 地址是否相等
+ (BOOL) isAddressEqual:(Object) a b:(Object) b;
// 判断两个函数是否相等，不能使用 isAddressEqual 判断函数是否相等
+ (BOOL) isDelegateEqual:(IDispatchObject) a b:(IDispatchObject) b;
+ (int) getScreenWidth;
+ (int) getScreenHeight;
+ (NSString*) getFormatTime;
+ (void) printCallStack;

@end
