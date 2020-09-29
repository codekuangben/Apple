#import "MyLibs/FrameHandle/TimeInterval.h"

@implementation TimeInterval

- (id) init
{
    self.mInterval = 1 / 10;    // 每一秒更新 10 次
    self.mTotalTime = 0;
    self.mCurTime = 0;
}

- (void) setInterval:(float) value
{
    self.mInterval = value;
}

- (void) setTotalTime:(float) value
{
    self.mTotalTime = value;
}

- (void) setCurTime:(float) value
{
    self.mCurTime = value;
}

- (boolean) canExec:(float) delta
{
    boolean ret = false;

    self.mTotalTime += delta;
    self.mCurTime += delta;

    if(self.mCurTime >= self.mInterval)
    {
        ret = true;
        self.mCurTime -= self.mInterval;
    }

    return ret;
}

@end