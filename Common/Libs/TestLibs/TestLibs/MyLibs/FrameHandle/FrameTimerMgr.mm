#import "MList.h"
#import "DelayHandleMgrBase.h"
#import "IDelayHandleItem.h"
#import "UtilApi.h"

@implementation FrameTimerMgr

- (id) init
{
    self.mTimerList = new MList<FrameTimerItem>();
}

- (void) dispose
{

}

- (void) addObject:(IDelayHandleItem*) delayObject
{
    self.addObject(delayObject, 0);
}

- (void) addObject:(IDelayHandleItem*) delayObject priority:(float) priority
{
    // 检查当前是否已经在队列中
    if (!self.mTimerList.Contains((FrameTimerItem)delayObject))
    {
        if (self.mLoopDepth.isInDepth())
        {
            super.addObject(delayObject, priority);
        }
        else
        {
            self.mTimerList.Add((FrameTimerItem)delayObject);
        }
    }
}

- (void) removeObject:(IDelayHandleItem*) delayObject
{
    // 检查当前是否在队列中
    if (self.mTimerList.Contains((FrameTimerItem)delayObject))
    {
        ((FrameTimerItem)delayObject).mDisposed = true;

        if (self.mLoopDepth.isInDepth())
        {
            super.addObject(delayObject);
        }
        else
        {
            for(FrameTimerItem item : self.mTimerList.list())
            {
                if (UtilApi.isAddressEqual(item, delayObject))
                {
                    self.mTimerList.Remove(item);
                    break;
                }
            }
        }
    }
}

- (void) addFrameTimer:(FrameTimerItem) timer
{
    self.addFrameTimer(timer, 0);
}

- (void) addFrameTimer:(FrameTimerItem*) timer  priority:(float) priority
{
    self.addObject(timer, priority);
}

- (void) removeFrameTimer:(FrameTimerItem*) timer
{
    self.removeObject(timer);
}

- (void) Advance:(float) delta
{
    self.mLoopDepth.incDepth();

    for(FrameTimerItem timerItem : self.mTimerList.list())
    {
        if (!timerItem.isClientDispose())
        {
            timerItem.OnFrameTimer();
        }
        if (timerItem.mDisposed)
        {
            removeObject(timerItem);
        }
    }

    self.mLoopDepth.decDepth();
}

@end
