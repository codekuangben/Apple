﻿/**
 * @brief 延迟添加的对象
 */
@protocol IDelayHandleItem <NSObject>

@optional


@required
- (void) setClientDispose: (bool) isDispose;
- (bool) isClientDispose;

@end