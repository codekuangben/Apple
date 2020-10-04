#import <MyLibs/Tools/MEncoding.h>
#import <MyLibs/Tools/MEncode.h>
#import <MyLibs/EventHandle/IDispatchObject.h>
#import <Foundation/Foundation.h>
#import "MyLibs/Base/GObject.h"
#import "MyLibs/Base/GObject.h"

/**
 * @brief 对 api 的进一步 wrap
 */
@interface UtilSysLibsWrap : GObject
{
@public
    
}

+ (MEncoding*) convGkEncode2EncodingEncoding:(MEncode) gkEncode;
// 判断两个 GameObject 地址是否相等
+ (BOOL) isAddressEqual:(GObject*) a b:(GObject*) b;
// 判断两个函数是否相等，不能使用 isAddressEqual 判断函数是否相等
+ (BOOL) isDelegateEqual:(GObject<IDispatchObject>*) a b:(GObject<IDispatchObject>*) b;
+ (int) getScreenWidth;
+ (int) getScreenHeight;
+ (NSString*) getFormatTime;
+ (void) printCallStack;

@end
