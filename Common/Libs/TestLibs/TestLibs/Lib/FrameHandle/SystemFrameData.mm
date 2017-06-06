package SDK.Lib.FrameHandle;

public class SystemFrameData
{
    protected int mTotalFrameCount;       // 总帧数
    protected int mCurFrameCount;         // 当前帧数
    protected float mCurTime;          // 当前一秒内时间
    protected int mFps;                // 帧率

    public void init()
    {

    }

    public void dispose()
    {

    }

    public int getTotalFrameCount()
    {
        return self.mTotalFrameCount;
    }

    public void nextFrame(float delta)
    {
        ++self.mTotalFrameCount;
        ++self.mCurFrameCount;
        self.mCurTime += delta;

        if(self.mCurTime > 1.0f)
        {
            self.mFps = (int)(self.mCurFrameCount / self.mCurTime);
            self.mCurFrameCount = 0;
            self.mCurTime = 0;
        }
    }
}