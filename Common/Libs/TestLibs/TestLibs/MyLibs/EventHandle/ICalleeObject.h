#import <Foundation/Foundation.h>

/**
 * @brief 可被调用的函数对象
 */
@protocol ICalleeObject <NSObject>

@required
- (void) call: (IDispatchObject*) dispObj;

@end