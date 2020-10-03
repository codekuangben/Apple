#import "Module/AppFrame/AppFrame.h"
#import "MyLibs/FrameWork/Ctx.h"

@implementation AppFrame

- (id) init
{
    [Ctx ins];
    
    return self;
}

- (void) run
{
    [[Ctx ins] run];
}

@end