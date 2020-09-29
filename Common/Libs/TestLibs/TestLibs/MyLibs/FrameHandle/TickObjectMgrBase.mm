#import "MyLibs/FrameHandle/TickObjectMgrBase.h"

// 每一帧执行的对象管理器
@implementation TickObjectMgrBase

- (id) init
{

}

- (void) dispose
{

}

- (void) setClientDispose:(BOOL) isDispose
{

}

- (BOOL) isClientDispose
{
    return false;
}

- (void) onTick:(float) delta
{
    self.mLoopDepth.incDepth();

    self.onExecTick(delta);

    self.mLoopDepth.decDepth();
}

- (void) onExecTick:(float) delta
{
    (int) idx = 0;
    (int) count = self.mTickObjectList.Count();
    ITickedObject tickObject = null;

    while (idx < count)
    {
        tickObject = self.mTickObjectList.get(idx);

        if (!((IDelayHandleItem)tickObject).isClientDispose())
        {
            tickObject.onTick(delta);
        }

        ++idx;
    }
}

- (void) addObject:(IDelayHandleItem*) tickObject
{
    self.addObject(tickObject, 0);
}

- (void) addObject:(IDelayHandleItem*) tickObject priority:(float) priority
{
    if (self.mLoopDepth.isInDepth())
    {
        super.addObject(tickObject);
    }
    else
    {
        if (self.mTickObjectList.IndexOf((ITickedObject)tickObject) == -1)
        {
            self.mTickObjectList.Add((ITickedObject)tickObject);
        }
    }
}

- (void) removeObject:(IDelayHandleItem*) tickObject
{
    if (self.mLoopDepth.isInDepth())
    {
        super.removeObject(tickObject);
    }
    else
    {
        if (self.mTickObjectList.IndexOf((ITickedObject)tickObject) != -1)
        {
            self.mTickObjectList.Remove((ITickedObject)tickObject);
        }
    }
}

@end