#import "MyLibs/EventHandle/ICalleeObject.h"
#import "MyLibs/FrameHandle/ICalleeObjectTimer.h"
#import "MyLibs/Tools/UtilSysLibsWrap.h"
#import "MyLibs/Base/GObject.h"

@interface TimerFunctionObject : GObject
{
@public
    ICalleeObjectTimer* mHandle;
}

- (id) TimerFunctionObject;
- (void) setFuncObject:(ICalleeObjectTimer*) handle;
- (BOOL) isValid;
- (BOOL) isEqual:(ICalleeObject*) handle;
- (void) call:(TimerItemBase*) dispObj;

@end
