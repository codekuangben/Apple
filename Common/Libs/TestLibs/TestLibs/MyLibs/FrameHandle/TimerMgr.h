/**
* @brief 定时器管理器
*/

#import "MyLibs/DataStruct/MList.h"
#import "MyLibs/DelayHandle/DelayHandleMgrBase.h"
#import "MyLibs/DelayHandle/IDelayHandleItem.h"
#import "MyLibs/Tools/UtilSysLibsWrap.h"

@class TimerItemBase;

@interface TimerMgr : DelayHandleMgrBase
{
    @protected
    MList* mTimerList;     // 当前所有的定时器列表
}

- (id) init;
- (void) dispose;
- (void) addObject:(GObject<IDelayHandleItem>*) delayObject;
- (void) addObject:(GObject<IDelayHandleItem>*) delayObject priority:(float) priority;
- (void) removeObject:(GObject<IDelayHandleItem>*) delayObject;
- (void) addTimer:(TimerItemBase*) delayObject;
// 从 Lua 中添加定时器，这种定时器尽量整个定时器周期只与 Lua 通信一次
- (void) addTimer:(TimerItemBase*) delayObject priority:(float) priority;
- (void) removeTimer:(TimerItemBase*) timer;
- (void) Advance:(float) delta;

@end
