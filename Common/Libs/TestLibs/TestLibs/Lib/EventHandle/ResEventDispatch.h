#ifndef __EventDispatchGroup_h
#define __EventDispatchGroup_h

#import "EventDispatch.h"

@interface ResEventDispatch : EventDispatch
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

#endif