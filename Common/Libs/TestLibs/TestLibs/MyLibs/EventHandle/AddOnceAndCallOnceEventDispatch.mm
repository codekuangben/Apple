#import "MyLibs/EventHandle/AddOnceAndCallOnceEventDispatch.h"

@implementation AddOnceAndCallOnceEventDispatch

- (void) addEventHandle: (GObject<ICalleeObject>*) pThis handle: (GObject<IDispatchObject>*) handle
{
	if (! [self isExistEventHandle: pThis and: handle])
	{
		[super addEventHandle:pThis and handle];
	}
}

- (void) dispatchEvent: (GObject<IDispatchObject>*) dispatchObject
{
	[super dispatchEvent: dispatchObject];

	[self clearEventHandle];
}

@end