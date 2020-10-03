#import "MyLibs/DelayHandle/IDelayHandleItem.h"
#import "MyLibs/Base/GObject.h"
#import "MyLibs/EventHandle/IListenerObject.h"

@interface EventDispatchFunctionObject : GObject <IDelayHandleItem>
{
@public 
	BOOL mIsClientDispose;       // 是否释放了资源
    GObject<IListenerObject>* mEventListener;
    SEL mEventHandle;
	IMP mHandleImp;
	int mEventId;
}

/*
@property BOOL mIsClientDispose;       	// 是否释放了资源
@property IListenerObject* mEventListener;
@property SEL mEventHandle;					// 选择器
@property IMP mHandleImp;
@property int mEventId;
*/

- (id) init: (int) baseUniqueId;
- (void) setFuncObject:(GObject<IListenerObject>*) eventListener eventHandle:(SEL) eventHandle;
- (BOOL) isValid;
- (BOOL) isEqual:(GObject<IListenerObject>*) eventListener eventHandle:(SEL) eventHandle;
- (void) call:(GObject<IDispatchObject>*) dispatchObject;
- (void) setClientDispose:(BOOL) isDispose;
- (BOOL) isClientDispose;

@end
