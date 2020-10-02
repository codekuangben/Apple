#import <Foundation/Foundation.h>
#import "MyLibs/EventHandle/IDispatchObject.h"
#import "MyLibs/Base/GObject.h"

/**
 * @brief 可被调用的函数对象
 */
@protocol ICalleeObject <NSObject>

@required
- (void) call: (GObject<IDispatchObject>*) dispObj;

@end
