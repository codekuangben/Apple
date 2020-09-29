#include "MyLibs/FrameHandle/TickMgr.h"

@implementation FixedTickMgr

- (id) init()
{
    if(self = [super init])
    {
        
    }
    
    return self;
}

- (void) onExecAdvance:(float) delta
{
    [super onExecAdvance:delta];
}

@end
