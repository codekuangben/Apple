#ifndef __EventDispatchFunctionObject_h
#define __EventDispatchFunctionObject_h

#import "IDelayHandleItem.h"

@interface EventDispatchFunctionObject : IDelayHandleItem
{
@public 
	bool mIsClientDispose;       // 是否释放了资源
    ICalleeObject* mThis;
    SEL mHandle;
	IMP mHandleImp;
	int mEventId;
}

@property bool mIsClientDispose;       	// 是否释放了资源
@property ICalleeObject* mThis;
@property SEL mHandle;					// 选择器
@property IMP mHandleImp;
@property int mEventId;

@end

#endif