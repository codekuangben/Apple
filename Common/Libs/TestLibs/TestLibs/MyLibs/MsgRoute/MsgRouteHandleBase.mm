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

- (void) addMsgRouteHandle:(MsgRouteID) msgRouteID pThis:(GObject<ICalleeObject>*) pThis handle:/*(GObject<IDispatchObject>*)*/(SEL) handle
{
	if(![self->mId2HandleDic ContainsKey:msgRouteID])
	{
		[self->mId2HandleDic set:msgRouteID value:[[AddOnceEventDispatch alloc] init]];
	}

	[[self->mId2HandleDic get:msgRouteID] addEventHandle:pThis handle:handle];
}

- (void) removeMsgRouteHandle:(MsgRouteID) msgRouteID pThis:(GObject<ICalleeObject>*) pThis handle:/*(GObject<IDispatchObject>*)*/(SEL) handle
{
	if ([self->mId2HandleDic ContainsKey:msgRouteID])
	{
		[[self->mId2HandleDic get:msgRouteID] removeEventHandle:pThis handle:handle];
	}
}

- (void) handleMsg:(GObject<IDispatchObject>*) dispObj
{
	MsgRouteBase* msg = (MsgRouteBase*)dispObj;

	if ([self->mId2HandleDic ContainsKey:msg->mMsgID])
	{
		[[self->mId2HandleDic get:msg->mMsgID] dispatchEvent:msg];
	}
	else
	{

	}
}

- (void) call:(GObject<IDispatchObject>*) dispObj
{

}

@end
