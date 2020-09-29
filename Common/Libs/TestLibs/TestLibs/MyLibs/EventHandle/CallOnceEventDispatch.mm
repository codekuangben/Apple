#import "MyLibs/EventHandle/CallOnceEventDispatch.h"
#import "MyLibs/EventHandle/EventDispatch.h"

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