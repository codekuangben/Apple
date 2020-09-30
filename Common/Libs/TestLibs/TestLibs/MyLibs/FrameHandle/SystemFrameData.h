@interface SystemFrameData
{
    @protected
    (int) mTotalFrameCount;       // 总帧数
    (int) mCurFrameCount;         // 当前帧数
    float mCurTime;          // 当前一秒内时间
    (int) mFps;                // 帧率
}

- (void) init()
{

}

- (void) dispose()
{

}

- (int) getTotalFrameCount()
{
    return self->mTotalFrameCount;
}

- (void) nextFrame:(float) delta
{
    ++self->mTotalFrameCount;
    ++self->mCurFrameCount;
    self->mCurTime += delta;

    if(self->mCurTime > 1.0f)
    {
        self->mFps = ((int))(self->mCurFrameCount / self->mCurTime);
        self->mCurFrameCount = 0;
        self->mCurTime = 0;
    }
}

@end