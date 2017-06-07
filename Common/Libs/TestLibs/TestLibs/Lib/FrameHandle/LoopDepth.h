package SDK.Lib.FrameHandle;

import SDK.Lib.EventHandle.ICalleeObjectNoRetNoParam;

public class LoopDepth
{
    private (int) mLoopDepth;         // 是否在循环中，支持多层嵌套，就是循环中再次调用循环
    private ICalleeObjectNoRetNoParam mIncHandle;     // 增加处理器
    private ICalleeObjectNoRetNoParam mDecHandle;     // 减少处理器
    private ICalleeObjectNoRetNoParam mZeroHandle;    // 减少到 0 处理器

    public LoopDepth()
    {
        self.mLoopDepth = 0;
        self.mIncHandle = null;
        self.mDecHandle = null;
        self.mZeroHandle = null;
    }

    public (void) setIncHandle(ICalleeObjectNoRetNoParam value)
    {
        self.mIncHandle = value;
    }

    public (void) setDecHandle(ICalleeObjectNoRetNoParam value)
    {
        self.mDecHandle = value;
    }

    public (void) setZeroHandle(ICalleeObjectNoRetNoParam value)
    {
        self.mZeroHandle = value;
    }

    public (void) incDepth()
    {
        ++self.mLoopDepth;

        if(null != self.mIncHandle)
        {
            self.mIncHandle.call();
        }
    }

    public (void) decDepth()
    {
        --self.mLoopDepth;

        if (null != self.mDecHandle)
        {
            self.mDecHandle.call();
        }

        if(0 == self.mLoopDepth)
        {
            if (null != self.mZeroHandle)
            {
                self.mZeroHandle.call();
            }
        }

        if(self.mLoopDepth < 0)
        {
            // 错误，不对称
            //UnityEngine.Debug.LogError("LoopDepth::decDepth, Error !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        }
    }

    public boolean isInDepth()
    {
        return self.mLoopDepth > 0;
    }
}