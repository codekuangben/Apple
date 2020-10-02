#import "MyLibs/FrameHandle/TimerItemBase.h"

/**
 * @brief 倒计时定时器
 */
@interface CountDownTimer : TimerItemBase
{
	
}

-(void) init;
-(void) setTotalTime:(float) value;
-(float) getRunTime;
// 如果要获取剩余的倒计时时间，使用 getLeftCallTime
-(float) getLeftRunTime;
-(void) OnTimer:(float) delta;
-(void) reset;

@end
