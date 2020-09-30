﻿#import "MyLibs/EventHandle/EventDispatchFunctionObject.h"
#import "MyLibs/Delayhandle/IDelayHandleItem.h"

@implementation EventDispatchFunctionObject

- (id) init: (int) baseUniqueId
{
    if(self = [super init])
    {
        self->mIsClientDispose = false;
    }
    
    return self;
}

- (void) setFuncObject:(ICalleeObject*) pThis, func:(SEL) func
{
	self->mThis = pThis;
	self->mHandle = func;
	self->mHandleImp = [self->mThis methodForSelector:self->mHandle];  
}

- (BOOL) isValid
{
	return self->mThis != nil && self->mHandle != nil;
}

- (BOOL) isEqual:(ICalleeObject*) pThis, handle:(SEL*) handle
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
		ret = [UtilSysLibsWrap isDelegateEqual:self->mHandle b:handle];
		if (!ret)
		{
			return ret;
		}
	}

	return ret;
}

- (void) call:(IDispatchObject*) dispObj
{
	if(nil != self->mThis && nil != self->mHandle)
	{
		//[self->mThis performSelector:self->mHandle withObject:self->mEventId withObject:dispObj];
		self->mHandleImp(self->mThis, self->mEventId, dispObj);
	}
	else if(nil == self->mThis && nil != self->mHandle)
	{
		self->mHandle(dispObj, self->mEventId); 
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