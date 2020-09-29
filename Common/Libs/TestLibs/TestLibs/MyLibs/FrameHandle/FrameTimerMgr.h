#import "MyLibs/DataStruct/MList.h"
#import "MyLibs/DelayHandle/DelayHandleMgrBase.h"
#import "MyLibs/DelayHandle/IDelayHandleItem.h"
#import "MyLibs/Tools/UtilApi.h"

/**
 * @brief 定时器管理器
 */
@interface FrameTimerMgr : DelayHandleMgrBase
{
    @protected
    MList<FrameTimerItem> mTimerList;     // 当前所有的定时器列表
}

- (id) init;
- (void) dispose;
- (void) addObject:(IDelayHandleItem*) delayObject;
- (void) addObject:(IDelayHandleItem*) delayObject priority:(float) priority;
- (void) removeObject:(IDelayHandleItem*) delayObject;
- (void) addFrameTimer:(FrameTimerItem) timer;
- (void) addFrameTimer:(FrameTimerItem*) timer  priority:(float) priority;
- (void) removeFrameTimer:(FrameTimerItem*) timer;
- (void) Advance:(float) delta;

@end