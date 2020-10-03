#import "MyLibs/EventHandle/EventDispatch.h"

@interface AddOnceAndCallOnceEventDispatch : EventDispatch
{
    
}

- (void) addEventHandle:(GObject<IListenerObject>*) eventListener eventHandle:(GObject<IDispatchObject>*) eventHandle;
- (void) dispatchEvent:(GObject<IDispatchObject>*) dispatchObject;

@end