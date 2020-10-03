#import "MyLibs/DelayHandle/DelayHandleMgrBase.h"
#import "MyLibs/DelayHandle/DelayHandleObject.h"
#import "MyLibs/DelayHandle/DelayAddParam.h"
#import "MyLibs/DelayHandle/DelayDelParam.h"

/**
* @brief 当需要管理的对象可能在遍历中间添加的时候，需要这个管理器
*/
@implementation DelayHandleMgrBase

- (id) init
{
	if(self = [super init])
    {
        self->mDeferredAddQueue = [[MList alloc] init];
		self->mDeferredDelQueue = [[MList alloc] init];

		self->mLoopDepth = [[LoopDepth alloc] init];
		[self->mLoopDepth setZeroHandle:self];
    }
    
    return self;
}

- (void) dealloc
{
	[self dispose];
	
    //dealloc 不可以人为调用
    [super dealloc];
}

- (void) dispose
{

}

- (void) addObject:(GObject<IDelayHandleItem>*) delayObject
{
	[self addObject:delayObject priority:0];
}

- (void) addObject:(GObject<IDelayHandleItem>*) delayObject priority:(float) priority
{
	if ([self->mLoopDepth isInDept])
	{
		if (![self existAddList:delayObject])        // 如果添加列表中没有
		{
			if ([self existDelList:delayObject])    // 如果已经添加到删除列表中
			{
				[self delFromDelayDelList:delayObject];
			}

            DelayHandleObject* delayHandleObject = [[DelayHandleObject alloc] init];
			delayHandleObject->mDelayParam = [[DelayAddParam alloc] init];
			[self->mDeferredAddQueue Add:delayHandleObject];

			delayHandleObject->mDelayObject = delayObject;
			((DelayAddParam*)delayHandleObject->mDelayParam)->mPriority = priority;
		}
	}
}

- (void) removeObject:(GObject<IDelayHandleItem>*) delayObject
{
	if ([self->mLoopDepth isInDepth])
	{
		if (![self existDelList:delayObject])
		{
			if ([self existAddList:delayObject])    // 如果已经添加到删除列表中
			{
				[self delFromDelayAddList:delayObject];
			}

			[delayObject setClientDispose:true];

			DelayHandleObject* delayHandleObject = [[DelayHandleObject alloc] init];
			delayHandleObject->mDelayParam = [[DelayDelParam alloc] init];
			[self->mDeferredDelQueue Add:delayHandleObject];
			delayHandleObject->mDelayObject = delayObject;
		}
	}
}

// 只有没有添加到列表中的才能添加
- (BOOL) existAddList:(GObject<IDelayHandleItem>*) delayObject
{
	for(DelayHandleObject* item in [self->mDeferredAddQueue list])
	{
		if([UtilSysLibsWrap isAddressEqual:item->mDelayObject b:delayObject])
		{
			return true;
		}
	}

	return false;
}

// 只有没有添加到列表中的才能添加
- (BOOL) existDelList:(GObject<IDelayHandleItem>*) delayObject
{
	for (DelayHandleObject* item in [self->mDeferredDelQueue list])
	{
		if ([UtilSysLibsWrap isAddressEqual:item->mDelayObject b:delayObject])
		{
			return true;
		}
	}

	return false;
}

// 从延迟添加列表删除一个 Item
- (void) delFromDelayAddList:(GObject<IDelayHandleItem>*) delayObject
{
	for (DelayHandleObject* item in [self->mDeferredAddQueue list])
	{
		if ([UtilSysLibsWrap isAddressEqual:item->mDelayObject b:delayObject])
		{
			[self->mDeferredAddQueue Remove:item];
		}
	}
}

// 从延迟删除列表删除一个 Item
- (void) delFromDelayDelList:(GObject<IDelayHandleItem>*) delayObject
{
	for (DelayHandleObject* item in [self->mDeferredDelQueue list])
	{
		if([UtilSysLibsWrap isAddressEqual:item->mDelayObject b:delayObject])
		{
			[self->mDeferredDelQueue Remove:item];
		}
	}
}

- (void) processDelayObjects
{
	int idx = 0;
	// len 是 Python 的关键字
	int elemLen = 0;

	if (![self->mLoopDepth isInDepth])       // 只有全部退出循环后，才能处理添加删除
	{
		if ([self->mDeferredAddQueue Count] > 0)
		{
			idx = 0;
			elemLen = [self->mDeferredAddQueue Count];
			while(idx < elemLen)
			{
				[self addObject:((DelayHandleObject*)[self->mDeferredAddQueue get:idx])->mDelayObject priority:((DelayAddParam*)((DelayHandleObject*)[self->mDeferredAddQueue get:idx])->mDelayParam)->mPriority];

				idx += 1;
			}

			[self->mDeferredAddQueue Clear];
		}

		if ([self->mDeferredDelQueue Count] > 0)
		{
			idx = 0;
			elemLen = [self->mDeferredDelQueue Count];

			while(idx < elemLen)
			{
				[self removeObject:((DelayHandleObject*)[self->mDeferredDelQueue get:idx])->mDelayObject];

				idx += 1;
			}

			[self->mDeferredDelQueue Clear];
		}
	}
}

- (void) call
{
	[self processDelayObjects];
}

@end
