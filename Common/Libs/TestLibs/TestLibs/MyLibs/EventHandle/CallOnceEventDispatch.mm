#import "MyLibs/EventHandle/CallOnceEventDispatch.h"
#import "MyLibs/EventHandle/EventDispatch.h"

@implementation CallOnceEventDispatch 

- (void) init
{

}

- (void) dispatchEvent: (IDispatchObject*) dispatchObject
{
    [super dispatchEvent:dispatchObject];

    [self clearEventHandle];
}

@end