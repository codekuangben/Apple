#import <Foundation/Foundation.h>
#import "MyLibs/Test/UniqueNumIdGen.h"

/**
 * @brief 唯一字符串生成器
 */
@interface UniqueStrIdGen : UniqueNumIdGen
{
@protected
    NSString* mPrefix;
    NSString* mRetId;
}

- (id) init: (NSString*) prefix baseUniqueId: (int) baseUniqueId;
- (NSString*) genNewStrId();
- (NSString*) getCurStrId();
- (NSString*) genStrIdById: (int) id;

@end