﻿#import "Lib.DelayHandle.IDelayHandleItem.h";

/**
 * @brief 定时器，这个是不断增长的
 */
@interface FrameTimerItem : IDelayHandleItem
{
    @public 
    int mInternal;              // 帧数间隔
    int mTotalFrameCount;       // 总共次数
    int mCurFrame;              // 当前已经调用的定时器的时间
    int mCurLeftFrame;          // 剩余帧数
    BOOL mIsInfineLoop;      // 是否是无限循环
    ICalleeObjectFrameTimer mTimerDisp;       // 定时器分发
    BOOL mDisposed;             // 是否已经被释放
}

- (id) init;
- (void) OnFrameTimer;
- (void) reset;
- (void) setClientDispose:(BOOL) isDispose;
- (BOOL) isClientDispose;

@end