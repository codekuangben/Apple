#ifndef __UniqueStrIdGen_h
#define __UniqueStrIdGen_h

@import "UniqueNumIdGen.h"

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

#endif
