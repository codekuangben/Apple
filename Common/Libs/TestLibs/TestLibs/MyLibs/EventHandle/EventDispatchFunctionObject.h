#import "MyLibs/DelayHandle/IDelayHandleItem.h"

@interface EventDispatchFunctionObject : IDelayHandleItem
{
@public 
	BOOL mIsClientDispose;       // 是否释放了资源
    ICalleeObject* mThis;
    SEL mHandle;
	IMP mHandleImp;
	(int) mEventId;
}

@property BOOL mIsClientDispose;       	// 是否释放了资源
@property ICalleeObject* mThis;
@property SEL mHandle;					// 选择器
@property IMP mHandleImp;
@property int mEventId;

- (id) init: (int) baseUniqueId;
- (void) setFuncObject:(GObject<ICalleeObject>*) pThis, func:(SEL) func;
- (BOOL) isValid;
- (BOOL) isEqual:(GObject<ICalleeObject>*) pThis, handle:(SEL) handle;
- (void) call:(GObject<IDispatchObject>*) dispObj;
- (void) setClientDispose:(BOOL) isDispose;
- (BOOL) isClientDispose;

@end