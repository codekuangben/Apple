#ifndef __AddOnceAndCallOnceEventDispatch_h
#define __AddOnceAndCallOnceEventDispatch_h

#import "EventDispatch.h"

@interface AddOnceAndCallOnceEventDispatch : EventDispatch
{
    
}

- (void) addEventHandle: (ICalleeObject) pThis and: (IDispatchObject) handle;
- (void) dispatchEvent: (IDispatchObject) dispatchObject;

@end

#endif