#import "Lib/FrameHandle.h"

@interface FixedTickMgr : TickMgr
{
    
}

- (id) init;
- (void) onExecAdvance:(float) delta;

@end