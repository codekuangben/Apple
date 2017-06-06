#ifndef __EventDispatch_h
#define __EventDispatch_h

#import "DelayHandleMgrBase.h"

/**
 * @brief 事件分发，之分发一类事件，不同类型的事件使用不同的事件分发
 * @brief 注意，事件分发缺点就是，可能被调用的对象已经释放，但是没有清掉事件处理器，结果造成空指针
 */
@interface EventDispatch : DelayHandleMgrBase
{
@protected
	int mEventId;
    MList<EventDispatchFunctionObject> mHandleList;
    int mUniqueId;       // 唯一 Id ，调试使用
}

@property int mEventId;
@property MList<EventDispatchFunctionObject> mHandleList;
@property int mUniqueId; 

@end

#endif