#import "MyLibs/MsgRoute/MsgRouteHandleBase.h"
#import "MyLibs/EventHandle/AddOnceEventDispatch.h"
#import "MyLibs/MsgRoute/MsgRouteBase.h"

@implementation MsgRouteHandleBase

-(id) init
{
	if(self = [super init])
	{
		self->mTypeId = @"MsgRouteHandleBase";

		self->mId2HandleDic = [[MDictionary alloc] init];
	}
	
	return self;
}

- (void) addMsgRouteHandle:(MsgRouteID) msgRouteID eventListener:(GObject<IListenerObject>*) eventListener eventHandle:/*(GObject<IDispatchObject>*)*/(SEL) eventHandle
{
	if(![self->mId2HandleDic ContainsKey:msgRouteID])
	{
		[self->mId2HandleDic set:msgRouteID value:[[AddOnceEventDispatch alloc] init]];
	}

	[[self->mId2HandleDic get:msgRouteID] addEventHandle:eventListener eventHandle:eventHandle];
}

- (void) removeMsgRouteHandle:(MsgRouteID) msgRouteID eventListener:(GObject<IListenerObject>*) eventListener eventHandle:/*(GObject<IDispatchObject>*)*/(SEL) eventHandle
{
	if ([self->mId2HandleDic ContainsKey:msgRouteID])
	{
		[[self->mId2HandleDic get:msgRouteID] removeEventHandle:eventListener eventHandle:eventHandle];
	}
}

- (void) handleMsg:(GObject<IDispatchObject>*) dispatchObject
{
	MsgRouteBase* msg = (MsgRouteBase*)dispatchObject;

	if ([self->mId2HandleDic ContainsKey:msg->mMsgID])
	{
		[[self->mId2HandleDic get:msg->mMsgID] dispatchEvent:msg];
	}
	else
	{

	}
}

- (void) call:(GObject<IDispatchObject>*) dispatchObject
{

}

@end
