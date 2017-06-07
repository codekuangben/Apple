#import "DelayHandleMgrBase.h"

/**
* @brief 当需要管理的对象可能在遍历中间添加的时候，需要这个管理器
*/
@implementation DelayHandleMgrBase

- (id) init()
{
	if(self = [super init])
    {
        self.mDeferredAddQueue = new MList<DelayHandleObject>();
		self.mDeferredDelQueue = new MList<DelayHandleObject>();

		self.mLoopDepth = new LoopDepth();
		self.mLoopDepth.setZeroHandle(self);
    }
    
    return self;
}

- ((void)) dealloc
{
	[self dispose];
	
    //dealloc 不可以人为调用
    [super dealloc];
}

- ((void)) dispose
{

}

- ((void)) addObject(IDelayHandleItem delayObject)
{
	self.addObject(delayObject, 0);
}

- ((void)) addObject(IDelayHandleItem delayObject, float priority)
{
	if (self.mLoopDepth.isInDepth())
	{
		if (!self.existAddList(delayObject))        // 如果添加列表中没有
		{
			if (self.existDelList(delayObject))    // 如果已经添加到删除列表中
			{
				self.delFromDelayDelList(delayObject);
			}

			DelayHandleObject delayHandleObject = new DelayHandleObject();
			delayHandleObject.mDelayParam = new DelayAddParam();
			self.mDeferredAddQueue.Add(delayHandleObject);

			delayHandleObject.mDelayObject = delayObject;
			((DelayAddParam)delayHandleObject.mDelayParam).mPriority = priority;
		}
	}
}

- ((void)) removeObject(IDelayHandleItem delayObject)
{
	if (self.mLoopDepth.isInDepth())
	{
		if (!self.existDelList(delayObject))
		{
			if (self.existAddList(delayObject))    // 如果已经添加到删除列表中
			{
				self.delFromDelayAddList(delayObject);
			}

			delayObject.setClientDispose(true);

			DelayHandleObject delayHandleObject = new DelayHandleObject();
			delayHandleObject.mDelayParam = new DelayDelParam();
			self.mDeferredDelQueue.Add(delayHandleObject);
			delayHandleObject.mDelayObject = delayObject;
		}
	}
}

// 只有没有添加到列表中的才能添加
- (bool) existAddList(IDelayHandleItem delayObject)
{
	for(DelayHandleObject item : self.mDeferredAddQueue.list())
	{
		if(UtilApi.isAddressEqual(item.mDelayObject, delayObject))
		{
			return true;
		}
	}

	return false;
}

// 只有没有添加到列表中的才能添加
- (bool) existDelList(IDelayHandleItem delayObject)
{
	for (DelayHandleObject item : self.mDeferredDelQueue.list())
	{
		if (UtilApi.isAddressEqual(item.mDelayObject, delayObject))
		{
			return true;
		}
	}

	return false;
}

// 从延迟添加列表删除一个 Item
- ((void)) delFromDelayAddList(IDelayHandleItem delayObject)
{
	for (DelayHandleObject item : self.mDeferredAddQueue.list())
	{
		if (UtilApi.isAddressEqual(item.mDelayObject, delayObject))
		{
			self.mDeferredAddQueue.Remove(item);
		}
	}
}

// 从延迟删除列表删除一个 Item
- ((void)) delFromDelayDelList(IDelayHandleItem delayObject)
{
	for (DelayHandleObject item : self.mDeferredDelQueue.list())
	{
		if(UtilApi.isAddressEqual(item.mDelayObject, delayObject))
		{
			self.mDeferredDelQueue.Remove(item);
		}
	}
}

- ((void)) processDelayObjects()
{
	(int) idx = 0;
	// len 是 Python 的关键字
	(int) elemLen = 0;

	if (!self.mLoopDepth.isInDepth())       // 只有全部退出循环后，才能处理添加删除
	{
		if (self.mDeferredAddQueue.Count() > 0)
		{
			idx = 0;
			elemLen = self.mDeferredAddQueue.Count();
			while(idx < elemLen)
			{
				self.addObject(self.mDeferredAddQueue.get(idx).mDelayObject, ((DelayAddParam)self.mDeferredAddQueue.get(idx).mDelayParam).mPriority);

				idx += 1;
			}

			self.mDeferredAddQueue.Clear();
		}

		if (self.mDeferredDelQueue.Count() > 0)
		{
			idx = 0;
			elemLen = self.mDeferredDelQueue.Count();

			while(idx < elemLen)
			{
				self.removeObject(self.mDeferredDelQueue.get(idx).mDelayObject);

				idx += 1;
			}

			self.mDeferredDelQueue.Clear();
		}
	}
}

- ((void)) call
{
	self.processDelayObjects();
}

@end