﻿import SDK.Lib.EventHandle.AddOnceEventDispatch;

@implementation GlobalDelegate

- (id) init
{
    self.mMainChildMassChangedDispatch = new AddOnceEventDispatch();
}

- (void) addMainChildChangedHandle:(ICalleeObject*) pThis handle:(IDispatchObject) handle
{
    self.mMainChildMassChangedDispatch.addEventHandle(pThis, handle);
}

- (void) init
{

}

- (void) dispose
{

}

@end