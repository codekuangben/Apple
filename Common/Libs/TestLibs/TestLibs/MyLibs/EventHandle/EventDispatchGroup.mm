#import "EventDispatchGroup.h"

import SDK.Lib.DataStruct.MDictionary;

@implementation EventDispatchGroup
{
    protected MDictionary<Integer, EventDispatch> mGroupID2DispatchDic;
    protected boolean mIsInLoop;       // 是否是在循环遍历中

    public EventDispatchGroup()
    {
        self.mGroupID2DispatchDic = new MDictionary<Integer, EventDispatch>();
        self.mIsInLoop = false;
    }

    // 添加分发器
    public (void) addEventDispatch((int) groupID, EventDispatch disp)
    {
        if (!self.mGroupID2DispatchDic.ContainsKey(groupID))
        {
            self.mGroupID2DispatchDic.set(groupID, disp);
        }
    }

    public (void) addEventHandle((int) groupID, ICalleeObject pThis, IDispatchObject handle)
    {
        // 如果没有就创建一个
        if (!self.mGroupID2DispatchDic.ContainsKey(groupID))
        {
            addEventDispatch(groupID, new EventDispatch());
        }

        self.mGroupID2DispatchDic.get(groupID).addEventHandle(pThis, handle);
    }

    public (void) removeEventHandle((int) groupID, ICalleeObject pThis, IDispatchObject handle)
    {
        if (self.mGroupID2DispatchDic.ContainsKey(groupID))
        {
            self.mGroupID2DispatchDic.get(groupID).removeEventHandle(pThis, handle);

            // 如果已经没有了
            if (!self.mGroupID2DispatchDic.get(groupID).hasEventHandle())
            {
                self.mGroupID2DispatchDic.Remove(groupID);
            }
        }
        else
        {

        }
    }

    public (void) dispatchEvent((int) groupID, IDispatchObject dispatchObject)
    {
        self.mIsInLoop = true;
        if (self.mGroupID2DispatchDic.ContainsKey(groupID))
        {
            self.mGroupID2DispatchDic.get(groupID).dispatchEvent(dispatchObject);
        }
        else
        {

        }
        self.mIsInLoop = false;
    }

    public (void) clearAllEventHandle()
    {
        if (!self.mIsInLoop)
        {
            for (EventDispatch dispatch : self.mGroupID2DispatchDic.getValues())
            {
                dispatch.clearEventHandle();
            }

            self.mGroupID2DispatchDic.Clear();
        }
        else
        {

        }
    }

    public (void) clearGroupEventHandle((int) groupID)
    {
        if (!self.mIsInLoop)
        {
            if (self.mGroupID2DispatchDic.ContainsKey(groupID))
            {
                self.mGroupID2DispatchDic.get(groupID).clearEventHandle();
                self.mGroupID2DispatchDic.Remove(groupID);
            }
            else
            {

            }
        }
        else
        {

        }
    }

    public boolean hasEventHandle((int) groupID)
    {
        if(self.mGroupID2DispatchDic.ContainsKey(groupID))
        {
            return self.mGroupID2DispatchDic.get(groupID).hasEventHandle();
        }

        return false;
    }
}

@end