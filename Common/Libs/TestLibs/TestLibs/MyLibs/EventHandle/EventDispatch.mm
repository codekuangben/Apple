#import "MyLibs/EventHandle/EventDispatch.h"
#import "MyLibs/DelayHandle/DelayHandleMgrBase.h"
#import "MyLibs/DataStruct/MList.h"

@implementation EventDispatch

- (id) init
{
    if(self = [super init])
    {
        self->mEventId = 0;
		self->mHandleList = [[MList alloc] init];
    }
    
    return self;
}

- (id) init:(int)eventId
{
    if(self = [super init])
    {
        self->mEventId = 0;
		self->mHandleList = [[MList alloc] init];
    }
    
    return self;
}

- (void) dispose
{

}

- (MList*) getHandleList
{
	return self->mHandleList;
}

- (int) getUniqueId
{
	return self->mUniqueId;
}

- (void) setUniqueId:(int) value
{
	self->mUniqueId = value;
	[self->mHandleList setUniqueId:self->mUniqueId];
}

- (void) addDispatch:(EventDispatchFunctionObject*) dispatch
{
	[self addObject:dispatch];
}

- (void) removeDispatch:(EventDispatchFunctionObject*) dispatch
{
	[self removeObject:dispatch];
}

// 相同的函数只能增加一次，Lua ，Python 这些语言不支持同时存在几个相同名字的函数，只支持参数可以赋值，因此不单独提供同一个名字不同参数的接口了
- (void) addEventHandle:(GObject<IListenerObject>*) eventListener eventHandle:/*(GObject<IDispatchObject>*)*/(SEL) eventHandle
{
	if (nil != eventListener || nil != eventHandle)
	{
		EventDispatchFunctionObject* funcObject = [[EventDispatchFunctionObject alloc] init];

		if (nil != eventHandle)
		{
			//[funcObject setFuncObject:eventListener eventHandle:(SEL)eventHandle];
            [funcObject setFuncObject:eventListener eventHandle:eventHandle];
        }

		[self addDispatch:funcObject];
	}
	else
	{

	}
}

- (void) removeEventHandle:(GObject<IListenerObject>*) eventListener eventHandle:/*(GObject<IDispatchObject>*)*/(SEL) eventHandle
{
	int idx = 0;
	int elemLen = 0;
	elemLen = [self->mHandleList Count];

	while (idx < elemLen)
	{
		if ([[self->mHandleList get:idx] isEqual:eventListener eventHandle:eventHandle])
		{
			break;
		}

		idx += 1;
	}

	if (idx < [self->mHandleList Count])
	{
		[self removeDispatch:[self->mHandleList get:idx]];
	}
	else
	{

	}
}

- (void) addObject:(GObject<IDelayHandleItem>*) delayObject
{
	[self addObject:delayObject priority:0];
}

- (void) addObject:(GObject<IDelayHandleItem>*) delayObject priority:(float) priority
{
	if ([self->mLoopDepth isInDepth])
	{
		[super addObject:delayObject priority:priority];
	}
	else
	{
		// 这个判断说明相同的函数只能加一次，但是如果不同资源使用相同的回调函数就会有问题，但是这个判断可以保证只添加一次函数，值得，因此不同资源需要不同回调函数
		[self->mHandleList Add:(EventDispatchFunctionObject*)delayObject];
	}
}

- (void) removeObject:(GObject<IDelayHandleItem>*) delayObject
{
	if ([self->mLoopDepth isInDepth])
	{
		[super removeObject:delayObject];
	}
	else
	{
		if (![self->mHandleList Remove:(EventDispatchFunctionObject*)delayObject])
		{

		}
	}
}

- (void) dispatchEvent:(GObject<IDispatchObject>*) dispatchObject
{
	//try
	//{
	[self->mLoopDepth incDepth];

	//foreach (EventDispatchFunctionObject eventHandle in self->mHandleList.list())

	int idx = 0;
	int len = [self->mHandleList Count];
	EventDispatchFunctionObject* eventHandle = nil;

	while (idx < len)
	{
		eventHandle = [self->mHandleList get:idx];

		if (!eventHandle->mIsClientDispose)
		{
			[eventHandle call:dispatchObject];
		}

		++idx;
	}

	[self->mLoopDepth decDepth];
	//}
	//catch (Exception ex)
	//{
	//    [Ctx ins]->mLogSys.catchLog(ex.ToString());
	//}
}

- (void) clearEventHandle
{
	if ([self->mLoopDepth isInDepth])
	{
		//foreach (EventDispatchFunctionObject item in self->mHandleList.list())
		int idx = 0;
		int len = [self->mHandleList Count];
		EventDispatchFunctionObject* item = nil;

		while (idx < len)
		{
			item = [self->mHandleList get:idx];

			[self removeDispatch:item];

			++idx;
		}
	}
	else
	{
		[self->mHandleList Clear];
	}
}

// 这个判断说明相同的函数只能加一次，但是如果不同资源使用相同的回调函数就会有问题，但是这个判断可以保证只添加一次函数，值得，因此不同资源需要不同回调函数
- (BOOL) isExistEventHandle:(GObject<IListenerObject>*) eventListener eventHandle:(GObject<IDispatchObject>*) eventHandle
{
	BOOL bFinded = false;
	//foreach (EventDispatchFunctionObject item in self->mHandleList.list())
	int idx = 0;
	int len = [self->mHandleList Count];
	EventDispatchFunctionObject* item = nil;

	while (idx < len)
	{
		item = [self->mHandleList get:idx];

		if ([item isEqual:eventListener eventHandle:(SEL)eventHandle])
		{
			bFinded = true;
			break;
		}

		++idx;
	}

	return bFinded;
}

- (void) copyFrom:(EventDispatch*) rhv
{
	//foreach(EventDispatchFunctionObject eventHandle in rhv.handleList.list())
	int idx = 0;
	int len = [self->mHandleList Count];
	EventDispatchFunctionObject* eventHandle = nil;

	while (idx < len)
	{
        eventHandle = [self->mHandleList get:idx];

		[self->mHandleList Add:eventHandle];

		++idx;
	}
}

- (BOOL) hasEventHandle
{
	return [self->mHandleList Count] > 0;
}

- (int) getEventHandle
{
	return [self->mHandleList Count];
}

@end
