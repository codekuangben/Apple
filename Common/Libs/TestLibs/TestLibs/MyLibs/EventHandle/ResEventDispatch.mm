#import "ResEventDispatch.h"
#import "EventDispatch.h"

@implementation ResEventDispatch

- (id) init
{
    if(self = [super init])
    {
        
    }
    
    return self;
}

- ((void)) dispatchEvent: (IDispatchObject) dispatchObject
{
	[super dispatchEvent: dispatchObject];

	[self clearEventHandle];
}

@end