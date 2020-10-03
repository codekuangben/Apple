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

- (void) setFuncObject:(GObject<IListenerObject>*) eventListener eventHandle:(SEL) eventHandle
{
	self->mEventListener = eventListener;
	self->mEventHandle = eventHandle;
	self->mHandleImp = [self->mEventListener methodForSelector:self->mEventHandle];  
}

- (BOOL) isValid
{
	return self->mEventListener != nil && self->mEventHandle != nil;
}

- (BOOL) isEqual:(GObject<IListenerObject>*) eventListener eventHandle:(SEL) eventHandle
{
	BOOL ret = false;
	if(eventListener != nil)
	{
		ret = [UtilSysLibsWrap isAddressEqual:self->mEventListener b:eventListener];
		if (!ret)
		{
			return ret;
		}
	}
	if (eventHandle != nil)
	{
		//ret = [UtilSysLibsWrap isDelegateEqual:self->mEventHandle b:eventHandle];
        ret = (self->mEventHandle == eventHandle);
        if (!ret)
		{
			return ret;
		}
	}

	return ret;
}

- (void) call:(GObject<IDispatchObject>*) dispatchObject
{
	if(nil != self->mEventListener && nil != self->mEventHandle)
	{
		//[self->mEventListener performSelector:self->mEventHandle withObject:self->mEventId withObject:dispatchObject];
		//self->mHandleImp(self->mEventListener, self->mEventId, dispatchObject);
        //self->mHandleImp();
        [self->mEventListener performSelector:self->mEventHandle withObject:dispatchObject withObject:(id)self->mEventId];
    }
	else if(nil == self->mEventListener && nil != self->mEventHandle)
	{
		//self->mEventHandle(dispatchObject, self->mEventId);
        [self->mEventListener performSelector:self->mEventHandle withObject:dispatchObject withObject:(id)self->mEventId];
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
