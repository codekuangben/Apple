#import "MyLibs/Base/GObject.h"
#import "MyLibs/EventHandle/IListenerObject.h"
#import "MyLibs/MsgRoute/MsgRouteID.h"

@class MDictionary;
@protocol IDispatchObject;

@interface MsgRouteHandleBase : GObject <IListenerObject>
{
@public 
	MDictionary* mId2HandleDic;
}

//@property() MDictionary mId2HandleDic;

- (id) init;
- (void) addMsgRouteHandle:(MsgRouteID) msgRouteID eventListener:(GObject<IListenerObject>*) eventListener eventHandle:/*(GObject<IDispatchObject>*)*/(SEL) eventHandle;
- (void) removeMsgRouteHandle:(MsgRouteID) msgRouteID eventListener:(GObject<IListenerObject>*) eventListener eventHandle:/*(GObject<IDispatchObject>*)*/(SEL) eventHandle;
- (void) handleMsg:(GObject<IDispatchObject>*) dispatchObject;
- (void) call:(GObject<IDispatchObject>*) dispatchObject;

@end
