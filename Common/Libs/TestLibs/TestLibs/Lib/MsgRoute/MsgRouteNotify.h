@

@interface MsgRouteNotify
{
    protected MList<MsgRouteDispHandle> mDispList;

    public MsgRouteNotify()
    {
        self.mDispList = new MList<MsgRouteDispHandle>();
    }

    public (void) addOneDisp(MsgRouteDispHandle disp)
    {
        if(!self.mDispList.Contains(disp))
        {
            self.mDispList.Add(disp);
        }
    }

    public (void) removeOneDisp(MsgRouteDispHandle disp)
    {
        if(self.mDispList.Contains(disp))
        {
            self.mDispList.Remove(disp);
        }
    }

    public (void) handleMsg(MsgRouteBase msg)
    {
        for(MsgRouteDispHandle item : self.mDispList.list())
        {
            item.handleMsg(msg);
        }

        //Ctx.mInstance.mPoolSys.deleteObj(msg);
    }
}