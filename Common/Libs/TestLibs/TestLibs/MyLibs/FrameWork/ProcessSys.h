#import "MyLibs/Base/GObject.h"

/**
* @brief 系统循环
*/

@interface ProcessSys : GObject
{

}

- (id) init;
- (void) ProcessNextFrame;
- (void) Advance:(float) delta;
- (void) ProcessNextFixedFrame;
- (void) FixedAdvance:(float) delta;

@end
