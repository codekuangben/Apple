#import "MyLibs/EventHandle/ResEventDispatch.h"
#import "MyLibs/EventHandle/EventDispatch.h"

@implementation ResEventDispatch

- (id) init
{
    if(self = [super init])
    {
        
    }
    
    return self;
}

- (void) dispatchEvent: (GObject<IDispatchObject>*) dispatchObject
{
	[super dispatchEvent: dispatchObject];

	[self clearEventHandle];
}

@end