#import "MyLibs/EventHandle/EventDispatchFunctionObject.h"
#import "MyLibs/Delayhandle/IDelayHandleItem.h"
#import "MyLibs/Tools/UtilSysLibsWrap.h"


@implementation EventDispatchFunctionObject

- (id) init: (int) baseUniqueId
{
    if(self = [super init])
    {
        self->mIsClientDispose = false;
    }
    
    return self;
}

- (void) setFuncObject:(GObject<ICalleeObject>*) pThis func:(SEL) func
{
	self->mThis = pThis;
	self->mHandle = func;
	self->mHandleImp = [self->mThis methodForSelector:self->mHandle];  
}

- (BOOL) isValid
{
	return self->mThis != nil && self->mHandle != nil;
}

- (BOOL) isEqual:(GObject<ICalleeObject>*) pThis handle:(SEL) handle
{
	BOOL ret = false;
	if(pThis != nil)
	{
		ret = [UtilSysLibsWrap isAddressEqual:self->mThis b:pThis];
		if (!ret)
		{
			return ret;
		}
	}
	if (handle != nil)
	{
		//ret = [UtilSysLibsWrap isDelegateEqual:self->mHandle b:handle];
        ret = (self->mHandle == handle);
        if (!ret)
		{
			return ret;
		}
	}

	return ret;
}

- (void) call:(GObject<IDispatchObject>*) dispObj
{
	if(nil != self->mThis && nil != self->mHandle)
	{
		//[self->mThis performSelector:self->mHandle withObject:self->mEventId withObject:dispObj];
		//self->mHandleImp(self->mThis, self->mEventId, dispObj);
        //self->mHandleImp();
        [self->mThis performSelector:self->mHandle withObject:dispObj withObject:(id)self->mEventId];
    }
	else if(nil == self->mThis && nil != self->mHandle)
	{
		//self->mHandle(dispObj, self->mEventId);
        [self->mThis performSelector:self->mHandle withObject:dispObj withObject:(id)self->mEventId];
    }
}

- (void) setClientDispose:(BOOL) isDispose
{
	self->mIsClientDispose = isDispose;
}

- (BOOL) isClientDispose
{
	return self->mIsClientDispose;
}

@end
