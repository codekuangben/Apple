#ifndef __IDelayHandleItem_h
#define __IDelayHandleItem_h

/**
 * @brief 延迟添加的对象
 */
@protocol IDelayHandleItem <NSObject>
    - (void) setClientDispose: (bool) isDispose;
    - (bool) isClientDispose;
@end

#endif