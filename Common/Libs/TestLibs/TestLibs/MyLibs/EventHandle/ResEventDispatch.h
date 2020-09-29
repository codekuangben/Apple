#ifndef __EventDispatchGroup_h
#define __EventDispatchGroup_h

#import "EventDispatch.h"

@interface ResEventDispatch : EventDispatch
{
    
}

- (id) init;
- ((void)) dispatchEvent: (IDispatchObject) dispatchObject;

@end

#endif