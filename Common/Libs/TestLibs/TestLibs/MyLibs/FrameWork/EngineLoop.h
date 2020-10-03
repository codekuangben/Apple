#import "MyLibs/MsgRoute/MsgRouteBase.h"
#import "MyLibs/Base/GObject.h"

/**
 * @brief 主循环
 */
@interface EngineLoop : GObject
{
    
}

- (void) MainLoop;
- (void) fixedUpdate;

@end
