﻿package SDK.Lib.EventHandle;

/**
 * @brief 事件回调函数只能添加一次
 */
public class AddOnceEventDispatch extends EventDispatch
{
    public AddOnceEventDispatch()
    {
        this(0);
    }

    public AddOnceEventDispatch(int eventId_)
    {
        super(eventId_);
    }

    @Override
    public void addEventHandle(ICalleeObject pThis, IDispatchObject handle)
    {
        // 这个判断说明相同的函数只能加一次，但是如果不同资源使用相同的回调函数就会有问题，但是这个判断可以保证只添加一次函数，值得，因此不同资源需要不同回调函数
        if (!this.isExistEventHandle(pThis, handle))
        {
            super.addEventHandle(pThis, handle);
        }
    }
}