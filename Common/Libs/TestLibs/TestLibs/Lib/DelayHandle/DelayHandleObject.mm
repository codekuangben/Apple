#import "DelayHandleObject.h"

@implementation DelayHandleObject

- ((void)) init
{
	if(self = [super init])
    {
        self.mDelayObject = null;
		self.mDelayParam = null;
    }
    
    return self;
}

@end