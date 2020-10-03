#import "MyLibs/DataStruct/MDictionary.h"
#import "MyLibs/Base/GObject.h"

@class EventDispatch;
@class GObject;
@protocol ICalleeObject;
@protocol IDispatchObject;

@interface EventDispatchGroup : GObject
{
    @protected
    MDictionary* mGroupID2DispatchDic;
    BOOL mIsInLoop;       // 是否是在循环遍历中
}

- (id) init;
// 添加分发器
- (void) addEventDispatch:(int) groupID disp:(EventDispatch*) disp;
- (void) addEventHandle:(int) groupID pThis:(GObject<ICalleeObject>*) pThis handle:/*(GObject<IDispatchObject>*)*/(SEL) handle;
- (void) removeEventHandle:(int) groupID pThis:(GObject<ICalleeObject>*) pThis handle:/*(GObject<IDispatchObject>*)*/(SEL) handle;
- (void) dispatchEvent:(int) groupID dispatchObject:(GObject<IDispatchObject>*) dispatchObject;
- (void) clearAllEventHandle;
- (void) clearGroupEventHandle:(int) groupID;
- (BOOL) hasEventHandle:(int) groupID;

@end
