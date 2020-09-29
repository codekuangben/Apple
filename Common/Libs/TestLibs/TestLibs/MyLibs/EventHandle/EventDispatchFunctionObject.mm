#import "EventDispatchFunctionObject.h"
#import "IDelayHandleItem.h"

@implementation EventDispatchFunctionObject

- (id) init: ((int)) baseUniqueId
{
    if(self = [super init])
    {
        self.mIsClientDispose = false;
    }
    
    return self;
}

- ((void)) setFuncObject(ICalleeObject* pThis, SEL func)
{
	self.mThis = pThis;
	self.mHandle = func;
	self.mHandleImp = [self.mThis methodForSelector:self.mHandle];  
}

- (bool) isValid()
{
	return self.mThis != nil && self.mHandle != nil;
}

- (bool) isEqual(ICalleeObject* pThis, SEL handle)
{
	bool ret = false;
	if(pThis != nil)
	{
		ret = UtilApi.isAddressEqual(self.mThis, pThis);
		if (!ret)
		{
			return ret;
		}
	}
	if (handle != nil)
	{
		ret = UtilApi.isDelegateEqual(self.mHandle, handle);
		if (!ret)
		{
			return ret;
		}
	}

	return ret;
}

public (void) call(IDispatchObject* dispObj)
{
	if(nil != self.mThis && nil != self.mHandle)
	{
		//[self.mThis performSelector:self.mHandle withObject:self.mEventId withObject:dispObj];
		self.mHandleImp(self.mThis, self.mEventId, dispObj);
	}
	else if(nil == self.mThis && nil != self.mHandle)
	{
		self.mHandle(dispObj, self.mEventId); 
	}
}

public (void) setClientDispose(boolean isDispose)
{
	self.mIsClientDispose = isDispose;
}

public boolean isClientDispose()
{
	return self.mIsClientDispose;
}

@end