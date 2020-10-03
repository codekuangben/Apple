#import "MyLibs/EventHandle/IListenerObject.h"
#import "MyLibs/FrameHandle/ICalleeObjectTimer.h"
#import "MyLibs/Tools/UtilSysLibsWrap.h"
#import "MyLibs/Base/GObject.h"

@class TimerItemBase;

@interface TimerFunctionObject : GObject
{
@public
    GObject<ICalleeObjectTimer>* mEventHandle;
}

- (id) TimerFunctionObject;
- (void) setFuncObject:(GObject<ICalleeObjectTimer>*) eventHandle;
- (BOOL) isValid;
- (BOOL) isEqual:(GObject<IListenerObject>*) eventHandle;
- (void) call:(TimerItemBase*) dispatchObject;

@end
