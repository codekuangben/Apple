package SDK.Lib.FrameHandle;

@protocol ITickedObject <NSObject>
{
    - (void) onTick:(float) delta;
}