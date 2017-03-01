﻿package SDK.Lib.FrameHandle;

/**
 * @brief 事件间隔
 */
public class TimeInterval
{
    protected float mInterval;
    protected float mTotalTime;
    protected float mCurTime;

    public TimeInterval()
    {
        this.mInterval = 1 / 10;    // 每一秒更新 10 次
        this.mTotalTime = 0;
        this.mCurTime = 0;
    }

    public void setInterval(float value)
    {
        this.mInterval = value;
    }

    public void setTotalTime(float value)
    {
        this.mTotalTime = value;
    }

    public void setCurTime(float value)
    {
        this.mCurTime = value;
    }

    public boolean canExec(float delta)
    {
        boolean ret = false;

        this.mTotalTime += delta;
        this.mCurTime += delta;

        if(this.mCurTime >= this.mInterval)
        {
            ret = true;
            this.mCurTime -= this.mInterval;
        }

        return ret;
    }
}