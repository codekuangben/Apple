#import "MyLibs/FrameHandle/TickMgr.h"

@class TimeInterval;

/**
 * @brief 逻辑心跳管理器
 */
@interface LogicTickMgr : TickMgr
{
@protected
    TimeInterval* mTimeInterval;
}

- (id) init;
- (void) onExecAdvance:(float) delta;

@end
