#import "MyLibs/FameHandle/TimerItemBase.h"
/**
 * @brief 定时器，这个是不断增长的
 */
@implementation TimerItemBase

- (id) init
{
    self.mInternal = 1;
    self.mTotalTime = 1;
    self.mCurRunTime = 0;
    self.mCurCallTime = 0;
    self.mIsInfineLoop = false;
    self.mIntervalLeftTime = 0;
    self.mTimerDisp = new TimerFunctionObject();
    self.mDisposed = false;
    self.mIsContinuous = false;
}

- (void) setFuncObject:(ICalleeObjectTimer*) handle
{
    self.mTimerDisp.setFuncObject(handle);
}

- (void) setTotalTime:(float) value
{
    self.mTotalTime = value;
}

- (float) getRunTime
{
    return self.mCurRunTime;
}

- (float) getCallTime
{
    return self.mCurCallTime;
}

- (float) getLeftRunTime
{
    return self.mTotalTime - self.mCurRunTime;
}

- (float) getLeftCallTime
{
    return self.mTotalTime - self.mCurCallTime;
}

// 在调用回调函数之前处理
- (void) onPreCallBack
{

}

- (void) OnTimer:(float) delta
{
    if (self.mDisposed)
    {
        return;
    }

    self.mCurRunTime += delta;
    if (self.mCurRunTime > self.mTotalTime)
    {
        self.mCurRunTime = self.mTotalTime;
    }
    self.mIntervalLeftTime += delta;

    if (self.mIsInfineLoop)
    {
        checkAndDisp();
    }
    else
    {
        if (self.mCurRunTime >= self.mTotalTime)
        {
            disposeAndDisp();
        }
        else
        {
            checkAndDisp();
        }
    }
}

- (void) disposeAndDisp
{
    if (self.mIsContinuous)
    {
        self.continueDisposeAndDisp();
    }
    else
    {
        self.discontinueDisposeAndDisp();
    }
}

- (void) continueDisposeAndDisp
{
    self.mDisposed = true;

    while (self.mIntervalLeftTime >= self.mInternal && self.mCurCallTime < self.mTotalTime)
    {
        self.mCurCallTime = self.mCurCallTime + self.mInternal;
        self.mIntervalLeftTime = self.mIntervalLeftTime - self.mInternal;
        self.onPreCallBack();

        if (self.mTimerDisp.isValid())
        {
            self.mTimerDisp.call(this);
        }
    }
}

- (void) discontinueDisposeAndDisp
{
    self.mDisposed = true;
    self.mCurCallTime = self.mTotalTime;
    self.onPreCallBack();

    if (self.mTimerDisp.isValid())
    {
        self.mTimerDisp.call(this);
    }
}

- (void) checkAndDisp
{
    if(self.mIsContinuous)
    {
        continueCheckAndDisp();
    }
    else
    {
        discontinueCheckAndDisp();
    }
}

// 连续的定时器
- (void) continueCheckAndDisp
{
    while (self.mIntervalLeftTime >= self.mInternal)
    {
        // 这个地方 m_curCallTime 肯定会小于 m_totalTime，因为在调用这个函数的外部已经进行了判断
        self.mCurCallTime = self.mCurCallTime + self.mInternal;
        self.mIntervalLeftTime = self.mIntervalLeftTime - self.mInternal;
        self.onPreCallBack();

        if (self.mTimerDisp.isValid())
        {
            self.mTimerDisp.call(this);
        }
    }
}

// 不连续的定时器
- (void) discontinueCheckAndDisp
{
    if (self.mIntervalLeftTime >= self.mInternal)
    {
        // 这个地方 m_curCallTime 肯定会小于 m_totalTime，因为在调用这个函数的外部已经进行了判断
        self.mCurCallTime = self.mCurCallTime + ((((int))(self.mIntervalLeftTime / self.mInternal)) * self.mInternal);
        self.mIntervalLeftTime = self.mIntervalLeftTime % self.mInternal;   // 只保留余数
        self.onPreCallBack();

        if (self.mTimerDisp.isValid())
        {
            self.mTimerDisp.call(this);
        }
    }
}

- (void) reset
{
    self.mCurRunTime = 0;
    self.mCurCallTime = 0;
    self.mIntervalLeftTime = 0;
    self.mDisposed = false;
}

- (void) setClientDispose(BOOL) isDispose
{

}

- (BOOL) isClientDispose
{
    return false;
}

- (void) startTimer
{
    //Ctx.mInstance.mTimerMgr.addTimer(this);
}

- (void) stopTimer
{
    //Ctx.mInstance.mTimerMgr.removeTimer(this);
}

@end