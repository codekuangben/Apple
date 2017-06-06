#import "EventDispatchFunctionObject.h"
#import "IDelayHandleItem.h"

import SDK.Lib.DelayHandle.IDelayHandleItem;
import SDK.Lib.Tools.UtilApi;

@implementation EventDispatchFunctionObject
{
    public boolean mIsClientDispose;       // 是否释放了资源
    public ICalleeObject mThis;
    public IDispatchObject mHandle;

    public EventDispatchFunctionObject()
    {
        self.mIsClientDispose = false;
    }

    public void setFuncObject(ICalleeObject pThis, IDispatchObject func)
    {
        self.mThis = pThis;
        self.mHandle = func;
    }

    public boolean isValid()
    {
        return self.mThis != null || self.mHandle != null;
    }

    public boolean isEqual(ICalleeObject pThis, IDispatchObject handle)
    {
        boolean ret = false;
        if(pThis != null)
        {
            ret = UtilApi.isAddressEqual(self.mThis, pThis);
            if (!ret)
            {
                return ret;
            }
        }
        if (handle != null)
        {
            //ret = UtilApi.isAddressEqual(self.mHandle, handle);
            ret = UtilApi.isDelegateEqual(self.mHandle, handle);
            if (!ret)
            {
                return ret;
            }
        }

        return ret;
    }

    public void call(IDispatchObject dispObj)
    {
        if(mThis != null)
        {
            mThis.call(dispObj);
        }

//        if(null != self.mHandle)
//        {
//            self.mHandle(dispObj);
//        }
    }

    public void setClientDispose(boolean isDispose)
    {
        self.mIsClientDispose = isDispose;
    }

    public boolean isClientDispose()
    {
        return self.mIsClientDispose;
    }
}

@end