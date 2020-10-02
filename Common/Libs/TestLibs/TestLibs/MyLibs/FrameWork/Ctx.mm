#import "MyLibs/FrameWork/Ctx.h"

static Ctx* mInstance = nil;

@implementation Ctx

- (id) init
{

}

+ (Ctx*) ins
{
    if (mInstance == nil)
    {
        mInstance = new Ctx();
    }
    return mInstance;
}

- (void) constructInit
{
    self->mMsgRouteNotify = new MsgRouteNotify();
    self->mSystemSetting = new SystemSetting();
    self->mPoolSys = new PoolSys();
    self->mTaskQueue = new TaskQueue("TaskQueue");
    self->mTaskThreadPool = new TaskThreadPool();

    self->mCfg = new Config();
    self->mFactoryBuild = new FactoryBuild();

    self->mProcessSys = new ProcessSys();
    self->mTickMgr = new TickMgr();
    self->mFixedTickMgr = new FixedTickMgr();
    self->mTimerMgr = new TimerMgr();
    self->mFrameTimerMgr = new FrameTimerMgr();

    self->mShareData = new ShareData();
    self->mEngineLoop = new EngineLoop();
    self->mResizeMgr = new ResizeMgr();

    self->mLogSys = new LogSys();
    self->mGlobalDelegate = new GlobalDelegate();
    self->mIdPoolSys = new IdPoolSys();

    self->mLogicTickMgr = new LogicTickMgr();
    self->mSysMsgRoute = new SysMsgRoute("");
    self->mSystemTimeData = new SystemTimeData();
    self->mSystemFrameData = new SystemFrameData();
}

- (void) logicInit
{
    self->mLogSys.init();
    self->mTickMgr.init();
    self->mFixedTickMgr.init();

    self->mTaskQueue.mTaskThreadPool = self->mTaskThreadPool;
    self->mTaskThreadPool.initThreadPool(2, self->mTaskQueue);

    self->mGlobalDelegate.init();
    self->mResizeMgr.init();
    self->mIdPoolSys.init();
    self->mLogicTickMgr.init();
    self->mSysMsgRoute.init();
    self->mSystemTimeData.init();

    self->mSystemFrameData.init();

    self->addEventHandle();
}

- (void) init
{
    // 构造初始化
    constructInit();
    // 逻辑初始化，交叉引用的对象初始化
    logicInit();
}

- (void) dispose
{
    if (nil != self->mResizeMgr)
    {
        self->mResizeMgr.dispose();
        self->mResizeMgr = nil;
    }
    if (nil != self->mTickMgr)
    {
        self->mTickMgr.dispose();
        self->mTickMgr = nil;
    }
    if (nil != self->mFixedTickMgr)
    {
        self->mFixedTickMgr.dispose();
        self->mFixedTickMgr = nil;
    }

    // 关闭日志设备
    if (nil != self->mLogSys)
    {
        self->mLogSys.dispose();
        self->mLogSys = nil;
    }
    if(nil != self->mIdPoolSys)
    {
        self->mIdPoolSys.dispose();
        self->mIdPoolSys = nil;
    }
    if(nil != self->mLogicTickMgr)
    {
        self->mLogicTickMgr.dispose();
        self->mLogicTickMgr = nil;
    }
    if(nil != self->mSysMsgRoute)
    {
        self->mSysMsgRoute.dispose();
        self->mSysMsgRoute = nil;
    }
    if(nil != self->mSystemTimeData)
    {
        self->mSystemTimeData.dispose();
        self->mSystemTimeData = nil;
    }
    if(nil != self->mSystemFrameData)
    {
        self->mSystemFrameData.dispose();
        self->mSystemFrameData = nil;
    }
}

- (void) quitApp
{
    self->dispose();

    // 释放自己
    //mInstance = nil;
}

- (void) addEventHandle
{
    self->mTickMgr.addTick((ITickedObject)self->mResizeMgr, TickPriority.eTPResizeMgr);
}

@end
