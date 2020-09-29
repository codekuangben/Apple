package SDK.Lib.FrameHandle;

/**
 * @brief 事件间隔
 */
@interface TimeInterval
{
    @protected
    float mInterval;
    float mTotalTime;
    float mCurTime;
}

- (id) init;
- (void) setInterval:(float) value;
- (void) setTotalTime:(float) value;
- (void) setCurTime:(float) value;
- (BOOL) canExec:(float) delta;

@end