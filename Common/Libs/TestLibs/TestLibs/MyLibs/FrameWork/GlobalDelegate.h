#import "MyLibs/EventHandle/AddOnceEventDispatch.h"
#import "MyLibs/EventHandle/ICalleeObject.h"
#import "MyLibs/EventHandle/IDispatchObject.h"
#import "MyLibs/Base/GObject.h"

/**
 * @brief 全局委托，只要初始化后，就可以注册和使用这些委托，不用等到哪一个资源创建完成
 */
@interface GlobalDelegate : GObject
{
    // PlayerMainChild 的质量发生改变
    @public
    AddOnceEventDispatch* mMainChildMassChangedDispatch;
}

- (id) init;
- (void) dispose;
- (void) addMainChildChangedHandle:(GObject<ICalleeObject>*) pThis handle:(GObject<IDispatchObject>*) handle;


@end
