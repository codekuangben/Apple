#import "MyLibs/Base/UniqueNumIdGen.h"

@implementation UniqueNumIdGen

- (id) init: (int) baseUniqueId
{
    if(self = [super init])
    {
        self->mTypeId = @"UniqueNumIdGen";
        self->mCurId = 0;
    }
    
    return self;
}

- (int) genNewId
{
    self->mPreIdx = self->mCurId;
    self->mCurId++;
    
    return self->mPreIdx;
}

- (int) getCurId
{
    return self->mCurId;
}

@end
