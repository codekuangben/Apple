#import "MyLibs/FrameWork/GlobalDelegate.h"
#import "MyLibs/EventHandle/AddOnceEventDispatch.h"

@implementation GlobalDelegate

- (id) init
{
    //self->mMainChildMassChangedDispatch = [[AddOnceEventDispatch alloc] init];
    return self;
}

- (void) dispose
{

}

- (void) addMainChildChangedHandle:(GObject<IListenerObject>*) eventListener eventHandle:(GObject<IDispatchObject>*) eventHandle
{
    //[self->mMainChildMassChangedDispatch addEventHandle:eventListener eventHandle:eventHandle];
}

@end
