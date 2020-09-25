#include "TimerItemBase.h"

@implementation CountDownTimer

-(void) init
{
    if(self = [super init])
    {
		
    }
    
    return self;
}

-(void) setTotalTime:(float) value
{
    [super setTotalTime:value];
    self.mCurRunTime = value;
}

-(float) getRunTime
{
    return self.mTotalTime - self.mCurRunTime;
}

// 如果要获取剩余的倒计时时间，使用 getLeftCallTime
-(float) getLeftRunTime
{
    return self.mCurRunTime;
}

-(void) OnTimer:(float) delta
{
    if (self.mDisposed)
    {
        return;
    }

    self.mCurRunTime -= delta;
    if(self.mCurRunTime < 0)
    {
        self.mCurRunTime = 0;
    }
    self.mIntervalLeftTime += delta;

    if (self.mIsInfineLoop)
    {
        [self checkAndDisp];
    }
    else
    {
        if (self.mCurRunTime <= 0)
        {
            [self disposeAndDisp];
        }
        else
        {
            [self checkAndDisp];
        }
    }
}

-(void) reset
{
    self.mCurRunTime = self.mTotalTime;
    self.mCurCallTime = 0;
    self.mIntervalLeftTime = 0;
    self.mDisposed = false;
}

@end
