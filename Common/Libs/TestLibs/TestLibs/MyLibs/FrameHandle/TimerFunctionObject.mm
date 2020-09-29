#import "MyLibs/FrameHandle/TimerFunctionObject.h"
#import "MyLibs/EventHandle/ICalleeObject.h"
#import "MyLibs/Tools/UtilApi.h"

@implementation TimerFunctionObject

- TimerFunctionObject
{
    self.mHandle = null;
}

- (void) setFuncObject:(ICalleeObjectTimer*) handle
{
    self.mHandle = handle;
}

- (boolean) isValid
{
    return self.mHandle != null;
}

- (boolean) isEqual:(ICalleeObject*) handle
{
    boolean ret = false;

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