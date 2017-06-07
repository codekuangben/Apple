package SDK.Lib.FrameHandle;

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
        self.mInterval = 1 / 10;    // 每一秒更新 10 次
        self.mTotalTime = 0;
        self.mCurTime = 0;
    }

    public (void) setInterval(float value)
    {
        self.mInterval = value;
    }

    public (void) setTotalTime(float value)
    {
        self.mTotalTime = value;
    }

    public (void) setCurTime(float value)
    {
        self.mCurTime = value;
    }

    public boolean canExec(float delta)
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
}