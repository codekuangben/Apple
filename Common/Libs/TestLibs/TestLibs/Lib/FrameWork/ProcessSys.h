﻿/**
* @brief 系统循环
*/
package SDK.Lib.FrameWork;

@interface ProcessSys
{
    public ProcessSys()
    {

    }

    public (void) ProcessNextFrame()
    {
        Ctx.mInstance.mSystemTimeData.nextFrame();
        self.Advance(Ctx.mInstance.mSystemTimeData.getDeltaSec());
    }

    public (void) Advance(float delta)
    {
        Ctx.mInstance.mSystemFrameData.nextFrame(delta);
        Ctx.mInstance.mTickMgr.Advance(delta);            // 心跳
        Ctx.mInstance.mTimerMgr.Advance(delta);           // 定时器
        Ctx.mInstance.mFrameTimerMgr.Advance(delta);      // 帧定时器
    }

    public (void) ProcessNextFixedFrame()
    {
        self.FixedAdvance(Ctx.mInstance.mSystemTimeData.getFixedTimestep());
    }

    public (void) FixedAdvance(float delta)
    {
        Ctx.mInstance.mFixedTickMgr.Advance(delta);
    }
}