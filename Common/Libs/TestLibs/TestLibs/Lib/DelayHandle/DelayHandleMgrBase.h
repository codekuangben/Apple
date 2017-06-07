#ifndef __DelayHandleMgrBase_h
#define __DelayHandleMgrBase_h

#import "GObject.h";
#import "MList.h";
#import "ICalleeObjectNoRetNoParam.h";
#import "LoopDepth.h";
#import "UtilApi.h";

/**
 * @brief 当需要管理的对象可能在遍历中间添加的时候，需要这个管理器
 */
@interface DelayHandleMgrBase : GObject , ICalleeObjectNoRetNoParam
{
    
}

@property (nonatomic, readwrite, retain) MList<DelayHandleObject> mDeferredAddQueue;
@property (nonatomic, readwrite, retain) MList<DelayHandleObject> mDeferredDelQueue;

@property (nonatomic, readwrite, retain) LoopDepth mLoopDepth;           // 是否在循环中，支持多层嵌套，就是循环中再次调用循环

- (id) init;
- ((void)) dealloc;
- ((void)) dispose;
- ((void)) addObject: (IDelayHandleItem) delayObject;
- ((void)) addObject: (IDelayHandleItem) delayObject priority: (float) priority;
- ((void)) removeObject: (IDelayHandleItem) delayObject);

// 只有没有添加到列表中的才能添加
- (bool) existAddList: (IDelayHandleItem) delayObject;
// 只有没有添加到列表中的才能添加
- (bool) existDelList: (IDelayHandleItem) delayObject;
// 从延迟添加列表删除一个 Item
- ((void)) delFromDelayAddList: (IDelayHandleItem) delayObject;
// 从延迟删除列表删除一个 Item
- ((void)) delFromDelayDelList: (IDelayHandleItem) delayObject;
- ((void)) processDelayObjects;
- ((void)) call;

@end

#endif