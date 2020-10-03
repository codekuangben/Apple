#import "MyLibs/EventHandle/AddOnceEventDispatch.h"

@implementation GlobalDelegate

- (id) init
{
    self->mMainChildMassChangedDispatch = [[AddOnceEventDispatch alloc] init];
}

- (void) addMainChildChangedHandle:(GObject<ICalleeObject>*) pThis handle:(IDispatchObject) handle
{
    [self->mMainChildMassChangedDispatch addEventHandle:pThis handle:handle];
}

- (void) init
{

}

- (void) dispose
{

}

@end