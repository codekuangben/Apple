#import "MyLibs/DataStruct/MDictionary.h"

@interface EventDispatchGroup
{
    @protected
    MDictionary<Integer, EventDispatch> mGroupID2DispatchDic;
    BOOL mIsInLoop;       // 是否是在循环遍历中
}

- (id) init;
// 添加分发器
- (void) addEventDispatch:(int) groupID disp:(EventDispatch*) disp;
- (void) addEventHandle:(int) groupID pThis:(ICalleeObject*) pThis handle:(IDispatchObject*) handle;
- (void) removeEventHandle:(int) groupID pThis:(ICalleeObject*) pThis handle:(IDispatchObject*) handle;
- (void) dispatchEvent:(int) groupID dispatchObject:(IDispatchObject*) dispatchObject;
- (void) clearAllEventHandle;
- (void) clearGroupEventHandle:(int) groupID;
- (BOOL) hasEventHandle:(int) groupID;

@end