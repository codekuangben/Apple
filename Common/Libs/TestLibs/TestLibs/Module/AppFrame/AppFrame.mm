#import "Module/AppFrame/AppFrame.h"
#import "MyLibs/FrameWork/Ctx.h"

@implementation AppFrame

- (void) init
{
    [Ctx ins];
}

- (void) run
{
    [[Ctx ins] run];
}

@end