#import "MyLibs/DelayHandle/DelayHandleMgrBase.h"

/**
 * @brief 事件分发，之分发一类事件，不同类型的事件使用不同的事件分发
 * @brief 注意，事件分发缺点就是，可能被调用的对象已经释放，但是没有清掉事件处理器，结果造成空指针
 */
@interface EventDispatch : DelayHandleMgrBase
{
@protected
	(int) mEventId;
    MList<EventDispatchFunctionObject> mHandleList;
    (int) mUniqueId;       // 唯一 Id ，调试使用
}

@property (int) mEventId;
@property MList<EventDispatchFunctionObject> mHandleList;
@property (int) mUniqueId; 

- (id) init;
- (id) init:(int)eventId;
- (void) dispose;
- (MList*) getHandleList;
- (int) getUniqueId;
- (void) setUniqueId:(int) value;
- (void) addDispatch:(EventDispatchFunctionObject*) dispatch;
- (void) removeDispatch:(EventDispatchFunctionObject*) dispatch;
// 相同的函数只能增加一次，Lua ，Python 这些语言不支持同时存在几个相同名字的函数，只支持参数可以赋值，因此不单独提供同一个名字不同参数的接口了
- (void) addEventHandle:(ICalleeObject*) pThis, handle:(IDispatchObject*) handle;
- (void) removeEventHandle:(ICalleeObject*) pThis, handle:(IDispatchObject*) handle;
- (void) addObject:(IDelayHandleItem*) delayObject;
- (void) addObject:(IDelayHandleItem*) delayObject, priority:(float) priority;
- (void) removeObject:(IDelayHandleItem*) delayObject;
- (void) dispatchEvent:(IDispatchObject*) dispatchObject;
- (void) clearEventHandle;
// 这个判断说明相同的函数只能加一次，但是如果不同资源使用相同的回调函数就会有问题，但是这个判断可以保证只添加一次函数，值得，因此不同资源需要不同回调函数
- (BOOL) isExistEventHandle:(ICalleeObject*) pThis, handle:(IDispatchObject*) handle;
- (void) copyFrom:(EventDispatch*) rhv;
- (BOOL) hasEventHandle;
- (int) getEventHandle;

@end