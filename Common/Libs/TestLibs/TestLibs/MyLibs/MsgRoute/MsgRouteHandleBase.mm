#import "MyLibs/MsgRoute/MsgRouteHandleBase.h"

@implementation MsgRouteHandleBase

-(id) init
{
	if(self = [super init])
	{
		self->mTypeId = "MsgRouteHandleBase";

		self->mId2HandleDic = [[MDictionary alloc] init];
	}
	
	return self;
}

- (void) addMsgRouteHandle:(MsgRouteID) msgRouteID handle:(IDispatchObject) handle
{
	if(![self->mId2HandleDic ContainsKey:msgRouteID])
	{
		[self->mId2HandleDic set:msgRouteID value:[[AddOnceEventDispatch alloc] init]];
	}

	[[self->mId2HandleDic get:msgRouteID] addEventHandle:NULL, handle:handle];
}

- (void) removeMsgRouteHandle:(MsgRouteID) msgRouteID, handle:(IDispatchObject) handle
{
	if ([self->mId2HandleDic ContainsKey:msgRouteID])
	{
		[self->mId2HandleDic get:msgRouteID.] removeEventHandle:nil handle:handle];
	}
}

- (void) handleMsg:(IDispatchObject) dispObj
{
	MsgRouteBase msg = (MsgRouteBase)dispObj;

	if ([self->mId2HandleDic ContainsKey:msg.mMsgID])
	{
		[self->mId2HandleDic get:msg.mMsgID] dispatchEvent:msg];
	}
	else
	{

	}
}

- (void) call:(IDispatchObject) dispObj
{

}

@end