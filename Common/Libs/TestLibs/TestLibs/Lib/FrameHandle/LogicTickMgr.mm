package SDK.Lib.FrameHandle;

/**
 * @brief 逻辑心跳管理器
 */
@implementation LogicTickMgr : TickMgr

- (id) init
{
    self.mTimeInterval = new TimeInterval();
}

- (void) onExecAdvance:(float) delta
{
    if(self.mTimeInterval.canExec(delta))
    {
        super.onExecAdvance(delta);
    }
}

@end