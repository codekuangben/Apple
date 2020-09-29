package SDK.Lib.FrameHandle;

import SDK.Lib.FrameWork.Ctx;

@interface SystemTimeData
{
    @protected 
    long mPreTime;           // 上一次更新时的秒数
    long mCurTime;           // 正在获取的时间
    float mDeltaSec;         // 两帧之间的间隔
    boolean mIsFixFrameRate;     // 固定帧率
    float mFixFrameRate;       // 固定帧率
    float mScale;             // delta 缩放

    // Edit->Project Setting->time
    float mFixedTimestep;
}

- (id) init;
- (void) init;
- (void) dispose;
- float getDeltaSec;
- (void) setDeltaSec:(float) value;
- float getFixedTimestep;
- long getCurTime;
- (void) setCurTime:(long) value;
- (void) nextFrame;

@end