package SDK.Lib.Log;

import SDK.Lib.DataStruct.LockList;
import SDK.Lib.DataStruct.MList;
import SDK.Lib.FrameWork.MacroDef;
import SDK.Lib.Thread.MThread;
import SDK.Lib.Tools.TClassOp;
import SDK.Lib.Tools.UtilApi;

public class LogSys
{
    protected LockList<String> mAsyncLogList;              // 这个是多线程访问的
    protected LockList<String> mAsyncWarnList;            // 这个是多线程访问的
    protected LockList<String> mAsyncErrorList;          // 这个是多线程访问的

    protected String mTmpStr;

    protected MList<LogDeviceBase> mLogDeviceList;
    protected MList<LogTypeId>[] mEnableLogTypeList;

    protected boolean[] mEnableLog;    // 全局开关
    protected boolean[] mIsOutStack;     // 是否显示堆栈信息
    protected boolean[] mIsOutTimeStamp;   // 是否有时间戳

    // 构造函数仅仅是初始化变量，不涉及逻辑
    public LogSys()
    {
        self.mAsyncLogList = new LockList<String>("Logger_asyncLogList");
        self.mAsyncWarnList = new LockList<String>("Logger_asyncWarnList");
        self.mAsyncErrorList = new LockList<String>("Logger_asyncErrorList");
        self.mLogDeviceList = new MList<LogDeviceBase>();

        //self.mEnableLogTypeList = new MList<LogTypeId>[LogColor.eLC_Count.ordinal();
        Class classT = MList.class;
        self.mEnableLogTypeList = (MList<LogTypeId>[])TClassOp.createArray(classT, LogColor.eLC_Count.ordinal());
        self.mEnableLogTypeList[LogColor.eLC_LOG.ordinal()] = new MList<LogTypeId>();
        self.mEnableLogTypeList[LogColor.eLC_LOG.ordinal()].Add(LogTypeId.eLogCommon);

        self.mEnableLogTypeList[LogColor.eLC_WARN.ordinal()] = new MList<LogTypeId>();
        self.mEnableLogTypeList[LogColor.eLC_ERROR.ordinal()] = new MList<LogTypeId>();

        self.mEnableLog = new boolean[LogColor.eLC_Count.ordinal()];
        self.mEnableLog[(int)LogColor.eLC_LOG.ordinal()] = true;
        self.mEnableLog[(int)LogColor.eLC_WARN.ordinal()] = false;
        self.mEnableLog[(int)LogColor.eLC_ERROR.ordinal()] = false;

        self.mIsOutStack = new boolean[(int)LogColor.eLC_Count.ordinal()];
        self.mIsOutStack[(int)LogColor.eLC_LOG.ordinal()] = false;
        self.mIsOutStack[(int)LogColor.eLC_WARN.ordinal()] = false;
        self.mIsOutStack[(int)LogColor.eLC_ERROR.ordinal()] = false;

        self.mIsOutTimeStamp = new boolean[(int)LogColor.eLC_Count.ordinal()];
        self.mIsOutStack[(int)LogColor.eLC_LOG.ordinal()] = false;
        self.mIsOutStack[(int)LogColor.eLC_WARN.ordinal()] = false;
        self.mIsOutStack[(int)LogColor.eLC_ERROR.ordinal()] = false;
    }

    // 初始化逻辑处理
    public void init()
    {
        self.registerDevice();
        self.registerFileLogDevice();
    }

    // 析构
    public void dispose()
    {
        self.closeDevice();
    }

    public void setEnableLog(boolean value)
    {
        self.mEnableLog[(int)LogColor.eLC_LOG.ordinal()] = value;
    }

    public void setEnableWarn(boolean value)
    {
        self.mEnableLog[(int)LogColor.eLC_WARN.ordinal()] = value;
    }

    public void setEnableError(boolean value)
    {
        self.mEnableLog[(int)LogColor.eLC_ERROR.ordinal()] = value;
    }

    protected void registerDevice()
    {
        LogDeviceBase logDevice = null;

        if (MacroDef.ENABLE_WINLOG)
        {
            logDevice = new WinLogDevice();
            logDevice.initDevice();
            self.mLogDeviceList.Add(logDevice);
        }

        if (MacroDef.ENABLE_NETLOG)
        {
            logDevice = new NetLogDevice();
            logDevice.initDevice();
            self.mLogDeviceList.Add(logDevice);
        }
    }

    // 注册文件日志，因为需要账号，因此需要等待输入账号后才能注册，可能多次注册
    public void registerFileLogDevice()
    {

        if (MacroDef.ENABLE_FILELOG)
        {
            unRegisterFileLogDevice();

            LogDeviceBase logDevice = null;
            logDevice = new FileLogDevice();
            //((FileLogDevice)logDevice).fileSuffix = Ctx.mInstance.mDataPlayer.m_accountData.m_account;
            logDevice.initDevice();
            self.mLogDeviceList.Add(logDevice);
        }
    }

