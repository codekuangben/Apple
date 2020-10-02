#import "MyLibs/FrameHandle/SystemTimeData.h"

@implementation SystemTimeData

- (void) init
{

}

- (void) dispose
{

}

- float getDeltaSec
{
    return self->mDeltaSec;
}

- (void) setDeltaSec:(float) value
{
    self->mDeltaSec = value;
}

- float getFixedTimestep
{
    if ([Ctx ins]->mCfg->mIsActorMoveUseFixUpdate)
    {
        return self->mFixedTimestep;
    }
    else
    {
        return self->mDeltaSec;
    }
}

- long getCurTime
{
    return self->mCurTime;
}

- (void) setCurTime:(long) value
{
    self->mCurTime = value;
}

- (void) nextFrame
{
    self->mPreTime = self->mCurTime;
    self->mCurTime = System.currentTimeMillis()/1000;

    if (mIsFixFrameRate)
    {
        self->mDeltaSec = self->mFixFrameRate;        // 每秒 24 帧
    }
    else
    {
        if (self->mPreTime != 0f)     // 第一帧跳过，因为这一帧不好计算间隔
        {
            self->mDeltaSec = (float)(self->mCurTime - self->mPreTime);
        }
        else
        {
            self->mDeltaSec = self->mFixFrameRate;        // 每秒 24 帧
        }
    }

    self->mDeltaSec *= self->mScale;
}

@end