/**
* @brief 心跳管理器
*/

@import SDK.Lib.DataStruct.MList;
@import SDK.Lib.DelayHandle.DelayHandleMgrBase;
@import SDK.Lib.DelayHandle.IDelayHandleItem;
@import SDK.Lib.EventHandle.ICalleeObjectNoRetNoParam;
@import SDK.Lib.Tools.UtilApi;

@interface TickMgr : DelayHandleMgrBase
{
    @protected
    MList<TickProcessObject> mTickList;
}

- (id) init
{
    self.mTickList = new MList<TickProcessObject>();
}

- (void) init;
- (void) dispose;
- (void) addTick:(ITickedObject*) tickObj;
- (void) addTick:(ITickedObject*) tickObj  priority:(float) priority;
- (void) addObject:(IDelayHandleItem*) delayObject;
- (void) addObject:(IDelayHandleItem*) delayObject, priority:(float) priority;
- (void) removeTick:(ITickedObject*) tickObj;
- (void) removeObject:(IDelayHandleItem*) delayObject;
- (void) Advance:(float) delta;
- (void) onPreAdvance:(float) delta;
- (void) onExecAdvance:(float) delta;
- (void) onPostAdvance:(float) delta;

@end