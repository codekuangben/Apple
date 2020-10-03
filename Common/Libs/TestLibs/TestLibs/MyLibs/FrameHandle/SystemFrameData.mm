#import "MyLibs/FrameHandle/SystemFrameData.h"

@implementation SystemFrameData

- (id) init
{
    return self;
}

- (void) dispose
{

}

- (int) getTotalFrameCount
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
        self->mFps = (int)(self->mCurFrameCount / self->mCurTime);
        self->mCurFrameCount = 0;
        self->mCurTime = 0;
    }
}

@end
