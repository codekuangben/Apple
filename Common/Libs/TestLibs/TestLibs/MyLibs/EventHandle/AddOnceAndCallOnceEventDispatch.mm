#import "AddOnceAndCallOnceEventDispatch.h"

@implementation AddOnceAndCallOnceEventDispatch

- ((void)) addEventHandle: ICalleeObject pThis and: (IDispatchObject) handle
{
	if (! [self isExistEventHandle: pThis and: handle])
	{
		[super addEventHandle:pThis and handle];
	}
}

- ((void)) dispatchEvent: (IDispatchObject) dispatchObject
{
	[super dispatchEvent: dispatchObject];

	[self clearEventHandle];
}

@end