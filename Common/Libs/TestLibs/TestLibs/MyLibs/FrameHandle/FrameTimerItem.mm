#import "MyLibs/FrameHandle/FrameTimerItem.h"

@implementation FrameTimerItem

- (id) init
{
    self->mInternal = 1;
    self->mTotalFrameCount = 1;
    self->mCurFrame = 0;
    self->mIsInfineLoop = false;
    self->mCurLeftFrame = 0;
    self->mTimerDispatch = [[EventDispatchFunctionObject alloc] init];;
    self->mDisposed = false;
    
    return self;
}

- (void) setFuncObject:(GObject<IListenerObject>*) eventListener eventHandle:(SEL) eventHandle;
{
    [self->mTimerDispatch eventListener:eventListener setFuncObject:eventHandle];
}

- (void) OnFrameTimer
{
    if (self->mDisposed)
    {
        return;
    }

    ++self->mCurFrame;
    ++self->mCurLeftFrame;

    //if (m_preFrame == m_curFrame)
    //{

    //}

    //m_curFrame = m_preFrame;

    if (self->mIsInfineLoop)
    {
        if (self->mCurLeftFrame == self->mInternal)
        {
            self->mCurLeftFrame = 0;

            if (self->mTimerDispatch != nil)
            {
                [self->mTimerDispatch call: self];
            }
        }
    }
    else
    {
        if (self->mCurFrame == self->mTotalFrameCount)
        {
            self->mDisposed = true;
            if (self->mTimerDispatch != nil)
            {
                [self->mTimerDispatch call: self];
            }
        }
        else
        {
            if (self->mCurLeftFrame == self->mInternal)
            {
                self->mCurLeftFrame = 0;
                if (self->mTimerDispatch != nil)
                {
                    [self->mTimerDispatch call: self];
                }
            }
        }
    }
}

- (void) reset
{
    self->mCurFrame = 0;
    self->mCurLeftFrame = 0;
    self->mDisposed = false;
}

- (void) setClientDispose:(BOOL) isDispose
{

}

- (BOOL) isClientDispose
{
    return false;
}

@end
