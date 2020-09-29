﻿package SDK.Lib.FrameHandle;

import SDK.Lib.DelayHandle.IDelayHandleItem;
import SDK.Lib.EventHandle.IDispatchObject;

/**
 * @brief 定时器，这个是不断增长的
 */
@interface TimerItemBase : IDelayHandleItem, IDispatchObject
{
    float mInternal;        // 定时器间隔
    float mTotalTime;       // 总共定时器时间
    float mCurRunTime;      // 当前定时器运行的时间
    float mCurCallTime;     // 当前定时器已经调用的时间
    boolean mIsInfineLoop;      // 是否是无限循环
    float mIntervalLeftTime;     // 定时器调用间隔剩余时间
    TimerFunctionObject mTimerDisp;       // 定时器分发
    boolean mDisposed;             // 是否已经被释放
    boolean mIsContinuous;          // 是否是连续的定时器
}

- (id) init;
- (void) setFuncObject:(ICalleeObjectTimer*) handle;
- (void) setTotalTime:(float) value;
- float getRunTime;
- float getCallTime;
- float getLeftRunTime;
- float getLeftCallTime;
// 在调用回调函数之前处理
- (void) onPreCallBack;
- (void) OnTimer:(float) delta;
- (void) disposeAndDisp;
- (void) continueDisposeAndDisp;
- (void) discontinueDisposeAndDisp;
- (void) checkAndDisp;
// 连续的定时器
- (void) continueCheckAndDisp;
// 不连续的定时器
- (void) discontinueCheckAndDisp;
- (void) reset;
- (void) setClientDispose:(boolean) isDispose;
- boolean isClientDispose;
- (void) startTimer;
- (void) stopTimer;

@end