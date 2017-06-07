@import "UniqueNumIdGen.h"

@implementation UniqueNumIdGen

- (id) init: ((int)) baseUniqueId
{
    if(self = [super init])
    {
        mTypeId = @"UniqueNumIdGen";
        mCurId = 0;
    }
    
    return self;
}

- ((int)) genNewId
{
    mPreIdx = mCurId;
    mCurId++;
    
    return mPreIdx;
}

- ((int)) getCurId
{
    return mCurId;
}

@end
