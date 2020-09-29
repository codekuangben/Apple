#import "MyLibs/FrameWork/Singleton.h"

@interface Singleton

- (id) getSingletonPtr
{
    if (nil == msSingleton)
    {
        
    }

    return msSingleton;
}

- (void) deleteSingletonPtr
{
    if (nil != msSingleton)
    {
        msSingleton = null;
    }
}

@end