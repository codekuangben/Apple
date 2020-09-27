#import "GObject.h"

@implementation GObject

- (id) init
{
    if(self = [super init])
    {
        mTypeId = @"GObject";
    }
    
    return self;
}


- getTypeId
{
    return self.mTypeId;
}

@end