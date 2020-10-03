#import "MyLibs/EventHandle/EventDispatch.h"

/**
 * @brief 一次事件分发，分发一次就清理
 */
@interface CallOnceEventDispatch : EventDispatch
{
    
}

- (void) init;
- (void) dispatchEvent: (GObject<IDispatchObject>*) dispatchObject;

@end