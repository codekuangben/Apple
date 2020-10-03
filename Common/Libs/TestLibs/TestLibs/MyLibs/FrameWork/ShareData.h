#import "MyLibs/Base/GObject.h"
#import <Foundation/Foundation.h>

//@class ByteBuffer;

/**
 * @brief 共享内容，主要是数据
 */
@interface ShareData : GObject
{
@public
    NSString* mTmpStr;
    //ByteBuffer* mTmpBA;
}

@end
