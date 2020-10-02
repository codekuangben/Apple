#import "MyLibs/FrameWork/ProcessSys.h"

@implementation ProcessSys

- (id) init
{

}

- (void) ProcessNextFrame
{
    [[Ctx ins]->mSystemTimeData nextFrame()];
    [self Advance:[[Ctx ins]->mSystemTimeData getDeltaSec]];
}

- (void) Advance:(float) delta
{
    [[Ctx ins]->mSystemFrameData nextFrame:delta];
    [[Ctx ins]->mTickMgr Advance:delta];            // 心跳
    [[Ctx ins]->mTimerMgr Advance:delta:];           // 定时器
    [[Ctx ins]->mFrameTimerMgr Advance:delta];      // 帧定时器
}

- (void) ProcessNextFixedFrame
{
    [self FixedAdvance:[[Ctx ins]->mSystemTimeData getFixedTimestep]];
}

- (void) FixedAdvance:(float) delta
{
    [[Ctx ins]->mFixedTickMgr Advance:delta];
}

@end