#ifndef __UtilStr_h
#define __UtilStr_h

#import <Foundation/Foundation.h>
#import "MyLibs/Base/GObject.h"

/**
 * @brief 对 api 的进一步 wrap
 */
@interface UtilStr : GObject
{

}

+ (BOOL) isEqualToString:(NSString*)strA strB:(NSString*)strB;

@end

#endif
