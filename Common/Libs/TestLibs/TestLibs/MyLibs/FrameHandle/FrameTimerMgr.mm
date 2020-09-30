#import "MyLibs/DataStruct/MList.h"
#import "MyLibs/DelayHandle/DelayHandleMgrBase.h"
#import "MyLibs/DelayHandle/IDelayHandleItem.h"
#import "MyLibs/Tools/UtilSysLibsWrap.h"

@implementation FrameTimerMgr

- (id) init
{
    self->mTimerList = [[MList alloc] init];
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
    if (![self->mTimerList.Contains((FrameTimerItem)delayObject))
    {
        if ([self->mLoopDepth isInDepth]
        {
            [super addObject:delayObject priority:priority];
        }
        else
        {
            [self->mTimerList Add:(FrameTimerItem*)delayObject];
        }
    }
}

- (void) removeObject:(IDelayHandleItem*) delayObject
{
    // 检查当前是否在队列中
    if ([self->mTimerList Contains:(FrameTimerItem*)delayObject])
    {
        ((FrameTimerItem*)delayObject)->mDisposed = true;

        if ([self->mLoopDepth isInDepth])
        {
            [super addObject:delayObject];
        }
        else
        {
            for(FrameTimerItem* item in self->mTimerList.list())
            {
                if ([UtilSysLibsWrap isAddressEqual:item, b:delayObject])
                {
                    [self->mTimerList Remove:item];
                    break;
                }
            }
        }
    }
}

- (void) addFrameTimer:(FrameTimerItem) timer
{
    [self addFrameTimer:timer priority:0];
}

- (void) addFrameTimer:(FrameTimerItem*) timer  priority:(float) priority
{
    [self addObject:timer priority:priority];
}

- (void) removeFrameTimer:(FrameTimerItem*) timer
{
    [self removeObject:timer];
}

- (void) Advance:(float) delta
{
    [self->mLoopDepth incDepth];

    for(FrameTimerItem* timerItem in [self->mTimerList list]
    {
        if (![timerItem isClientDispose]
        {
            [timerItem OnFrameTimer];
        }
        if (timerItem.mDisposed)
        {
            [self removeObject:timerItem];
        }
    }

    [self->mLoopDepth decDepth];
}

@end