    protected void unRegisterFileLogDevice()
    {
        for(LogDeviceBase item : mLogDeviceList.list())
        {
            if(FileLogDevice.class == item.getClass())
            {
                item.closeDevice();
                self.mLogDeviceList.Remove(item);
                break;
            }
        }
    }

    protected boolean isInFilter(LogTypeId logTypeId, LogColor logColor)
    {
        if (self.mEnableLog[(int)logColor.ordinal()])
        {
            if (self.mEnableLogTypeList[(int)logColor.ordinal()].Contains(logTypeId))
            {
                return true;
            }

            return false;
        }

        return false;
    }

    public void log(String message)
    {
        self.log(message, LogTypeId.eLogCommon);
    }

    public void log(String message, LogTypeId logTypeId)
    {
        if (isInFilter(logTypeId, LogColor.eLC_LOG))
        {
            if(self.mIsOutTimeStamp[(int)LogColor.eLC_LOG.ordinal()])
            {
                message = String.format("{0}: {1}", UtilApi.getFormatTime(), message);
            }

            if (self.mIsOutStack[(int)LogColor.eLC_LOG.ordinal()])
            {
                Throwable ex = new Throwable();
                String traceStr = ex.toString();
                message = String.format("{0}\n{1}", message, traceStr);
            }

            if (MThread.isMainThread())
            {
                self.logout(message, LogColor.eLC_LOG);
            }
            else
            {
                self.asyncLog(message);
            }
        }
    }

    public void warn(String message)
    {
        self.warn(message, LogTypeId.eLogCommon);
    }

    public void warn(String message, LogTypeId logTypeId)
    {
        if (isInFilter(logTypeId, LogColor.eLC_WARN))
        {
            if (self.mIsOutTimeStamp[(int)LogColor.eLC_WARN.ordinal()])
            {
                message = String.format("{0}: {1}", UtilApi.getFormatTime(), message);
            }

            if (self.mIsOutStack[(int)LogColor.eLC_WARN.ordinal()])
            {
                Throwable ex = new Throwable();
                String traceStr = ex.toString();
                message = String.format("{0}\n{1}", message, traceStr);
            }

            if (MThread.isMainThread())
            {
                self.logout(message, LogColor.eLC_WARN);
            }
            else
            {
                self.asyncWarn(message);
            }
        }
    }

    public void error(String message)
    {
        self.error(message, LogTypeId.eLogCommon);
    }

    public void error(String message, LogTypeId logTypeId)
    {
        if (isInFilter(logTypeId, LogColor.eLC_ERROR))
        {
            if (self.mIsOutTimeStamp[(int)LogColor.eLC_ERROR.ordinal()])
            {
                message = String.format("{0}: {1}", UtilApi.getFormatTime(), message);
            }

            if (self.mIsOutStack[(int)LogColor.eLC_ERROR.ordinal()])
            {
                Throwable ex = new Throwable();
                String traceStr = ex.toString();
                message = String.format("{0}\n{1}", message, traceStr);
            }

            if (MThread.isMainThread())
            {
                self.logout(message, LogColor.eLC_ERROR);
            }
            else
            {
                self.asyncError(message);
            }
        }
    }

    // 多线程日志
    protected void asyncLog(String message)
    {
        mAsyncLogList.Add(message);
    }

    // 多线程日志
    protected void asyncWarn(String message)
    {
        self.mAsyncWarnList.Add(message);
    }

    // 多线程日志
    protected void asyncError(String message)
    {
        self.mAsyncErrorList.Add(message);
    }

    public void logout(String message)
    {
        self.logout(message, LogColor.eLC_LOG);
    }

    public void logout(String message, LogColor type)
    {
        if (MacroDef.THREAD_CALLCHECK)
        {
            MThread.needMainThread();
        }

        //foreach (LogDeviceBase logDevice in mLogDeviceList.list())
        int idx = 0;
        int len = self.mLogDeviceList.Count();
        LogDeviceBase logDevice = null;

        while (idx < len)
        {
            logDevice = self.mLogDeviceList.get(idx);
            logDevice.logout(message, type);

            ++idx;
        }
    }

    public void updateLog()
    {
        if (MacroDef.THREAD_CALLCHECK)
        {
            MThread.needMainThread();
        }

        while ((self.mTmpStr = mAsyncLogList.RemoveAt(0)) != "")
        {
            self.logout(mTmpStr, LogColor.eLC_LOG);
        }

        while ((self.mTmpStr = mAsyncWarnList.RemoveAt(0)) != "")
        {
            self.logout(mTmpStr, LogColor.eLC_WARN);
        }

        while ((self.mTmpStr = mAsyncErrorList.RemoveAt(0)) != "")
        {
            self.logout(mTmpStr, LogColor.eLC_ERROR);
        }
    }

    protected void closeDevice()
    {
        for(LogDeviceBase logDevice : mLogDeviceList.list())
        {
            logDevice.closeDevice();
        }
    }
}