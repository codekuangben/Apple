#import "MsgRouteDispHandle.h"

@implementation MsgRouteDispHandle

-(id) init
{
	if(self = [super init])
	{
		self.mEventDispatchGroup = [[EventDispatchGroup alloc] init];
	}
	
	return self;
}

- (void) addRouteHandle:(int) evtId pThis:(MsgRouteHandleBase) pThis handle:(IDispatchObject) handle
{
	[self.mEventDispatchGroup addEventHandle:evtId pThis:pThis handle:handle];
}

- (void) removeRouteHandle:(int) evtId pThis:(MsgRouteHandleBase) pThis handle:(IDispatchObject) handle
{
	[self.mEventDispatchGroup removeEventHandle:evtId pThis:pThis handle:handle];
}

- (void) handleMsg:(MsgRouteBase) msg
{
	String textStr = "";

	if([self.mEventDispatchGroup hasEventHandle:msg.mMsgType])
	{
		[self.mEventDispatchGroup dispatchEvent:msg.mMsgType msg:msg];
	}
	else
	{

	}
}

@end