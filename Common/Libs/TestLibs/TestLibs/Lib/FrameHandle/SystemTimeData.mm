package SDK.Lib.FrameHandle;

import SDK.Lib.FrameWork.Ctx;

public class SystemTimeData
{
    protected long mPreTime;           // 上一次更新时的秒数
    protected long mCurTime;           // 正在获取的时间
    protected float mDeltaSec;         // 两帧之间的间隔
    protected boolean mIsFixFrameRate;     // 固定帧率
    protected float mFixFrameRate;       // 固定帧率
    protected float mScale;             // delta 缩放

    // Edit->Project Setting->time
    protected float mFixedTimestep;

    public SystemTimeData()
    {
        self.mPreTime = 0;
        self.mCurTime = 0;
        self.mDeltaSec = 0.0f;
        self.mIsFixFrameRate = false;
        self.mFixFrameRate = 0.0417f;       //  1 / 24;
        self.mScale = 1;

        self.mFixedTimestep = 0.02f;
    }

    public void init()
    {

    }

    public void dispose()
    {

    }

    public float getDeltaSec()
    {
        return self.mDeltaSec;
    }

    public void setDeltaSec(float value)
    {
        self.mDeltaSec = value;
    }

    public float getFixedTimestep()
    {
        if (Ctx.mInstance.mCfg.mIsActorMoveUseFixUpdate)
        {
            return self.mFixedTimestep;
        }
        else
        {
            return self.mDeltaSec;
        }
    }

    public long getCurTime()
    {
        return self.mCurTime;
    }

    public void setCurTime(long value)
    {
        self.mCurTime = value;
    }

    public void nextFrame()
    {
        self.mPreTime = self.mCurTime;
        self.mCurTime = System.currentTimeMillis()/1000;

        if (mIsFixFrameRate)
        {
            self.mDeltaSec = self.mFixFrameRate;        // 每秒 24 帧
        }
        else
        {
            if (self.mPreTime != 0f)     // 第一帧跳过，因为这一帧不好计算间隔
            {
                self.mDeltaSec = (float)(self.mCurTime - self.mPreTime);
            }
            else
            {
                self.mDeltaSec = self.mFixFrameRate;        // 每秒 24 帧
            }
        }

        self.mDeltaSec *= self.mScale;
    }
}