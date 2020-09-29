#import "MyLibs/FrameHandle/TickMgr.h"

@interface FixedTickMgr : TickMgr
{
    
}

- (id) init;
- (void) onExecAdvance:(float) delta;

@end