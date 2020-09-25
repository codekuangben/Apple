#import "SDK/Lib/FrameHandle.h"

@interface FixedTickMgr : TickMgr
{
    public FixedTickMgr()
    {

    }

    @Override
    protected (void) onExecAdvance(float delta)
    {
        super.onExecAdvance(delta);
    }
}