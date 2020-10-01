#import <Foundation/Foundation.h>
#import "MyLibs/Base/UniqueNumIdGen.h"

/**
 * @brief 唯一字符串生成器
 */
@interface UniqueStrIdGen : UniqueNumIdGen
{
@protected
    String mPrefix;
    String mRetId;
}

- (id) init: (String) prefix baseUniqueId: (int) baseUniqueId;
- (String) genNewStrId;
- (String) getCurStrId;
- (String) genStrIdById: (int) id;

@end
