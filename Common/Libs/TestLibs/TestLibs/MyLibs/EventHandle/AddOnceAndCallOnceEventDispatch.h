#import "MyLibs/EventHandle/EventDispatch.h"

@interface AddOnceAndCallOnceEventDispatch : EventDispatch
{
    
}

- (void) addEventHandle:(GObject<ICalleeObject>*) pThis handle:(GObject<IDispatchObject>*) handle;
- (void) dispatchEvent:(GObject<IDispatchObject>*) dispatchObject;

@end