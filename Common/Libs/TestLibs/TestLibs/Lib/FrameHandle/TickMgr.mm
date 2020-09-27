/**
* @brief 心跳管理器
*/
package SDK.Lib.FrameHandle;

import SDK.Lib.DataStruct.MList;
import SDK.Lib.DelayHandle.DelayHandleMgrBase;
import SDK.Lib.DelayHandle.IDelayHandleItem;
import SDK.Lib.EventHandle.ICalleeObjectNoRetNoParam;
import SDK.Lib.Tools.UtilApi;

@implementation TickMgr : DelayHandleMgrBase
{
    protected MList<TickProcessObject> mTickList;

    public TickMgr()
    {
        self.mTickList = new MList<TickProcessObject>();
    }

    @Override
    public (void) init()
    {

    }

    @Override
    public (void) dispose()
    {
        self.mTickList.Clear();
    }

    public (void) addTick(id <ITickedObject> tickObj)
    {
        self.addTick(tickObj, 0);
    }

    public (void) addTick(ITickedObject tickObj, float priority)
    {
        self.addObject((IDelayHandleItem)tickObj, priority);
    }

    @Override
    protected (void) addObject(IDelayHandleItem delayObject)
    {
        self.addObject(delayObject, 0);
    }

    @Override
    protected (void) addObject(IDelayHandleItem delayObject, float priority)
    {
        if (self.mLoopDepth.isInDepth())
        {
            super.addObject(delayObject, priority);
        }
        else
        {
            (int) position = -1;
            (int) idx = 0;
            (int) elemLen = self.mTickList.Count();

            while(idx < elemLen)
            {
                if (self.mTickList.get(idx) == null)
                {
                    continue;
                }

                if (self.mTickList.get(idx).mTickObject == delayObject)
                {
                    return;
                }

                if (self.mTickList.get(idx).mPriority < priority)
                {
                    position = idx;
                    break;
                }

                idx += 1;
            }

            TickProcessObject processObject = new TickProcessObject();
            processObject.mTickObject = (ITickedObject)delayObject;
            processObject.mPriority = priority;

            if (position < 0 || position >= self.mTickList.Count())
            {
                self.mTickList.Add(processObject);
            }
            else
            {
                self.mTickList.Insert(position, processObject);
            }
        }
    }

    public (void) removeTick(ITickedObject tickObj)
    {
        self.removeObject((IDelayHandleItem)tickObj);
    }

    @Override
    protected (void) removeObject(IDelayHandleItem delayObject)
    {
        if (self.mLoopDepth.isInDepth())
        {
            super.removeObject(delayObject);
        }
        else
        {
            for(TickProcessObject item : self.mTickList.list())
            {
                if (UtilApi.isAddressEqual(item.mTickObject, delayObject))
                {
                    self.mTickList.Remove(item);
                    break;
                }
            }
        }
    }

    public (void) Advance(float delta)
    {
        self.mLoopDepth.incDepth();

        //foreach (TickProcessObject tk in self.mTickList.list())
        //{
        //    if (!(tk.mTickObject as IDelayHandleItem).isClientDispose())
        //    {
        //        (tk.mTickObject as ITickedObject).onTick(delta);
        //    }
        //}
        self.onPreAdvance(delta);
        self.onExecAdvance(delta);
        self.onPostAdvance(delta);

        self.mLoopDepth.decDepth();
    }

    protected (void) onPreAdvance(float delta)
    {

    }

    protected (void) onExecAdvance(float delta)
    {
        (int) idx = 0;
        (int) count = self.mTickList.Count();
        ITickedObject tickObject = null;

        while (idx < count)
        {
            tickObject = self.mTickList.get(idx).mTickObject;

            if (!((IDelayHandleItem)tickObject).isClientDispose())
            {
                tickObject.onTick(delta);
            }

            ++idx;
        }
    }

    protected (void) onPostAdvance(float delta)
    {

    }
}