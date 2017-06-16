#import "UtilStr.h"

/**
 * @brief 对 api 的进一步 wrap
 */
@implementation UtilStr

+ (bool) isEqualToString:(NSString*)strA strB:(NSString*)strB
{
	BOOL ret = [strA isEqualToString:strB];
	return	ret;
}

@end