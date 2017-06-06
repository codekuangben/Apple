package SDK.Lib.MsgRoute;

import SDK.Lib.EventHandle.EventDispatchGroup;
import SDK.Lib.EventHandle.IDispatchObject;
import SDK.Lib.FrameWork.Ctx;

public class MsgRouteDispHandle
{
    protected EventDispatchGroup mEventDispatchGroup;

    public MsgRouteDispHandle()
    {
        self.mEventDispatchGroup = new EventDispatchGroup();
    }

    public void addRouteHandle(int evtId, MsgRouteHandleBase pThis, IDispatchObject handle)
    {
        self.mEventDispatchGroup.addEventHandle(evtId, pThis, handle);
    }

    public void removeRouteHandle(int evtId, MsgRouteHandleBase pThis, IDispatchObject handle)
    {
        self.mEventDispatchGroup.removeEventHandle(evtId, pThis, handle);
    }

    public void handleMsg(MsgRouteBase msg)
    {
        String textStr = "";

        if(self.mEventDispatchGroup.hasEventHandle(msg.mMsgType.ordinal()))
        {
            self.mEventDispatchGroup.dispatchEvent(msg.mMsgType.ordinal(), msg);
        }
        else
        {

        }
    }
}