package SDK.Lib.FrameHandle;

@interface TickProcessObject
{
    @public
    ITickedObject mTickObject;
    float mPriority;
}

- (id) init;

@end