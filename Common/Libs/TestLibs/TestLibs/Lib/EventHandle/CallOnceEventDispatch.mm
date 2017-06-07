#import "CallOnceEventDispatch.h"
#import "EventDispatch.h"

/**
 * @brief 一次事件分发，分发一次就清理
 */
@implementation CallOnceEventDispatch 
{
    public CallOnceEventDispatch()
    {

    }

    @Override
    public (void) dispatchEvent(IDispatchObject dispatchObject)
    {
        super.dispatchEvent(dispatchObject);

        self.clearEventHandle();
    }
}

@end