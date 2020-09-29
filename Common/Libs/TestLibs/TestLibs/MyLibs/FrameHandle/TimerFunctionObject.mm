#import "MyLibs/FrameHandle/TimerFunctionObject.h"
#import "MyLibs/EventHandle/ICalleeObject.h"
#import "MyLibs/Tools/UtilSysLibsWrap.h"

@implementation TimerFunctionObject

- TimerFunctionObject
{
    self.mHandle = null;
}

- (void) setFuncObject:(ICalleeObjectTimer*) handle
{
    self.mHandle = handle;
}

- (BOOL) isValid
{
    return self.mHandle != null;
}

- (BOOL) isEqual:(ICalleeObject*) handle
{
    BOOL ret = false;

    if(handle != null)
    {
        ret = UtilApi.isAddressEqual(self.mHandle, handle);
        if(!ret)
        {
            return ret;
        }
    }

    return ret;
}

- (void) call:(TimerItemBase*) dispObj
{
    if (null != self.mHandle)
    {
        self.mHandle.call(dispObj);
    }
}

@end