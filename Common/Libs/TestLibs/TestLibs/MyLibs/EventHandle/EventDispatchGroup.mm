#import "MyLibs/EventHandle/EventDispatchGroup.h"

@implementation EventDispatchGroup

- (id) init
{
    self->mGroupID2DispatchDic = new MDictionary<Integer, EventDispatch>();
    self->mIsInLoop = false;
}

// 添加分发器
- (void) addEventDispatch:(int) groupID disp:(EventDispatch*) disp
{
    if (!self->mGroupID2DispatchDic.ContainsKey(groupID))
    {
        self->mGroupID2DispatchDic.set(groupID, disp);
    }
}

- (void) addEventHandle:(int) groupID pThis:(ICalleeObject*) pThis handle:(IDispatchObject*) handle
{
    // 如果没有就创建一个
    if (!self->mGroupID2DispatchDic.ContainsKey(groupID))
    {
        addEventDispatch(groupID, new EventDispatch());
    }

    self->mGroupID2DispatchDic.get(groupID).addEventHandle(pThis, handle);
}

- (void) removeEventHandle:(int) groupID pThis:(ICalleeObject*) pThis handle:(IDispatchObject*) handle
{
    if (self->mGroupID2DispatchDic.ContainsKey(groupID))
    {
        self->mGroupID2DispatchDic.get(groupID).removeEventHandle(pThis, handle);

        // 如果已经没有了
        if (!self->mGroupID2DispatchDic.get(groupID).hasEventHandle())
        {
            self->mGroupID2DispatchDic.Remove(groupID);
        }
    }
    else
    {

    }
}

- (void) dispatchEvent:(int) groupID dispatchObject:(IDispatchObject*) dispatchObject
{
    self->mIsInLoop = true;
    if (self->mGroupID2DispatchDic.ContainsKey(groupID))
    {
        self->mGroupID2DispatchDic.get(groupID).dispatchEvent(dispatchObject);
    }
    else
    {

    }
    self->mIsInLoop = false;
}

- (void) clearAllEventHandle
{
    if (!self->mIsInLoop)
    {
        for (EventDispatch dispatch : self->mGroupID2DispatchDic.getValues())
        {
            dispatch.clearEventHandle();
        }

        self->mGroupID2DispatchDic.Clear();
    }
    else
    {

    }
}

- (void) clearGroupEventHandle:(int) groupID
{
    if (!self->mIsInLoop)
    {
        if (self->mGroupID2DispatchDic.ContainsKey(groupID))
        {
            self->mGroupID2DispatchDic.get(groupID).clearEventHandle();
            self->mGroupID2DispatchDic.Remove(groupID);
        }
        else
        {

        }
    }
    else
    {

    }
}

- (BOOL) hasEventHandle:(int) groupID
{
    if(self->mGroupID2DispatchDic.ContainsKey(groupID))
    {
        return self->mGroupID2DispatchDic.get(groupID).hasEventHandle();
    }

    return false;
}

@end