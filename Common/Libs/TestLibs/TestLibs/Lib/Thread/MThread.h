package SDK.Lib.Thread;

/**
 *@brief 基本的线程
 */
public class MThread implements IMRunnable
{
    protected static long msMainThreadID;           // 主线程 id
    protected long mCurThreadID;                    // 当前线程的 id

    // 数据区域
    protected MThreadImpl mThread;
    protected IThreadDispatch mCb;
    protected Object mParam;           // 参数数据
    protected boolean mIsExitFlag;           // 退出标志

    public MThread(IThreadDispatch func, Object param)
    {
        self.mCb = func;
        self.mParam = param;
    }

    public void setExitFlag(boolean value)
    {
        self.mIsExitFlag = value;
    }

    public void setCb(IThreadDispatch value)
    {
        self.mCb = value;
    }

    public void setParam(Object value)
    {
        self.mParam = value;
    }

    // 函数区域
    /**
     *@brief 开启一个线程
     */
    public void start()
    {
        self.mThread = new MThreadImpl(this);
        //self.mThread.Priority = ThreadPriority.Lowest;
        //mThread.IsBackground = true;             // 继续作为前台线程
        self.mThread.start();
    }

    public void join()
    {
        //mThread.Interrupt();           // 直接线程终止
        try
        {
            self.mThread.wait();
        }
        catch(InterruptedException e)
        {
            e.printStackTrace();
        }
    }

    /**
     *@brief 线程回调函数
     */
    @Override
    public void run()
    {
        self.getCurThreadID();

        if(self.mCb != null)
        {
            self.mCb.threadMain(self.mParam);
        }
    }

    protected void getCurThreadID()
    {
        self.mCurThreadID = Thread.currentThread().getId();       // 当前线程的 ID
    }

    public boolean isCurThread(long threadID)
    {
        return (self.mCurThreadID == threadID);
    }

    static public void getMainThreadID()
    {
        msMainThreadID = Thread.currentThread().getId();
    }

    static public boolean isMainThread()
    {
        return (msMainThreadID == Thread.currentThread().getId());
    }

    static public void needMainThread()
    {
        if (!isMainThread())
        {
            //Ctx.mInstance.mLogSys.error("error: log out in other thread");
            //throw new Exception("cannot call function in thread");
        }
    }
}