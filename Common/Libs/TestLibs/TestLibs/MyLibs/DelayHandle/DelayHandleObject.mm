#import "MyLibs/DelayHandle/DelayHandleObject.h"

@implementation DelayHandleObject

- (id) init
{
	if(self = [super init])
    {
        self.mDelayObject = nil;
        self.mDelayParam = nil;
    }
    
    return self;
}

@end
