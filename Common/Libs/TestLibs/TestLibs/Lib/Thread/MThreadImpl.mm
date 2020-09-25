package SDK.Lib.Thread;

/**
 *
 * @brief 真正的线程实现
 */

@interface MThreadImpl : Thread
{
    protected IMRunnable mRunnable;

    public MThreadImpl(IMRunnable value)
    {
        self.mRunnable = value;
    }

    @Override
    public (void) run()
    {
        if(null != self.mRunnable)
        {
            self.mRunnable.run();
        }
    }
}
