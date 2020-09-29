@interface MsgRouteDispHandle
{
@protected
	EventDispatchGroup mEventDispatchGroup;
}

@property() EventDispatchGroup mEventDispatchGroup;

-(id) init;
- (void) addRouteHandle:(int) evtId pThis:(MsgRouteHandleBase) pThis handle:(IDispatchObject) handle;
- (void) removeRouteHandle:(int) evtId pThis:(MsgRouteHandleBase) pThis handle:(IDispatchObject) handle;
- (void) handleMsg:(MsgRouteBase) msg;

@end