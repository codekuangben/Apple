#import "MyLibs/Base/GObject.h"
#import "MyLibs/EventHandle/ICalleeObject.h"
#import "MyLibs/MsgRoute/MsgRouteID.h"

@class MDictionary;
@protocol IDispatchObject;

@interface MsgRouteHandleBase : GObject <ICalleeObject>
{
@public 
	MDictionary* mId2HandleDic;
}

//@property() MDictionary mId2HandleDic;

- (id) init;
- (void) addMsgRouteHandle:(MsgRouteID) msgRouteID pThis:(GObject<ICalleeObject>*) pThis handle:/*(GObject<IDispatchObject>*)*/(SEL) handle;
- (void) removeMsgRouteHandle:(MsgRouteID) msgRouteID pThis:(GObject<ICalleeObject>*) pThis handle:/*(GObject<IDispatchObject>*)*/(SEL) handle;
- (void) handleMsg:(GObject<IDispatchObject>*) dispObj;
- (void) call:(GObject<IDispatchObject>*) dispObj;

@end
