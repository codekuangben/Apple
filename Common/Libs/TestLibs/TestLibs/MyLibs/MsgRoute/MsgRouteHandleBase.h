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
- (void) addMsgRouteHandle:(MsgRouteID) msgRouteID handle:(GObject<IDispatchObject>*) handle;
- (void) removeMsgRouteHandle:(MsgRouteID) msgRouteID handle:(GObject<IDispatchObject>*) handle;
- (void) handleMsg:(GObject<IDispatchObject>*) dispObj;
- (void) call:(GObject<IDispatchObject>*) dispObj;

@end
