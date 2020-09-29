#import <Foundation/Foundation.h>

/**
 * @brief 延迟添加的对象
 */
@protocol IDelayHandleItem <NSObject>

@optional


@required
- (void) setClientDispose: (BOOL) isDispose;
- (BOOL) isClientDispose;

@end