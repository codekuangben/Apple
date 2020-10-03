#import "MyLibs/FrameHandle/TickObjectMgrBase.h"
#import "MyLibs/FrameHandle/ITickedObject.h"

// 每一帧执行的对象管理器
@implementation TickObjectMgrBase

- (id) init
{
    if (self = [super init])
    {
        
    }
    
    return self;
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
    [self->mLoopDepth incDepth];

    [self onExecTick:delta];

    [self->mLoopDepth decDepth];
}

- (void) onExecTick:(float) delta
{
    int idx = 0;
    int count = [self->mTickObjectList Count];
    GObject<ITickedObject>* tickObject = nil;

    while (idx < count)
    {
        tickObject = [self->mTickObjectList get:idx];

        if (![(GObject<IDelayHandleItem>*)tickObject isClientDispose])
        {
            [tickObject onTick:delta];
        }

        ++idx;
    }
}

- (void) addObject:(GObject<IDelayHandleItem>*) tickObject
{
    [self addObject:tickObject priority:0];
}

- (void) addObject:(GObject<IDelayHandleItem>*) tickObject priority:(float) priority
{
    if ([self->mLoopDepth isInDepth])
    {
        [super addObject:tickObject];
    }
    else
    {
        if ([self->mTickObjectList IndexOf:(GObject<ITickedObject>*)tickObject] == -1)
        {
            [self->mTickObjectList Add:(GObject<ITickedObject>*)tickObject];
        }
    }
}

- (void) removeObject:(GObject<IDelayHandleItem>*) tickObject
{
    if ([self->mLoopDepth isInDepth])
    {
        [super removeObject:tickObject];
    }
    else
    {
        if ([self->mTickObjectList IndexOf:(GObject<ITickedObject>*)tickObject] != -1)
        {
            [self->mTickObjectList Remove:(GObject<ITickedObject>*)tickObject];
        }
    }
}

@end
