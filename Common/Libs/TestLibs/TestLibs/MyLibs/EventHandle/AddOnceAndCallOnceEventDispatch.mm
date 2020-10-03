#import "MyLibs/EventHandle/AddOnceAndCallOnceEventDispatch.h"

@implementation AddOnceAndCallOnceEventDispatch

- (void) addEventHandle: (GObject<IListenerObject>*) eventListener eventHandle: (GObject<IDispatchObject>*) eventHandle
{
	if (! [self isExistEventHandle: eventListener and: eventHandle])
	{
		[super addEventHandle:eventListener and eventHandle];
	}
}

- (void) dispatchEvent: (GObject<IDispatchObject>*) dispatchObject
{
	[super dispatchEvent: dispatchObject];

	[self clearEventHandle];
}

@end