package SDK.Lib.FrameHandle;

/**
 * @brief 逻辑心跳管理器
 */
public class LogicTickMgr extends TickMgr
{
    protected TimeInterval mTimeInterval;

    public LogicTickMgr()
    {
        self.mTimeInterval = new TimeInterval();
    }

    @Override
    protected (void) onExecAdvance(float delta)
    {
        if(self.mTimeInterval.canExec(delta))
        {
            super.onExecAdvance(delta);
        }
    }
}