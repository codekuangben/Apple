#import "MyLibs/FrameHandle/TimerFunctionObject.h"
#import "MyLibs/EventHandle/ICalleeObject.h"
#import "MyLibs/Tools/UtilSysLibsWrap.h"

@implementation TimerFunctionObject

- TimerFunctionObject
{
    self->mHandle = nil;
}

- (void) setFuncObject:(ICalleeObjectTimer*) handle
{
    self->mHandle = handle;
}

- (BOOL) isValid
{
    return self->mHandle != nil;
}

- (BOOL) isEqual:(ICalleeObject*) handle
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