#import "MyLibs/EventHandle/EventDispatch.h"

/**
 * @brief 事件回调函数只能添加一次
 */
@interface AddOnceEventDispatch : EventDispatch
{
    
}

- (id) init;
- (id) init:(int) eventId_;
- (void) addEventHandle: (GObject<IListenerObject>*) eventListener eventHandle: (GObject<IDispatchObject>*) eventHandle;

@end
