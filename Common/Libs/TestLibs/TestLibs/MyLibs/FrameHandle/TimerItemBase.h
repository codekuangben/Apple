#import "MyLibs/DelayHandle/IDelayHandleItem.h"
#import "MyLibs/EventHandle/IDispatchObject.h"
#import "MyLibs/EventHandle/EventDispatchFunctionObject.h"
#import "MyLibs/EventHandle/IListenerObject.h"
#import "MyLibs/Base/GObject.h"
/**
 * @brief 定时器，这个是不断增长的
 */
@interface TimerItemBase : GObject <IDelayHandleItem, IDispatchObject>
{
@public
    float mInternal;        // 定时器间隔
    float mTotalTime;       // 总共定时器时间
    float mCurRunTime;      // 当前定时器运行的时间
    float mCurCallTime;     // 当前定时器已经调用的时间
    BOOL mIsInfineLoop;      // 是否是无限循环
    float mIntervalLeftTime;     // 定时器调用间隔剩余时间
    EventDispatchFunctionObject* mTimerDispatch;       // 定时器分发
    BOOL mDisposed;             // 是否已经被释放
    BOOL mIsContinuous;          // 是否是连续的定时器
}

- (id) init;
- (void) setFuncObject:(GObject<IListenerObject>*) eventListener eventHandle:(SEL) eventHandle;
- (void) setTotalTime:(float) value;
- (float) getRunTime;
- (float) getCallTime;
- (float) getLeftRunTime;
- (float) getLeftCallTime;
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
- (void) setClientDispose:(BOOL) isDispose;
- (BOOL) isClientDispose;
- (void) startTimer;
- (void) stopTimer;

@end
