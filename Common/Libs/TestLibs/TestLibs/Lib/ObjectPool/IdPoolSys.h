package SDK.Lib.ObjectPool;

import SDK.Lib.DataStruct.MDictionary;
import SDK.Lib.DataStruct.MList;
import SDK.Lib.MsgRoute.IRecycle;

/**
 * @brief 有 Id 的缓存池
 */
public class IdPoolSys
{
    protected MDictionary<String, MList<SDK.Lib.MsgRoute.IRecycle>> mId2PoolDic;

    public IdPoolSys()
    {
        self.mId2PoolDic = new MDictionary<String, MList<IRecycle>>();
    }

    public void init()
    {

    }

    public void dispose()
    {

    }

    public IRecycle getObject(String id)
    {
        IRecycle ret = null;

        if (self.mId2PoolDic.ContainsKey(id))
        {
            if (self.mId2PoolDic.get(id).Count() > 0)
            {
                ret = self.mId2PoolDic.get(id).get(0);
                self.mId2PoolDic.get(id).RemoveAt(0);
            }
        }

        return ret;
    }

    public void deleteObj(String id, IRecycle obj)
    {
        if (!self.mId2PoolDic.ContainsKey(id))
        {
            self.mId2PoolDic.set(id, new MList<IRecycle>());
        }

        self.mId2PoolDic.get(id).Add(obj);
    }
}