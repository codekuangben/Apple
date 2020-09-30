#import "MyLibs/FrameWork/ProcessSys.h"

@implementation ProcessSys

- (id) init
{

}

- (void) ProcessNextFrame
{
    Ctx.mInstance.mSystemTimeData.nextFrame();
    self->Advance(Ctx.mInstance.mSystemTimeData.getDeltaSec());
}

- (void) Advance:(float) delta
{
    Ctx.mInstance.mSystemFrameData.nextFrame(delta);
    Ctx.mInstance.mTickMgr.Advance(delta);            // 心跳
    Ctx.mInstance.mTimerMgr.Advance(delta);           // 定时器
    Ctx.mInstance.mFrameTimerMgr.Advance(delta);      // 帧定时器
}

- (void) ProcessNextFixedFrame
{
    self->FixedAdvance(Ctx.mInstance.mSystemTimeData.getFixedTimestep());
}

- (void) FixedAdvance:(float) delta
{
    Ctx.mInstance.mFixedTickMgr.Advance(delta);
}

@end