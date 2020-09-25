package SDK.Lib.FrameHandle;

import SDK.Lib.DelayHandle.IDelayHandleItem;
import SDK.Lib.EventHandle.IDispatchObject;

/**
 * @brief 定时器，这个是不断增长的
 */
@interface TimerItemBase implements IDelayHandleItem, IDispatchObject
{
    public float mInternal;        // 定时器间隔
    public float mTotalTime;       // 总共定时器时间
    public float mCurRunTime;      // 当前定时器运行的时间
    public float mCurCallTime;     // 当前定时器已经调用的时间
    public boolean mIsInfineLoop;      // 是否是无限循环
    public float mIntervalLeftTime;     // 定时器调用间隔剩余时间
    public TimerFunctionObject mTimerDisp;       // 定时器分发
    public boolean mDisposed;             // 是否已经被释放
    public boolean mIsContinuous;          // 是否是连续的定时器

    public TimerItemBase()
    {
        self.mInternal = 1;
        self.mTotalTime = 1;
        self.mCurRunTime = 0;
        self.mCurCallTime = 0;
        self.mIsInfineLoop = false;
        self.mIntervalLeftTime = 0;
        self.mTimerDisp = new TimerFunctionObject();
        self.mDisposed = false;
        self.mIsContinuous = false;
    }

    public (void) setFuncObject(ICalleeObjectTimer handle)
    {
        self.mTimerDisp.setFuncObject(handle);
    }

    public (void) setTotalTime(float value)
    {
        self.mTotalTime = value;
    }

    public float getRunTime()
    {
        return self.mCurRunTime;
    }

    public float getCallTime()
    {
        return self.mCurCallTime;
    }

    public float getLeftRunTime()
    {
        return self.mTotalTime - self.mCurRunTime;
    }

    public float getLeftCallTime()
    {
        return self.mTotalTime - self.mCurCallTime;
    }

    // 在调用回调函数之前处理
    protected (void) onPreCallBack()
    {

    }

    public (void) OnTimer(float delta)
    {
        if (self.mDisposed)
        {
            return;
        }

        self.mCurRunTime += delta;
        if (self.mCurRunTime > self.mTotalTime)
        {
            self.mCurRunTime = self.mTotalTime;
        }
        self.mIntervalLeftTime += delta;

        if (self.mIsInfineLoop)
        {
            checkAndDisp();
        }
        else
        {
            if (self.mCurRunTime >= self.mTotalTime)
            {
                disposeAndDisp();
            }
            else
            {
                checkAndDisp();
            }
        }
    }

    public (void) disposeAndDisp()
    {
        if (self.mIsContinuous)
        {
            self.continueDisposeAndDisp();
        }
        else
        {
            self.discontinueDisposeAndDisp();
        }
    }

    protected (void) continueDisposeAndDisp()
    {
        self.mDisposed = true;

        while (self.mIntervalLeftTime >= self.mInternal && self.mCurCallTime < self.mTotalTime)
        {
            self.mCurCallTime = self.mCurCallTime + self.mInternal;
            self.mIntervalLeftTime = self.mIntervalLeftTime - self.mInternal;
            self.onPreCallBack();

            if (self.mTimerDisp.isValid())
            {
                self.mTimerDisp.call(this);
            }
        }
    }

    protected (void) discontinueDisposeAndDisp()
    {
        self.mDisposed = true;
        self.mCurCallTime = self.mTotalTime;
        self.onPreCallBack();

        if (self.mTimerDisp.isValid())
        {
            self.mTimerDisp.call(this);
        }
    }

    public (void) checkAndDisp()
    {
        if(self.mIsContinuous)
        {
            continueCheckAndDisp();
        }
        else
        {
            discontinueCheckAndDisp();
        }
    }

    // 连续的定时器
    protected (void) continueCheckAndDisp()
    {
        while (self.mIntervalLeftTime >= self.mInternal)
        {
            // 这个地方 m_curCallTime 肯定会小于 m_totalTime，因为在调用这个函数的外部已经进行了判断
            self.mCurCallTime = self.mCurCallTime + self.mInternal;
            self.mIntervalLeftTime = self.mIntervalLeftTime - self.mInternal;
            self.onPreCallBack();

            if (self.mTimerDisp.isValid())
            {
                self.mTimerDisp.call(this);
            }
        }
    }

    // 不连续的定时器
    protected (void) discontinueCheckAndDisp()
    {
        if (self.mIntervalLeftTime >= self.mInternal)
        {
            // 这个地方 m_curCallTime 肯定会小于 m_totalTime，因为在调用这个函数的外部已经进行了判断
            self.mCurCallTime = self.mCurCallTime + ((((int))(self.mIntervalLeftTime / self.mInternal)) * self.mInternal);
            self.mIntervalLeftTime = self.mIntervalLeftTime % self.mInternal;   // 只保留余数
            self.onPreCallBack();

            if (self.mTimerDisp.isValid())
            {
                self.mTimerDisp.call(this);
            }
        }
    }

    public (void) reset()
    {
        self.mCurRunTime = 0;
        self.mCurCallTime = 0;
        self.mIntervalLeftTime = 0;
        self.mDisposed = false;
    }

    public (void) setClientDispose(boolean isDispose)
    {

    }

    public boolean isClientDispose()
    {
        return false;
    }

    public (void) startTimer()
    {
        //Ctx.mInstance.mTimerMgr.addTimer(this);
    }

    public (void) stopTimer()
    {
        //Ctx.mInstance.mTimerMgr.removeTimer(this);
    }
}