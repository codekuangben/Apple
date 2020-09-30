#import "MyLibs/FrameHandle/TickMgr.h"

@implementation TickMgr

- (id) init
{
    self->mTickList = [[MList alloc] init];
}

- (void) init
{

}

- (void) dispose
{
    [self->mTickList Clear];
}

- (void) addTick:(ITickedObject*) tickObj
{
    [self addTick:tickObj priority:0];
}

- (void) addTick:(ITickedObject*) tickObj  priority:(float) priority
{
    [self addObject:(IDelayHandleItem*)tickObj priority:priority];
}

- (void) addObject:(IDelayHandleItem*) delayObject
{
    [self addObject:delayObject, priority:0];
}

- (void) addObject:(IDelayHandleItem*) delayObject, priority:(float) priority
{
    if ([self->mLoopDepth isInDepth]
    {
        [super addObject:delayObject priority:priority];
    }
    else
    {
        int position = -1;
        int idx = 0;
        int elemLen = [self->mTickList Count];

        while(idx < elemLen)
        {
            if ([self->mTickList get:idx] == nil)
            {
                continue;
            }

            if ([self->mTickList get:idx]->mTickObject == delayObject)
            {
                return;
            }

            if ([self->mTickList get:idx]->mPriority < priority)
            {
                position = idx;
                break;
            }

            idx += 1;
        }

        TickProcessObject* processObject = [[TickProcessObject alloc] init];
        processObject->mTickObject = (ITickedObject*)delayObject;
        processObject->mPriority = priority;

        if (position < 0 || position >= [self->mTickList Count])
        {
            [self->mTickList Add:processObject];
        }
        else
        {
            [self->mTickList Insert:position item:processObject];
        }
    }
}

- (void) removeTick:(ITickedObject*) tickObj
{
    [self removeObject:(IDelayHandleItem*)tickObj];
}

- (void) removeObject:(IDelayHandleItem*) delayObject
{
    if ([self->mLoopDepth isInDepth])
    {
        [super removeObject:delayObject];
    }
    else
    {
        for(TickProcessObject* item in [self->mTickList.list())
        {
            if ([UtilSysLibsWrap isAddressEqual:item.mTickObject b:delayObject])
            {
                [self->mTickList Remove:item];
                break;
            }
        }
    }
}

- (void) Advance:(float) delta
{
    [self->mLoopDepth incDepth];

    //foreach (TickProcessObject tk in self->mTickList.list())
    //{
    //    if (!(tk.mTickObject as IDelayHandleItem).isClientDispose())
    //    {
    //        (tk.mTickObject as ITickedObject).onTick(delta);
    //    }
    //}
    [self onPreAdvance:delta];
    [self onExecAdvance:delta];
    [self onPostAdvance:delta];

    [self->mLoopDepth decDepth];
}

- (void) onPreAdvance:(float) delta
{

}

- (void) onExecAdvance:(float) delta
{
    int idx = 0;
    int count = [self->mTickList Count];
    ITickedObject* tickObject = nil;

    while (idx < count)
    {
        tickObject = [self->mTickList get:idx]->mTickObject;

        if (![(IDelayHandleItem*)tickObject isClientDispose])
        {
            [tickObject onTick:delta];
        }

        ++idx;
    }
}

- (void) onPostAdvance:(float) delta
{

}

@end