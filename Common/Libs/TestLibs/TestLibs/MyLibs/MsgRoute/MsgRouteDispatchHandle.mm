#import "MyLibs/MsgRoute/MsgRouteDispatchHandle.h"
#import "MyLibs/MsgRoute/MsgRouteBase.h"

@implementation MsgRouteDispatchHandle

-(id) init
{
	if(self = [super init])
	{
		self->mEventDispatchGroup = [[EventDispatchGroup alloc] init];
	}
	
	return self;
}

- (void) addRouteHandle:(int) evtId eventListener:(MsgRouteHandleBase*) eventListener eventHandle:/*(GObject<IDispatchObject>*)*/(SEL) eventHandle
{
	[self->mEventDispatchGroup addEventHandle:evtId eventListener:(GObject<IListenerObject>*)eventListener eventHandle:eventHandle];
}

- (void) removeRouteHandle:(int) evtId eventListener:(MsgRouteHandleBase*) eventListener eventHandle:/*(GObject<IDispatchObject>*)*/(SEL) eventHandle
{
	[self->mEventDispatchGroup removeEventHandle:evtId eventListener:(GObject<IListenerObject>*)eventListener eventHandle:eventHandle];
}

- (void) handleMsg:(MsgRouteBase*) msg
{
	NSString* textStr = @"";

	if([self->mEventDispatchGroup hasEventHandle:msg->mMsgType])
	{
		[self->mEventDispatchGroup dispatchEvent:msg->mMsgType msg:msg];
	}
	else
	{

	}
}

@end
