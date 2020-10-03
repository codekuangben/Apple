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

- (void) addMainChildChangedHandle:(GObject<ICalleeObject>*) pThis handle:(GObject<IDispatchObject>*) handle
{
    //[self->mMainChildMassChangedDispatch addEventHandle:pThis handle:handle];
}

@end
