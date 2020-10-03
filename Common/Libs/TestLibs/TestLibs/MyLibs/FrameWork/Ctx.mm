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
        mInstance = [[Ctx alloc] init];
    }
    return mInstance;
}

- (void) constructInit
{
    self->mMsgRouteNotify = [[MsgRouteNotify alloc] init];
    self->mCfg = [[Config alloc] init];

    self->mProcessSys = [[ProcessSys alloc] init];
    self->mTickMgr = [[TickMgr alloc] init];
    self->mFixedTickMgr = [[ FixedTickMgr alloc] init];
    self->mTimerMgr = [[TimerMgr alloc] init];
    self->mFrameTimerMgr = [[FrameTimerMgr alloc] init];

    self->mShareData = [[ShareData alloc] init];
    self->mEngineLoop = [[EngineLoop alloc] init];

    self->mGlobalDelegate = [[GlobalDelegate alloc] init];

    self->mLogicTickMgr = [[LogicTickMgr alloc] init];
    self->mSysMsgRoute = [[SysMsgRoute alloc] init];
    self->mSystemTimeData = [[SystemTimeData alloc] init];
    self->mSystemFrameData = [[SystemFrameData alloc] init];
}

- (void) logicInit
{
    [self->mTickMgr init];
    [self->mFixedTickMgr init];

    [self->mGlobalDelegate init];
    [self->mLogicTickMgr init];
    [self->mSysMsgRoute init];
    [self->mSystemTimeData init];

    [self->mSystemFrameData init];
}

- (void) init
{
    // 构造初始化
    [self constructInit];
    // 逻辑初始化，交叉引用的对象初始化
    [self logicInit];
}

- (void) dispose
{
    if (nil != self->mTickMgr)
    {
        [self->mTickMgr dispose];
        self->mTickMgr = nil;
    }
    if (nil != self->mFixedTickMgr)
    {
        [self->mFixedTickMgr dispose];
        self->mFixedTickMgr = nil;
    }

    if(nil != self->mLogicTickMgr)
    {
        [self->mLogicTickMgr dispose];
        self->mLogicTickMgr = nil;
    }
    if(nil != self->mSysMsgRoute)
    {
        [self->mSysMsgRoute dispose];
        self->mSysMsgRoute = nil;
    }
    if(nil != self->mSystemTimeData)
    {
        [self->mSystemTimeData dispose];
        self->mSystemTimeData = nil;
    }
    if(nil != self->mSystemFrameData)
    {
        [self->mSystemFrameData dispose];
        self->mSystemFrameData = nil;
    }
}

- (void) quitApp
{
    [self dispose];

    // 释放自己
    //mInstance = nil;
}

@end
