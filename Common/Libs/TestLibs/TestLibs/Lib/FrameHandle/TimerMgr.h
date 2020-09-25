/**
* @brief 定时器管理器
*/
package SDK.Lib.FrameHandle;

import SDK.Lib.DataStruct.MList;
import SDK.Lib.DelayHandle.DelayHandleMgrBase;
import SDK.Lib.DelayHandle.IDelayHandleItem;
import SDK.Lib.Tools.UtilApi;

@interface TimerMgr : DelayHandleMgrBase
{
    protected MList<TimerItemBase> mTimerList;     // 当前所有的定时器列表

    public TimerMgr()
    {
        self.mTimerList = new MList<TimerItemBase>();
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
        if (!self.mTimerList.Contains((TimerItemBase)delayObject))
        {
            if (self.mLoopDepth.isInDepth())
            {
                super.addObject(delayObject, priority);
            }
            else
            {
                self.mTimerList.Add((TimerItemBase)delayObject);
            }
        }
    }

    @Override
    protected (void) removeObject(IDelayHandleItem delayObject)
    {
        // 检查当前是否在队列中
        if (self.mTimerList.Contains((TimerItemBase)delayObject))
        {
            ((TimerItemBase)delayObject).mDisposed = true;

            if (self.mLoopDepth.isInDepth())
            {
                super.removeObject(delayObject);
            }
            else
            {
                for(TimerItemBase item : self.mTimerList.list())
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

    public (void) addTimer(TimerItemBase delayObject)
    {
        self.addTimer(delayObject, 0);
    }

    // 从 Lua 中添加定时器，这种定时器尽量整个定时器周期只与 Lua 通信一次
    public (void) addTimer(TimerItemBase delayObject, float priority)
    {
        self.addObject(delayObject, priority);
    }

    public (void) removeTimer(TimerItemBase timer)
    {
        self.removeObject(timer);
    }

    public (void) Advance(float delta)
    {
        self.mLoopDepth.incDepth();

        for(TimerItemBase timerItem : self.mTimerList.list())
        {
            if (!timerItem.isClientDispose())
            {
                timerItem.OnTimer(delta);
            }

            if (timerItem.mDisposed)        // 如果已经结束
            {
                self.removeObject(timerItem);
            }
        }

        self.mLoopDepth.decDepth();
    }
}