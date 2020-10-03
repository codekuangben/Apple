#import "MyLibs/MsgRoute/MsgRouteDispHandle.h"
#import "MyLibs/MsgRoute/MsgRouteBase.h"

@implementation MsgRouteDispHandle

-(id) init
{
	if(self = [super init])
	{
		self->mEventDispatchGroup = [[EventDispatchGroup alloc] init];
	}
	
	return self;
}

- (void) addRouteHandle:(int) evtId pThis:(MsgRouteHandleBase*) pThis handle:(GObject<IDispatchObject>*) handle
{
	[self->mEventDispatchGroup addEventHandle:evtId pThis:(GObject<ICalleeObject>*)pThis handle:handle];
}

- (void) removeRouteHandle:(int) evtId pThis:(MsgRouteHandleBase*) pThis handle:(GObject<IDispatchObject>*) handle
{
	[self->mEventDispatchGroup removeEventHandle:evtId pThis:(GObject<ICalleeObject>*)pThis handle:handle];
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
