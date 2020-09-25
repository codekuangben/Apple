package SDK.Lib.FrameHandle;

import SDK.Lib.EventHandle.ICalleeObject;
import SDK.Lib.Tools.UtilApi;

@interface TimerFunctionObject
{
    public ICalleeObjectTimer mHandle;

    public TimerFunctionObject()
    {
        self.mHandle = null;
    }

    public (void) setFuncObject(ICalleeObjectTimer handle)
    {
        self.mHandle = handle;
    }

    public boolean isValid()
    {
        return self.mHandle != null;
    }

    public boolean isEqual(ICalleeObject handle)
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

    public (void) call(TimerItemBase dispObj)
    {
        if (null != self.mHandle)
        {
            self.mHandle.call(dispObj);
        }
    }
}