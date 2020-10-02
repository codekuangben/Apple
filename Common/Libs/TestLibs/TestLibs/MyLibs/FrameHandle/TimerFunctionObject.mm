#import "MyLibs/FrameHandle/TimerFunctionObject.h"
#import "MyLibs/EventHandle/ICalleeObject.h"
#import "MyLibs/Tools/UtilSysLibsWrap.h"

@implementation TimerFunctionObject

- (id) init
{
    self->mHandle = nil;
    return self;
}

- (void) setFuncObject:(GObject<ICalleeObjectTimer>*) handle
{
    self->mHandle = handle;
}

- (BOOL) isValid
{
    return self->mHandle != nil;
}

- (BOOL) isEqual:(GObject<ICalleeObject>*) handle
{
    BOOL ret = false;

    if(handle != nil)
    {
        ret = [UtilSysLibsWrap isAddressEqual:self->mHandle b:handle];
        if(!ret)
        {
            return ret;
        }
    }

    return ret;
}

- (void) call:(TimerItemBase*) dispObj
{
    if (nil != self->mHandle)
    {
        [self->mHandle call:dispObj];
    }
}

@end
