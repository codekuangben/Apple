package SDK.Lib.FrameHandle;

import SDK.Lib.DataStruct.MList;
import SDK.Lib.DelayHandle.DelayHandleMgrBase;
import SDK.Lib.DelayHandle.IDelayHandleItem;

// 每一帧执行的对象管理器
@interface TickObjectMgrBase : DelayHandleMgrBase implements ITickedObject, IDelayHandleItem
{
    @protected
    MList<ITickedObject> mTickObjectList;
}

- (id) init;
- (void) dispose;
- (void) setClientDispose:(BOOL) isDispose;
- (BOOL) isClientDispose;
- (void) onTick:(float) delta;
- (void) onExecTick:(float) delta;
- (void) addObject:(IDelayHandleItem*) tickObject;
- (void) addObject:(IDelayHandleItem*) tickObject priority:(float) priority;
- (void) removeObject:(IDelayHandleItem*) tickObject;

@end