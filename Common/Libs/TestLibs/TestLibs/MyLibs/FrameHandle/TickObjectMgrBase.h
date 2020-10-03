#import "MyLibs/DataStruct/MList.h"
#import "MyLibs/DelayHandle/DelayHandleMgrBase.h"
#import "MyLibs/DelayHandle/IDelayHandleItem.h"
#import "MyLibs/FrameHandle/ITickedObject.h"

// 每一帧执行的对象管理器
@interface TickObjectMgrBase : DelayHandleMgrBase <ITickedObject, IDelayHandleItem>
{
    @protected
    MList* mTickObjectList;
}

- (id) init;
- (void) dispose;
- (void) setClientDispose:(BOOL) isDispose;
- (BOOL) isClientDispose;
- (void) onTick:(float) delta;
- (void) onExecTick:(float) delta;
- (void) addObject:(GObject<IDelayHandleItem>*) tickObject;
- (void) addObject:(GObject<IDelayHandleItem>*) tickObject priority:(float) priority;
- (void) removeObject:(GObject<IDelayHandleItem>*) tickObject;

@end
