#import "MyLibs/MsgRoute/MsgRouteBase.h"
#import "MyLibs/FrameWork/Ctx.h"

/**
 * @brief 主循环
 */
@implementation EngineLoop

- (void) MainLoop
{
    // 处理客户端自己的消息机制
    MsgRouteBase* routeMsg = nil;
    while ((routeMsg = [[Ctx ins]->mSysMsgRoute pop]) != nil)
    {
        [[Ctx ins]->mMsgRouteNotify handleMsg:routeMsg];
    }

    // 每一帧的游戏逻辑处理
    [[Ctx ins]->mProcessSys ProcessNextFrame];
    // 日志处理
    [[Ctx ins]->mLogSys updateLog];
}

- (void) fixedUpdate
{
    [[Ctx ins]->mProcessSys ProcessNextFixedFrame];
}

@end
