#import "MyLibs/FrameHandle/TimerFunctionObject.h"
#import "MyLibs/EventHandle/IListenerObject.h"
#import "MyLibs/Tools/UtilSysLibsWrap.h"

@implementation TimerFunctionObject

- (id) init
{
    self->mEventHandle = nil;
    return self;
}

- (void) setFuncObject:(GObject<ICalleeObjectTimer>*) eventHandle
{
    self->mEventHandle = eventHandle;
}

- (BOOL) isValid
{
    return self->mEventHandle != nil;
}

- (BOOL) isEqual:(GObject<IListenerObject>*) eventHandle
{
    BOOL ret = false;

    if(eventHandle != nil)
    {
        ret = [UtilSysLibsWrap isAddressEqual:self->mEventHandle b:eventHandle];
        if(!ret)
        {
            return ret;
        }
    }

    return ret;
}

- (void) call:(TimerItemBase*) dispatchObject
{
    if (nil != self->mEventHandle)
    {
        [self->mEventHandle call:dispatchObject];
    }
}

@end
