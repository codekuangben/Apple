#import "Lib/EventHandle/ICalleeObject.h";
#import "Lib/Tools/UtilApi.h";

@interface TimerFunctionObject
{
    public
    ICalleeObjectTimer* mHandle;
}

- (id) TimerFunctionObject;
- (void) setFuncObject:(ICalleeObjectTimer*) handle;
- (boolean) isValid;
- (boolean) isEqual:(ICalleeObject*) handle;
- (void) call:(TimerItemBase*) dispObj;
@end