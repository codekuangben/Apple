#import "MyLibs/EventHandle/EventDispatch.h"

@interface ResEventDispatch : EventDispatch
{
    
}

- (id) init;
- (void) dispatchEvent: (GObject<IDispatchObject>*) dispatchObject;

@end