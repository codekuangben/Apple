#import "MyLibs/FrameHandle/TickMgr.h"

/**
 * @brief 逻辑心跳管理器
 */
@interface LogicTickMgr : TickMgr
{
    @protected
    TimeInterval* mTimeInterval;
}

- (id) init
{
    self->mTimeInterval = new TimeInterval();
}

- (void) onExecAdvance:(float) delta
{
    if(self->mTimeInterval.canExec(delta))
    {
        super.onExecAdvance(delta);
    }
}

@end