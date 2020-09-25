package SDK.Lib.DelayHandle;

@interface DelayAddParam : DelayHandleParamBase
{
    public float mPriority;

    public DelayAddParam()
    {
        self.mPriority = 0.0f;
    }
}