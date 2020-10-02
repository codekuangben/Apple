#import <Foundation/Foundation.h>
#import "MyLibs/Base/GObject.h"
#import "MyLibs/FrameHandle/ITickedObject.h"

@interface TickProcessObject : GObject
{
@public
    GObject<ITickedObject>* mTickObject;
    float mPriority;
}

- (id) init;

@end
