package SDK.Lib.Thread;

/**
 * @brief 单一对象同步
 */
@interface MCondition
{
    protected MMutex mMutex;
    protected MEvent mEvent;
    protected boolean mCanEnterWait;  // 是否可以进入等待

    public MCondition(String name)
    {
        self.mMutex = new MMutex(false, name);
        self.mEvent = new MEvent(false);
        self.mCanEnterWait = true;      // 允许进入等待状态
    }

    public boolean getCanEnterWait()
    {
        return self.mCanEnterWait;
    }

    public (void) waitImpl()
    {
        //using (MLock mlock = new MLock(mMutex))
        //{
            self.mMutex.WaitOne();
            if (self.mCanEnterWait)
            {
                self.mMutex.ReleaseMutex();   // 这个地方需要释放锁，否则 notifyAll 进不来
                self.mEvent.WaitOne();
                self.mEvent.Reset();      // 重置信号
            }
            else
            {
                self.mCanEnterWait = true;
                self.mMutex.ReleaseMutex();
            }
        //}
    }

    public (void) notifyAllImpl()
    {
        MLock mlock = new MLock(mMutex);

        {
            if (self.mCanEnterWait) // 如果 mCanEnterWait == false，必然不能进入等待
            {
                self.mCanEnterWait = false;
                self.mEvent.Set();        // 唤醒线程
            }
        }
    }
}