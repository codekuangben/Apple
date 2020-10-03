#import <Foundation/Foundation.h>
#import "MyLibs/FrameHandle/FixedTickMgr.h"
#import "MyLibs/FrameHandle/FrameTimerMgr.h"
#import "MyLibs/FrameHandle/ITickedObject.h"
#import "MyLibs/FrameHandle/LogicTickMgr.h"
#import "MyLibs/FrameHandle/SystemFrameData.h"
#import "MyLibs/FrameHandle/SystemTimeData.h"
#import "MyLibs/FrameHandle/TickMgr.h"
#import "MyLibs/FrameHandle/TickPriority.h"
#import "MyLibs/FrameHandle/TimerMgr.h"
#import "MyLibs/MsgRoute/MsgRouteNotify.h"
#import "MyLibs/MsgRoute/SysMsgRoute.h"
#import "MyLibs/FrameWork/Config.h"
#import "MyLibs/FrameWork/ProcessSys.h"
#import "MyLibs/FrameWork/EngineLoop.h"


/**
 * @brief 全局数据区
 */
@interface Ctx : NSObject
{
@public
    Config* mCfg;                       // 整体配置文件

    TickMgr* mTickMgr;                  // 心跳管理器
    FixedTickMgr* mFixedTickMgr;             // 固定间隔心跳管理器
    LogicTickMgr* mLogicTickMgr;        // 逻辑心跳管理器
    ProcessSys* mProcessSys;            // 游戏处理系统

    TimerMgr* mTimerMgr;                // 定时器系统
    FrameTimerMgr* mFrameTimerMgr;      // 定时器系统
    EngineLoop* mEngineLoop;            // 引擎循环

    ShareData* mShareData;               // 共享数据系统
    MsgRouteNotify* mMsgRouteNotify;     // RouteMsg 客户端自己消息流程

    SystemSetting* mSystemSetting;
    GlobalDelegate* mGlobalDelegate;
    SysMsgRoute* mSysMsgRoute;
    SystemTimeData* mSystemTimeData;
    SystemFrameData* mSystemFrameData;
}

- (id) init;
+ (Ctx*) ins;
- (void) constructInit;
- (void) logicInit;
- (void) init;
- (void) dispose;
- (void) quitApp;
- (void) addEventHandle;
@end
