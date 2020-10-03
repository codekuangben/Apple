#import "MyLibs/FrameWork/Singleton.h"
#import <Foundation/Foundation.h>

@implementation Singleton

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
        msSingleton = nil;
    }
}

@end
