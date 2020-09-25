﻿/**
* @brief 定时器管理器
*/
package SDK.Lib.FrameHandle;

import SDK.Lib.DataStruct.MList;
import SDK.Lib.DelayHandle.DelayHandleMgrBase;
import SDK.Lib.DelayHandle.IDelayHandleItem;
import SDK.Lib.Tools.UtilApi;

@interface FrameTimerMgr : DelayHandleMgrBase
{
    protected MList<FrameTimerItem> mTimerList;     // 当前所有的定时器列表

    public FrameTimerMgr()
    {
        self.mTimerList = new MList<FrameTimerItem>();
    }

    @Override
    public (void) init()
    {

    }

    @Override
    public (void) dispose()
    {

    }

    @Override
    protected (void) addObject(IDelayHandleItem delayObject)
    {
        self.addObject(delayObject, 0);
    }

    @Override
    protected (void) addObject(IDelayHandleItem delayObject, float priority)
    {
        // 检查当前是否已经在队列中
        if (!self.mTimerList.Contains((FrameTimerItem)delayObject))
        {
            if (self.mLoopDepth.isInDepth())
            {
                super.addObject(delayObject, priority);
            }
            else
            {
                self.mTimerList.Add((FrameTimerItem)delayObject);
            }
        }
    }

    @Override
    protected (void) removeObject(IDelayHandleItem delayObject)
    {
        // 检查当前是否在队列中
        if (self.mTimerList.Contains((FrameTimerItem)delayObject))
        {
            ((FrameTimerItem)delayObject).mDisposed = true;

            if (self.mLoopDepth.isInDepth())
            {
                super.addObject(delayObject);
            }
            else
            {
                for(FrameTimerItem item : self.mTimerList.list())
                {
                    if (UtilApi.isAddressEqual(item, delayObject))
                    {
                        self.mTimerList.Remove(item);
                        break;
                    }
                }
            }
        }
    }

    public (void) addFrameTimer(FrameTimerItem timer)
    {
        self.addFrameTimer(timer, 0);
    }

    public (void) addFrameTimer(FrameTimerItem timer, float priority)
    {
        self.addObject(timer, priority);
    }

    public (void) removeFrameTimer(FrameTimerItem timer)
    {
        self.removeObject(timer);
    }

    public (void) Advance(float delta)
    {
        self.mLoopDepth.incDepth();

        for(FrameTimerItem timerItem : self.mTimerList.list())
        {
            if (!timerItem.isClientDispose())
            {
                timerItem.OnFrameTimer();
            }
            if (timerItem.mDisposed)
            {
                removeObject(timerItem);
            }
        }

        self.mLoopDepth.decDepth();
    }
}

@end