#import "MyLibs/Base/GObject.h"

@interface SystemFrameData : GObject
{
@protected
    int mTotalFrameCount;       // 总帧数
    int mCurFrameCount;         // 当前帧数
    float mCurTime;          // 当前一秒内时间
    int mFps;                // 帧率
}

- (id) init;
- (void) dispose;
- (int) getTotalFrameCount;
- (void) nextFrame:(float) delta;

@end
