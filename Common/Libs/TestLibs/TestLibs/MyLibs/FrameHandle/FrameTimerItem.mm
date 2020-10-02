#import "MyLibs/FrameHandle/FrameTimerItem.h"

@implementation FrameTimerItem

- (id) init
{
    self->mInternal = 1;
    self->mTotalFrameCount = 1;
    self->mCurFrame = 0;
    self->mIsInfineLoop = false;
    self->mCurLeftFrame = 0;
    self->mTimerDisp = nil;
    self->mDisposed = false;
    
    return self;
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

            if (self->mTimerDisp != nil)
            {
                [self->mTimerDisp call: this];
            }
        }
    }
    else
    {
        if (self->mCurFrame == self->mTotalFrameCount)
        {
            self->mDisposed = true;
            if (self->mTimerDisp != nil)
            {
                [self->mTimerDisp call: this];
            }
        }
        else
        {
            if (self->mCurLeftFrame == self->mInternal)
            {
                self->mCurLeftFrame = 0;
                if (self->mTimerDisp != nil)
                {
                    [self->mTimerDisp call: this];
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
