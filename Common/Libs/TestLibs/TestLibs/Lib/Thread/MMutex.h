package SDK.Lib.Thread;

import java.util.concurrent.Semaphore;

import SDK.Lib.FrameWork.*;

/**
 * @brief 互斥
 */
@interface MMutex
{
    private Semaphore mMutex; 	// 读互斥
    private String mName;	// name

    public MMutex(boolean initiallyOwned, String name)
    {
        if (MacroDef.NET_MULTHREAD)
        {
            // IOS 下不支持，错误提示如下： "Named mutexes are not supported"
            //mMutex = new Mutex(initiallyOwned, name);
            self.mMutex = new Semaphore(2);
            self.mName = name;
        }
    }

    public (void) WaitOne()
    {
        if (MacroDef.NET_MULTHREAD)
        {
            try
            {
                self.mMutex.acquire();
            }
            catch (InterruptedException e)
            {

            }
        }
    }

    public (void) ReleaseMutex()
    {
        if (MacroDef.NET_MULTHREAD)
        {
            self.mMutex.release();
        }
    }

    public (void) close()
    {
        if (MacroDef.NET_MULTHREAD)
        {
            //self.mMutex.Close();
        }
    }
}