#ifndef __EventDispatchGroup_h
#define __EventDispatchGroup_h

#import "EventDispatch.h"

/**
 * @brief 一次事件分发，分发一次就清理
 */
@interface CallOnceEventDispatch : EventDispatch
{
    
}

- (void) init;
- (void) dispatchEvent: (IDispatchObject) dispatchObject;

@end

#endif