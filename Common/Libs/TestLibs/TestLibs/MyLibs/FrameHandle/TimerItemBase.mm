#import "MyLibs/FrameHandle/TimerItemBase.h"
#include <math.h>

@implementation TimerItemBase

- (id) init
{
    self->mInternal = 1;
    self->mTotalTime = 1;
    self->mCurRunTime = 0;
    self->mCurCallTime = 0;
    self->mIsInfineLoop = false;
    self->mIntervalLeftTime = 0;
    self->mTimerDispatch = [[EventDispatchFunctionObject alloc] init];
    self->mDisposed = false;
    self->mIsContinuous = false;
    
    return self;
}

- (void) setFuncObject:(GObject<IListenerObject>*) eventListener eventHandle:(SEL) eventHandle;
{
    [self->mTimerDispatch eventListener:eventListener setFuncObject:eventHandle];
}

- (void) setTotalTime:(float) value
{
    self->mTotalTime = value;
}

- (float) getRunTime
{
    return self->mCurRunTime;
}

- (float) getCallTime
{
    return self->mCurCallTime;
}

- (float) getLeftRunTime
{
    return self->mTotalTime - self->mCurRunTime;
}

- (float) getLeftCallTime
{
    return self->mTotalTime - self->mCurCallTime;
}

// 在调用回调函数之前处理
- (void) onPreCallBack
{

}

- (void) OnTimer:(float) delta
{
    if (self->mDisposed)
    {
        return;
    }

    self->mCurRunTime += delta;
    if (self->mCurRunTime > self->mTotalTime)
    {
        self->mCurRunTime = self->mTotalTime;
    }
    self->mIntervalLeftTime += delta;

    if (self->mIsInfineLoop)
    {
        [self checkAndDisp];
    }
    else
    {
        if (self->mCurRunTime >= self->mTotalTime)
        {
            [self disposeAndDisp];
        }
        else
        {
            [self checkAndDisp];
        }
    }
}

- (void) disposeAndDisp
{
    if (self->mIsContinuous)
    {
        [self continueDisposeAndDisp];
    }
    else
    {
        [self discontinueDisposeAndDisp];
    }
}

- (void) continueDisposeAndDisp
{
    self->mDisposed = true;

    while (self->mIntervalLeftTime >= self->mInternal && self->mCurCallTime < self->mTotalTime)
    {
        self->mCurCallTime = self->mCurCallTime + self->mInternal;
        self->mIntervalLeftTime = self->mIntervalLeftTime - self->mInternal;
        [self onPreCallBack];

        if ([self->mTimerDispatch isValid])
        {
            [self->mTimerDispatch call:self];
        }
    }
}

- (void) discontinueDisposeAndDisp
{
    self->mDisposed = true;
    self->mCurCallTime = self->mTotalTime;
    [self onPreCallBack];

    if ([self->mTimerDispatch isValid])
    {
        [self->mTimerDispatch call:self];
    }
}

- (void) checkAndDisp
{
    if(self->mIsContinuous)
    {
        [self continueCheckAndDisp];
    }
    else
    {
        [self discontinueCheckAndDisp];
    }
}

// 连续的定时器
- (void) continueCheckAndDisp
{
    while (self->mIntervalLeftTime >= self->mInternal)
    {
        // 这个地方 m_curCallTime 肯定会小于 m_totalTime，因为在调用这个函数的外部已经进行了判断
        self->mCurCallTime = self->mCurCallTime + self->mInternal;
        self->mIntervalLeftTime = self->mIntervalLeftTime - self->mInternal;
        [self onPreCallBack];

        if ([self->mTimerDispatch isValid])
        {
            [self->mTimerDispatch call:self];
        }
    }
}

// 不连续的定时器
- (void) discontinueCheckAndDisp
{
    if (self->mIntervalLeftTime >= self->mInternal)
    {
        // 这个地方 m_curCallTime 肯定会小于 m_totalTime，因为在调用这个函数的外部已经进行了判断
        self->mCurCallTime = self->mCurCallTime + ((self->mIntervalLeftTime / self->mInternal) * self->mInternal);
        self->mIntervalLeftTime = fmod(self->mIntervalLeftTime, self->mInternal);   // 只保留余数
        [self onPreCallBack];

        if ([self->mTimerDispatch isValid])
        {
            [self->mTimerDispatch call:self];
        }
    }
}

- (void) reset
{
    self->mCurRunTime = 0;
    self->mCurCallTime = 0;
    self->mIntervalLeftTime = 0;
    self->mDisposed = false;
}

- (void) setClientDispose:(BOOL) isDispose
{

}

- (BOOL) isClientDispose
{
    return false;
}

- (void) startTimer
{
    //[Ctx ins]->mTimerMgr.addTimer(this);
}

- (void) stopTimer
{
    //[Ctx ins]->mTimerMgr.removeTimer(this);
}

@end
