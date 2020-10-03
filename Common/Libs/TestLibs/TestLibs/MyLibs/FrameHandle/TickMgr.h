#import "MyLibs/DataStruct/MList.h"
#import "MyLibs/DelayHandle/DelayHandleMgrBase.h"
#import "MyLibs/DelayHandle/IDelayHandleItem.h"
#import "MyLibs/EventHandle/IListenerObject.h"
#import "MyLibs/Tools/UtilSysLibsWrap.h"
#import "MyLibs/FrameHandle/ITickedObject.h"
#import "MyLibs/Base/GObject.h"

/**
 * @brief 心跳管理器
 */

@interface TickMgr : DelayHandleMgrBase
{
    @protected
    MList* mTickList;
}

- (id) init;
- (void) dispose;
- (void) addTick:(GObject<ITickedObject>*) tickObj;
- (void) addTick:(GObject<ITickedObject>*) tickObj  priority:(float) priority;
- (void) addObject:(GObject<IDelayHandleItem>*) delayObject;
- (void) addObject:(GObject<IDelayHandleItem>*) delayObject priority:(float) priority;
- (void) removeTick:(GObject<ITickedObject>*) tickObj;
- (void) removeObject:(GObject<IDelayHandleItem>*) delayObject;
- (void) Advance:(float) delta;
- (void) onPreAdvance:(float) delta;
- (void) onExecAdvance:(float) delta;
- (void) onPostAdvance:(float) delta;

@end
