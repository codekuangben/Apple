/**
* @brief 心跳管理器
*/

#import "MyLibs/DataStruct/MList.h";
#import "MyLibs/DelayHandle/DelayHandleMgrBase.h";
#import "MyLibs/DelayHandle/IDelayHandleItem.h";
#import "MyLibs/EventHandle/ICalleeObjectNoRetNoParam.h";
#import "MyLibs/Tools/UtilSysLibsWarp.h";

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