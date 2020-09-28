package SDK.Lib.FrameWork;

import SDK.Lib.Tools.TClassOp;

@interface Singleton
{
    @protected 
    id msSingleton;
}

- (id) getSingletonPtr
- (void) deleteSingletonPtr

@end