#import "MyLibs/MsgRoute/MsgRouteBase.h";

/**
 * @brief 主循环
 */
@implementation EngineLoop

- (void) MainLoop
{
    // 处理客户端自己的消息机制
    MsgRouteBase* routeMsg = nil;
    while ((routeMsg = [Ctx.mInstance.mSysMsgRoute pop] != nil)
    {
        [Ctx.mInstance.mMsgRouteNotify handleMsg:routeMsg];
    }

    // 每一帧的游戏逻辑处理
    [Ctx.mInstance.mProcessSys ProcessNextFrame];
    // 日志处理
    [Ctx.mInstance.mLogSys updateLog];
}

- (void) fixedUpdate
{
    [Ctx.mInstance.mProcessSys ProcessNextFixedFrame];
}

@end