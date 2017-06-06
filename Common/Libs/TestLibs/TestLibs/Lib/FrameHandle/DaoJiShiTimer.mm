package SDK.Lib.FrameHandle;

/**
 * @brief 倒计时定时器
 */
public class DaoJiShiTimer extends TimerItemBase
{
    @Override
    public void setTotalTime(float value)
    {
        super.setTotalTime(value);
        self.mCurRunTime = value;
    }

    @Override
    public float getRunTime()
    {
        return self.mTotalTime - self.mCurRunTime;
    }

    // 如果要获取剩余的倒计时时间，使用 getLeftCallTime
    @Override
    public float getLeftRunTime()
    {
        return self.mCurRunTime;
    }

    @Override
    public void OnTimer(float delta)
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
            checkAndDisp();
        }
        else
        {
            if (self.mCurRunTime <= 0)
            {
                disposeAndDisp();
            }
            else
            {
                checkAndDisp();
            }
        }
    }

    @Override
    public void reset()
    {
        self.mCurRunTime = self.mTotalTime;
        self.mCurCallTime = 0;
        self.mIntervalLeftTime = 0;
        self.mDisposed = false;
    }
}