#import "MyLibs/EventHandle/ICalleeObject.h"
#import "MyLibs/FrameHandle/ICalleeObjectTimer.h"
#import "MyLibs/Tools/UtilSysLibsWrap.h"
#import "MyLibs/Base/GObject.h"

@class TimerItemBase;

@interface TimerFunctionObject : GObject
{
@public
    GObject<ICalleeObjectTimer>* mHandle;
}

- (id) TimerFunctionObject;
- (void) setFuncObject:(GObject<ICalleeObjectTimer>*) handle;
- (BOOL) isValid;
- (BOOL) isEqual:(GObject<ICalleeObject>*) handle;
- (void) call:(TimerItemBase*) dispObj;

@end
