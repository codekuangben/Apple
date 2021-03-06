#import "MyLibs/FrameHandle/LogicTickMgr.h"

/**
 * @brief 逻辑心跳管理器
 */
@implementation LogicTickMgr

- (id) init
{
    self->mTimeInterval = [[TimeInterval alloc] init];
    return self;
}

- (void) onExecAdvance:(float) delta
{
    if([self->mTimeInterval canExec:delta])
    {
        [super onExecAdvance:delta];
    }
}

@end
