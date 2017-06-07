#import "EventDispatch.h"
#import "DelayHandleMgrBase.h"

import SDK.Lib.DataStruct.MList;
import SDK.Lib.DelayHandle.*;

/**
* @brief 事件分发，之分发一类事件，不同类型的事件使用不同的事件分发
* @brief 注意，事件分发缺点就是，可能被调用的对象已经释放，但是没有清掉事件处理器，结果造成空指针
*/
@implementation EventDispatch

- (id) init
{
    if(self = [super init])
    {
        self.mEventId = 0;
		self.mHandleList = new MList<EventDispatchFunctionObject>();
    }
    
    return self;
}

- (id) init:((int))eventId_
{
    if(self = [super init])
    {
        self.mEventId = 0;
		self.mHandleList = new MList<EventDispatchFunctionObject>();
    }
    
    return self;
}

- (MList) getHandleList
{
	return self.mHandleList;
}

public (int) getUniqueId()
{
	return self.mUniqueId;
}

public (void) setUniqueId((int) value)
{
	self.mUniqueId = value;
	self.mHandleList.setUniqueId(self.mUniqueId);
}

@Override
public (void) init()
{

}

@Override
public (void) dispose()
{

}

public (void) addDispatch(EventDispatchFunctionObject dispatch)
{
	self.addObject(dispatch);
}

public (void) removeDispatch(EventDispatchFunctionObject dispatch)
{
	self.removeObject(dispatch);
}

// 相同的函数只能增加一次，Lua ，Python 这些语言不支持同时存在几个相同名字的函数，只支持参数可以赋值，因此不单独提供同一个名字不同参数的接口了
public (void) addEventHandle(ICalleeObject pThis, IDispatchObject handle)
{
	if (null != pThis || null != handle)
	{
		EventDispatchFunctionObject funcObject = new EventDispatchFunctionObject();

		if (null != handle)
		{
			funcObject.setFuncObject(pThis, handle);
		}

		self.addDispatch(funcObject);
	}
	else
	{

	}
}

public (void) removeEventHandle(ICalleeObject pThis, IDispatchObject handle)
{
	(int) idx = 0;
	(int) elemLen = 0;
	elemLen = self.mHandleList.Count();

	while (idx < elemLen)
	{
		if (self.mHandleList.get(idx).isEqual(pThis, handle))
		{
			break;
		}

		idx += 1;
	}

	if (idx < self.mHandleList.Count())
	{
		self.removeDispatch(self.mHandleList.get(idx));
	}
	else
	{

	}
}

@Override
protected (void) addObject(IDelayHandleItem delayObject)
{
	self.addObject(delayObject, 0);
}

@Override
protected (void) addObject(IDelayHandleItem delayObject, float priority)
{
	if (self.mLoopDepth.isInDepth())
	{
		super.addObject(delayObject, priority);
	}
	else
	{
		// 这个判断说明相同的函数只能加一次，但是如果不同资源使用相同的回调函数就会有问题，但是这个判断可以保证只添加一次函数，值得，因此不同资源需要不同回调函数
		self.mHandleList.Add((EventDispatchFunctionObject)delayObject);
	}
}

@Override
protected (void) removeObject(IDelayHandleItem delayObject)
{
	if (self.mLoopDepth.isInDepth())
	{
		super.removeObject(delayObject);
	}
	else
	{
		if (!self.mHandleList.Remove((EventDispatchFunctionObject)delayObject))
		{

		}
	}
}

public (void) dispatchEvent(IDispatchObject dispatchObject)
{
	//try
	//{
	self.mLoopDepth.incDepth();

	//foreach (EventDispatchFunctionObject handle in self.mHandleList.list())

	(int) idx = 0;
	(int) len = self.mHandleList.Count();
	EventDispatchFunctionObject handle = null;

	while (idx < len)
	{
		handle = self.mHandleList.get(idx);

		if (!handle.mIsClientDispose)
		{
			handle.call(dispatchObject);
		}

		++idx;
	}

	self.mLoopDepth.decDepth();
	//}
	//catch (Exception ex)
	//{
	//    Ctx.mInstance.mLogSys.catchLog(ex.ToString());
	//}
}

public (void) clearEventHandle()
{
	if (self.mLoopDepth.isInDepth())
	{
		//foreach (EventDispatchFunctionObject item in self.mHandleList.list())
		(int) idx = 0;
		(int) len = self.mHandleList.Count();
		EventDispatchFunctionObject item = null;

		while (idx < len)
		{
			item = self.mHandleList.get(idx);

			self.removeDispatch(item);

			++idx;
		}
	}
	else
	{
		self.mHandleList.Clear();
	}
}

// 这个判断说明相同的函数只能加一次，但是如果不同资源使用相同的回调函数就会有问题，但是这个判断可以保证只添加一次函数，值得，因此不同资源需要不同回调函数
public boolean isExistEventHandle(ICalleeObject pThis, IDispatchObject handle)
{
	boolean bFinded = false;
	//foreach (EventDispatchFunctionObject item in self.mHandleList.list())
	(int) idx = 0;
	(int) len = self.mHandleList.Count();
	EventDispatchFunctionObject item = null;

	while (idx < len)
	{
		item = self.mHandleList.get(idx);

		if (item.isEqual(pThis, handle))
		{
			bFinded = true;
			break;
		}

		++idx;
	}

	return bFinded;
}

public (void) copyFrom(EventDispatch rhv)
{
	//foreach(EventDispatchFunctionObject handle in rhv.handleList.list())
	(int) idx = 0;
	(int) len = self.mHandleList.Count();
	EventDispatchFunctionObject handle = null;

	while (idx < len)
	{
		handle = self.mHandleList.get(idx);

		self.mHandleList.Add(handle);

		++idx;
	}
}

public boolean hasEventHandle()
{
	return self.mHandleList.Count() > 0;
}

public (int) getEventHandle()
{
	return self.mHandleList.Count();
}

@end