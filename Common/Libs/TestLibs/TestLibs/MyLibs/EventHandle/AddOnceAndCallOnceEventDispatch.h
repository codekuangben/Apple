#import "MyLibs/EventHandle/EventDispatch.h"

@interface AddOnceAndCallOnceEventDispatch : EventDispatch
{
    
}

- (void) addEventHandle:(ICalleeObject*) pThis handle:(IDispatchObject*) handle;
- (void) dispatchEvent:(IDispatchObject*) dispatchObject;

@end