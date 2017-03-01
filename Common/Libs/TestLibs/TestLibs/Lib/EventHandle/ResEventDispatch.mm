#import "ResEventDispatch.h"
#import "EventDispatch.h"

@implementation ResEventDispatch
{
    public ResEventDispatch()
    {

    }

    @Override
    public void dispatchEvent(IDispatchObject dispatchObject)
    {
        super.dispatchEvent(dispatchObject);

        this.clearEventHandle();
    }
}

@end