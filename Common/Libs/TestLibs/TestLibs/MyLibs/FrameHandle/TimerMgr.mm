#import "MyLibs/FrameHandle/TimerMgr.h"

@implementation TimerMgr

-(void) init()
{
	if(self = [super init])
	{
		self->mTimerList = [[MList alloc] init];
	}
	
	return self;
}

- (void) dispose
{

}

- (void) addObject:(IDelayHandleItem*) delayObject
{
	[self addObject:delayObject priority:0];
}

- (void) addObject:(IDelayHandleItem*) delayObject priority:(float) priority
{
	// 检查当前是否已经在队列中
	if (![self->mTimerList Contains:(TimerItemBase*)delayObject])
	{
		if ([self->mLoopDepth isInDepth])
		{
			[super addObject:delayObject priority:priority];
		}
		else
		{
			[self->mTimerList Add:(TimerItemBase*)delayObject];
		}
	}
}

- (void) removeObject:(IDelayHandleItem*) delayObject
{
	// 检查当前是否在队列中
	if ([self->mTimerList Contains:(TimerItemBase*)delayObject])
	{
		((TimerItemBase*)delayObject)->mDisposed = true;

		if ([self->mLoopDepth isInDepth])
		{
			[super removeObject:delayObject];
		}
		else
		{
			for(TimerItemBase* item in [self->mTimerList list])
			{
				if ([UtilSysLibsWrap isAddressEqual:item b:delayObject])
				{
					[self->mTimerList Remove:item];
					break;
				}
			}
		}
	}
}

- (void) addTimer:(TimerItemBase*) delayObject
{
	[self addTimer:delayObject priority:0];
}

// 从 Lua 中添加定时器，这种定时器尽量整个定时器周期只与 Lua 通信一次
- (void) addTimer:(TimerItemBase*) delayObject, priority:(float) priority
{
	[self addObject:delayObject priority:priority];
}

- (void) removeTimer:(TimerItemBase*) timer
{
	[self removeObject:timer];
}

- (void) Advance:(float) delta
{
	[self->mLoopDepth incDepth];

	for(TimerItemBase* timerItem in [self->mTimerList list])
	{
		if (![timerItem isClientDispose])
		{
			[timerItem OnTimer:delta];
		}

		if (timerItem.mDisposed)        // 如果已经结束
		{
			[self removeObject:timerItem];
		}
	}

	[self->mLoopDepth decDepth];
}

@end