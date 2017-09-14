#ifndef __MsgRouteBase_h
#define __MsgRouteBase_h

@interface MsgRouteBase : IRecycle, IDispatchObject
{
@public 
	MsgRouteType mMsgType;
@public 
	MsgRouteID mMsgID;          // 只需要一个 ID 就行了
}

@property() MsgRouteType mMsgType;
@property() MsgRouteID mMsgID;

- (id) init:(MsgRouteID) msgId;
- (void) resetDefault;

@end

#endif