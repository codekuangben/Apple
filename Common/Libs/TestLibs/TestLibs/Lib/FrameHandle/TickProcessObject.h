﻿package SDK.Lib.FrameHandle;

public class TickProcessObject
{
    public ITickedObject mTickObject;
    public float mPriority;

    public TickProcessObject()
    {
        self.mTickObject = null;
        self.mPriority = 0.0f;
    }
}