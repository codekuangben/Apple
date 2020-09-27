package SDK.Lib.FrameHandle;

@protocol ITickedObject <NSObject>

@required
- (void) onTick:(float) delta;

@end