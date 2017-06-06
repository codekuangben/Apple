package SDK.Lib.FrameWork;

import SDK.Lib.FrameHandle.FixedTickMgr;
import SDK.Lib.FrameHandle.FrameTimerMgr;
import SDK.Lib.FrameHandle.ITickedObject;
import SDK.Lib.FrameHandle.LogicTickMgr;
import SDK.Lib.FrameHandle.ResizeMgr;
import SDK.Lib.FrameHandle.SystemFrameData;
import SDK.Lib.FrameHandle.SystemTimeData;
import SDK.Lib.FrameHandle.TickMgr;
import SDK.Lib.FrameHandle.TickPriority;
import SDK.Lib.FrameHandle.TimerMgr;
import SDK.Lib.Log.LogSys;
import SDK.Lib.MsgRoute.MsgRouteNotify;
import SDK.Lib.MsgRoute.SysMsgRoute;
import SDK.Lib.ObjectPool.IdPoolSys;
import SDK.Lib.ObjectPool.PoolSys;
import SDK.Lib.Task.TaskQueue;
import SDK.Lib.Task.TaskThreadPool;

/**
 * @brief 全局数据区
 */
public class Ctx
{
    static public Ctx mInstance;

    public Config mCfg;                       // 整体配置文件
    public LogSys mLogSys;                    // 日志系统

    public TickMgr mTickMgr;                  // 心跳管理器
    public FixedTickMgr mFixedTickMgr;             // 固定间隔心跳管理器
    public LogicTickMgr mLogicTickMgr;        // 逻辑心跳管理器
    public ProcessSys mProcessSys;            // 游戏处理系统

    public TimerMgr mTimerMgr;                // 定时器系统
    public FrameTimerMgr mFrameTimerMgr;      // 定时器系统
    public ResizeMgr mResizeMgr;              // 窗口大小修改管理器
    public EngineLoop mEngineLoop;            // 引擎循环

    public ShareData mShareData;               // 共享数据系统
    public MsgRouteNotify mMsgRouteNotify;     // RouteMsg 客户端自己消息流程
    //public MFileSys mFileSys;                  // 文件系统
    public FactoryBuild mFactoryBuild;         // 生成各种内容，上层只用接口

    public SystemSetting mSystemSetting;
    public PoolSys mPoolSys;
    public TaskQueue mTaskQueue;
    public TaskThreadPool mTaskThreadPool;

    public GlobalDelegate mGlobalDelegate;
    public IdPoolSys mIdPoolSys;
    public SysMsgRoute mSysMsgRoute;
    public SystemTimeData mSystemTimeData;
    public SystemFrameData mSystemFrameData;

    public Ctx()
    {

    }

    public static Ctx instance()
    {
        if (mInstance == null)
        {
            mInstance = new Ctx();
        }
        return mInstance;
    }

    protected void constructInit()
    {
        self.mMsgRouteNotify = new MsgRouteNotify();
        self.mSystemSetting = new SystemSetting();
        self.mPoolSys = new PoolSys();
        self.mTaskQueue = new TaskQueue("TaskQueue");
        self.mTaskThreadPool = new TaskThreadPool();

        self.mCfg = new Config();
        self.mFactoryBuild = new FactoryBuild();

        self.mProcessSys = new ProcessSys();
        self.mTickMgr = new TickMgr();
        self.mFixedTickMgr = new FixedTickMgr();
        self.mTimerMgr = new TimerMgr();
        self.mFrameTimerMgr = new FrameTimerMgr();

        self.mShareData = new ShareData();
        self.mEngineLoop = new EngineLoop();
        self.mResizeMgr = new ResizeMgr();

        self.mLogSys = new LogSys();
        self.mGlobalDelegate = new GlobalDelegate();
        self.mIdPoolSys = new IdPoolSys();

        self.mLogicTickMgr = new LogicTickMgr();
        self.mSysMsgRoute = new SysMsgRoute("");
        self.mSystemTimeData = new SystemTimeData();
        self.mSystemFrameData = new SystemFrameData();
    }

    public void logicInit()
    {
        self.mLogSys.init();
        self.mTickMgr.init();
        self.mFixedTickMgr.init();

        self.mTaskQueue.mTaskThreadPool = self.mTaskThreadPool;
        self.mTaskThreadPool.initThreadPool(2, self.mTaskQueue);

        self.mGlobalDelegate.init();
        self.mResizeMgr.init();
        self.mIdPoolSys.init();
        self.mLogicTickMgr.init();
        self.mSysMsgRoute.init();
        self.mSystemTimeData.init();

        self.mSystemFrameData.init();

        self.addEventHandle();
    }

    public void init()
    {
        // 构造初始化
        constructInit();
        // 逻辑初始化，交叉引用的对象初始化
        logicInit();
    }

    public void dispose()
    {
        if (null != self.mResizeMgr)
        {
            self.mResizeMgr.dispose();
            self.mResizeMgr = null;
        }
        if (null != self.mTickMgr)
        {
            self.mTickMgr.dispose();
            self.mTickMgr = null;
        }
        if (null != self.mFixedTickMgr)
        {
            self.mFixedTickMgr.dispose();
            self.mFixedTickMgr = null;
        }

        // 关闭日志设备
        if (null != self.mLogSys)
        {
            self.mLogSys.dispose();
            self.mLogSys = null;
        }
        if(null != self.mIdPoolSys)
        {
            self.mIdPoolSys.dispose();
            self.mIdPoolSys = null;
        }
        if(null != self.mLogicTickMgr)
        {
            self.mLogicTickMgr.dispose();
            self.mLogicTickMgr = null;
        }
        if(null != self.mSysMsgRoute)
        {
            self.mSysMsgRoute.dispose();
            self.mSysMsgRoute = null;
        }
        if(null != self.mSystemTimeData)
        {
            self.mSystemTimeData.dispose();
            self.mSystemTimeData = null;
        }
        if(null != self.mSystemFrameData)
        {
            self.mSystemFrameData.dispose();
            self.mSystemFrameData = null;
        }
    }

    public void quitApp()
    {
        self.dispose();

        // 释放自己
        //mInstance = null;
    }

    protected void addEventHandle()
    {
        self.mTickMgr.addTick((ITickedObject)self.mResizeMgr, TickPriority.eTPResizeMgr);
    }
}