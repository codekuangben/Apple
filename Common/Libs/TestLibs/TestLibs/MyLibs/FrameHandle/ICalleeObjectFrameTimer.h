package SDK.Lib.FrameHandle;

/**
 * @brief 可被调用的函数对象,，没有返回没有参数
 */
@protocol ICalleeObjectFrameTimer <NSObject>

@required
- (void) call:(FrameTimerItem*) frameTimer;

@end