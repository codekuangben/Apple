package SDK.Lib.FrameHandle;

import SDK.Lib.DelayHandle.IDelayHandleItem;

/**
 * @brief 定时器，这个是不断增长的
 */
public class FrameTimerItem implements IDelayHandleItem
{
    public (int) mInternal;              // 帧数间隔
    public (int) mTotalFrameCount;       // 总共次数
    public (int) mCurFrame;              // 当前已经调用的定时器的时间
    public (int) mCurLeftFrame;          // 剩余帧数
    public boolean mIsInfineLoop;      // 是否是无限循环
    public ICalleeObjectFrameTimer mTimerDisp;       // 定时器分发
    public boolean mDisposed;             // 是否已经被释放

    //protected (int) m_preFrame = 0;

    public FrameTimerItem()
    {
        self.mInternal = 1;
        self.mTotalFrameCount = 1;
        self.mCurFrame = 0;
        self.mIsInfineLoop = false;
        self.mCurLeftFrame = 0;
        self.mTimerDisp = null;
        self.mDisposed = false;
    }

    public (void) OnFrameTimer()
    {
        if (self.mDisposed)
        {
            return;
        }

        ++self.mCurFrame;
        ++self.mCurLeftFrame;

        //if (m_preFrame == m_curFrame)
        //{

        //}

        //m_curFrame = m_preFrame;

        if (self.mIsInfineLoop)
        {
            if (self.mCurLeftFrame == self.mInternal)
            {
                self.mCurLeftFrame = 0;

                if (self.mTimerDisp != null)
                {
                    self.mTimerDisp.call(this);
                }
            }
        }
        else
        {
            if (self.mCurFrame == self.mTotalFrameCount)
            {
                self.mDisposed = true;
                if (self.mTimerDisp != null)
                {
                    self.mTimerDisp.call(this);
                }
            }
            else
            {
                if (self.mCurLeftFrame == self.mInternal)
                {
                    self.mCurLeftFrame = 0;
                    if (self.mTimerDisp != null)
                    {
                        self.mTimerDisp.call(this);
                    }
                }
            }
        }
    }

    public (void) reset()
    {
        self.mCurFrame = 0;
        self.mCurLeftFrame = 0;
        self.mDisposed = false;
    }

    public (void) setClientDispose(boolean isDispose)
    {

    }

    public boolean isClientDispose()
    {
        return false;
    }
}