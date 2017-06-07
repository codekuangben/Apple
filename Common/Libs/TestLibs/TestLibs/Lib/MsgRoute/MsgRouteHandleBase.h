package SDK.Lib.MsgRoute;

import SDK.Lib.Core.GObject;
import SDK.Lib.DataStruct.MDictionary;
import SDK.Lib.EventHandle.AddOnceEventDispatch;
import SDK.Lib.EventHandle.ICalleeObject;
import SDK.Lib.EventHandle.IDispatchObject;

public class MsgRouteHandleBase extends GObject implements ICalleeObject
{
    public MDictionary<Integer, AddOnceEventDispatch> mId2HandleDic;

    public MsgRouteHandleBase()
    {
        self.mTypeId = "MsgRouteHandleBase";

        self.mId2HandleDic = new MDictionary<Integer, AddOnceEventDispatch>();
    }

    public (void) addMsgRouteHandle(MsgRouteID msgRouteID, IDispatchObject handle)
    {
        if(!self.mId2HandleDic.ContainsKey(msgRouteID.ordinal()))
        {
            self.mId2HandleDic.set(msgRouteID.ordinal(), new AddOnceEventDispatch());
        }

        self.mId2HandleDic.get(msgRouteID.ordinal()).addEventHandle(null, handle);
    }

    public (void) removeMsgRouteHandle(MsgRouteID msgRouteID, IDispatchObject handle)
    {
        if (self.mId2HandleDic.ContainsKey(msgRouteID.ordinal()))
        {
            self.mId2HandleDic.get(msgRouteID.ordinal()).removeEventHandle(null, handle);
        }
    }

    public (void) handleMsg(IDispatchObject dispObj)
    {
        MsgRouteBase msg = (MsgRouteBase)dispObj;

        if (self.mId2HandleDic.ContainsKey(msg.mMsgID.ordinal()))
        {
            self.mId2HandleDic.get(msg.mMsgID.ordinal()).dispatchEvent(msg);
        }
        else
        {

        }
    }

    public (void) call(IDispatchObject dispObj)
    {

    }
}