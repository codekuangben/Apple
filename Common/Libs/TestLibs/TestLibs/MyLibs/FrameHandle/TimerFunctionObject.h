#import "Lib/EventHandle/ICalleeObject.h";
#import "Lib/Tools/UtilSysLibsWrap.h";

@interface TimerFunctionObject
{
    public
    ICalleeObjectTimer* mHandle;
}

- (id) TimerFunctionObject;
- (void) setFuncObject:(ICalleeObjectTimer*) handle;
- (BOOL) isValid;
- (BOOL) isEqual:(ICalleeObject*) handle;
- (void) call:(TimerItemBase*) dispObj;
@end