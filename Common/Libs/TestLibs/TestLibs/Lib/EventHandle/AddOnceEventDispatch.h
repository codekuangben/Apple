#ifndef __AddOnceEventDispatch_h
#define __AddOnceEventDispatch_h

#import "EventDispatch.h"

/**
 * @brief 事件回调函数只能添加一次
 */
@interface AddOnceEventDispatch : EventDispatch
{
    
}

- (id) init;
- (id) init(int eventId_);
- (void) addEventHandle: (ICalleeObject) pThis and: (IDispatchObject) handle;

@end

#endif