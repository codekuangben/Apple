#import "MyLibs/FrameHandle/LoopDepth.h"

@implementation LoopDepth

- (id) init
{
    self->mLoopDepth = 0;
    self->mIncHandle = nil;
    self->mDecHandle = nil;
    self->mZeroHandle = nil;

    return self;
}

- (void) setIncHandle:(GObject<IListenerObject>*) eventListener eventHandle:(SEL) eventHandle
{
    if (nil == self->mIncHandle)
    {
        self->mIncHandle = [[EventDispatchFunctionObject alloc] init];
    }

    [self->mIncHandle setFuncObject:eventListener eventHandle:eventHandle];
}

- (void) setDecHandle:(GObject<IListenerObject>*) eventListener eventHandle:(SEL) eventHandle
{
    if (nil == self->mDecHandle)
    {
        self->mDecHandle = [[EventDispatchFunctionObject alloc] init];
    }

    self->mDecHandle = value;
}

- (void) setZeroHandle:(GObject<IListenerObject>*) eventListener eventHandle:(SEL) eventHandle
{
    if (nil == self->mZeroHandle)
    {
        self->mZeroHandle = [[EventDispatchFunctionObject alloc] init];
    }

    self->mZeroHandle = value;
}

- (void) incDepth
{
    ++self->mLoopDepth;

    if(nil != self->mIncHandle)
    {
        [self->mIncHandle call];
    }
}

- (void) decDepth
{
    --self->mLoopDepth;

    if (nil != self->mDecHandle)
    {
        [self->mDecHandle call];
    }

    if(0 == self->mLoopDepth)
    {
        if (nil != self->mZeroHandle)
        {
            [self->mZeroHandle call];
        }
    }

    if(self->mLoopDepth < 0)
    {
        // 错误，不对称
        //UnityEngine.Debug.LogError("LoopDepth::decDepth, Error !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    }
}

- (BOOL) isInDepth
{
    return self->mLoopDepth > 0;
}

@end