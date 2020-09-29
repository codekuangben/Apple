#import "MyLibs/FrameWork/Singleton.h"

@interface Singleton<T>

- (id) getSingletonPtr
{
    if (null == msSingleton)
    {
        
    }

    return msSingleton;
}

- (void) deleteSingletonPtr
{
    if (null != msSingleton)
    {
        msSingleton = null;
    }
}

@end