package SDK.Lib.FrameHandle;

import SDK.Lib.EventHandle.ICalleeObjectNoRetNoParam;

@implementation LoopDepth

- (id) init
{
    self.mLoopDepth = 0;
    self.mIncHandle = null;
    self.mDecHandle = null;
    self.mZeroHandle = null;
}

- (void) setIncHandle:(ICalleeObjectNoRetNoParam*) value
{
    self.mIncHandle = value;
}

- (void) setDecHandle:(ICalleeObjectNoRetNoParam*) value
{
    self.mDecHandle = value;
}

- (void) setZeroHandle:(ICalleeObjectNoRetNoParam*) value
{
    self.mZeroHandle = value;
}

- (void) incDepth
{
    ++self.mLoopDepth;

    if(null != self.mIncHandle)
    {
        self.mIncHandle.call();
    }
}

- (void) decDepth
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

- (BOOL) isInDepth
{
    return self.mLoopDepth > 0;
}

@end