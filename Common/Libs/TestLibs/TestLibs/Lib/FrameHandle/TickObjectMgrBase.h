package SDK.Lib.FrameHandle;

import SDK.Lib.DataStruct.MList;
import SDK.Lib.DelayHandle.DelayHandleMgrBase;
import SDK.Lib.DelayHandle.IDelayHandleItem;

// 每一帧执行的对象管理器
@interface TickObjectMgrBase : DelayHandleMgrBase implements ITickedObject, IDelayHandleItem
{
    protected MList<ITickedObject> mTickObjectList;

    public TickObjectMgrBase()
    {
        self.mTickObjectList = new MList<ITickedObject>();
    }

    @Override
    public (void) init()
    {

    }

    @Override
    public (void) dispose()
    {

    }

    public (void) setClientDispose(boolean isDispose)
    {

    }

    public boolean isClientDispose()
    {
        return false;
    }

    public (void) onTick(float delta)
    {
        self.mLoopDepth.incDepth();

        self.onExecTick(delta);

        self.mLoopDepth.decDepth();
    }

    protected (void) onExecTick(float delta)
    {
        (int) idx = 0;
        (int) count = self.mTickObjectList.Count();
        ITickedObject tickObject = null;

        while (idx < count)
        {
            tickObject = self.mTickObjectList.get(idx);

            if (!((IDelayHandleItem)tickObject).isClientDispose())
            {
                tickObject.onTick(delta);
            }

            ++idx;
        }
    }

    @Override
    protected (void) addObject(IDelayHandleItem tickObject)
    {
        self.addObject(tickObject, 0);
    }

    @Override
    protected (void) addObject(IDelayHandleItem tickObject, float priority)
    {
        if (self.mLoopDepth.isInDepth())
        {
            super.addObject(tickObject);
        }
        else
        {
            if (self.mTickObjectList.IndexOf((ITickedObject)tickObject) == -1)
            {
                self.mTickObjectList.Add((ITickedObject)tickObject);
            }
        }
    }

    @Override
    protected (void) removeObject(IDelayHandleItem tickObject)
    {
        if (self.mLoopDepth.isInDepth())
        {
            super.removeObject(tickObject);
        }
        else
        {
            if (self.mTickObjectList.IndexOf((ITickedObject)tickObject) != -1)
            {
                self.mTickObjectList.Remove((ITickedObject)tickObject);
            }
        }
    }
}