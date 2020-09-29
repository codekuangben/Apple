#import <Foundation/Foundation.h>

/**
 * @brief 可被调用的函数对象,，没有返回没有参数
 */
@protocol ICalleeObjectTimer <NSObject>

@required
- (void) call:(TimerItemBase*) timer;

@end