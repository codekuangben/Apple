#import "MyLibs/Base/GObject.h"
#import "MyLibs/DataStruct/MList.h"
#import "MyLibs/EventHandle/IListenerObject.h"
#import "MyLibs/FrameHandle/LoopDepth.h"
#import "MyLibs/Tools/UtilSysLibsWrap.h"
#include "MyLibs/DelayHandle/IDelayHandleItem.h"

/**
 * @brief 当需要管理的对象可能在遍历中间添加的时候，需要这个管理器
 */
@interface DelayHandleMgrBase : GObject <IListenerObject>
{
@public
    MList* mDeferredAddQueue;
    MList* mDeferredDelQueue;

    LoopDepth* mLoopDepth;           // 是否在循环中，支持多层嵌套，就是循环中再次调用循环
}

/*
@property (nonatomic, readwrite, retain) MList<DelayHandleObject> mDeferredAddQueue;
@property (nonatomic, readwrite, retain) MList<DelayHandleObject> mDeferredDelQueue;

@property (nonatomic, readwrite, retain) LoopDepth mLoopDepth;           // 是否在循环中，支持多层嵌套，就是循环中再次调用循环
 */

- (id) init;
- (void) dealloc;
- (void) dispose;
- (void) addObject: (GObject<IDelayHandleItem>*) delayObject;
- (void) addObject: (GObject<IDelayHandleItem>*) delayObject priority: (float) priority;
- (void) removeObject: (GObject<IDelayHandleItem>*) delayObject;

// 只有没有添加到列表中的才能添加
- (BOOL) existAddList: (GObject<IDelayHandleItem>*) delayObject;
// 只有没有添加到列表中的才能添加
- (BOOL) existDelList: (GObject<IDelayHandleItem>*) delayObject;
// 从延迟添加列表删除一个 Item
- (void) delFromDelayAddList: (GObject<IDelayHandleItem>*) delayObject;
// 从延迟删除列表删除一个 Item
- (void) delFromDelayDelList: (GObject<IDelayHandleItem>*) delayObject;
- (void) processDelayObjects;
- (void) call;

@end
