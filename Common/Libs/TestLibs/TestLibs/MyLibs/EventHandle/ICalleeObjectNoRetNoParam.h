#import <Foundation/Foundation.h>

/**
 * @brief 可被调用的函数对象,，没有返回没有参数
 */
@protocol ICalleeObjectNoRetNoParam <NSObject>

@required
- (void) call;

@end