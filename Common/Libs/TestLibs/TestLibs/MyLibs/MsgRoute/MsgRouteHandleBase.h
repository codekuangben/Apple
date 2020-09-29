#ifndef __MsgRouteHandleBase_h
#define __MsgRouteHandleBase_h

@interface MsgRouteHandleBase : GObject, ICalleeObject
{
@public 
	MDictionary mId2HandleDic;
}

@property() MDictionary mId2HandleDic;

-(id) init;
- (void) addMsgRouteHandle:(MsgRouteID) msgRouteID handle:(IDispatchObject) handle;
- (void) removeMsgRouteHandle:(MsgRouteID) msgRouteID, handle:(IDispatchObject) handle;
- (void) handleMsg:(IDispatchObject) dispObj;
- (void) call:(IDispatchObject) dispObj;

@end

#endif