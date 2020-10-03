#import "MyLibs/Base/Gobject.h"
#import "MyLibs/EventHandle/EventDispatchGroup.h"

@class MsgRouteHandleBase;
@class MsgRouteBase;
@protocol IDispatchObject;

@interface MsgRouteDispatchHandle : GObject
{
@protected
	EventDispatchGroup* mEventDispatchGroup;
}

//@property() EventDispatchGroup mEventDispatchGroup;

- (id) init;
- (void) addRouteHandle:(int) evtId eventListener:(MsgRouteHandleBase*) eventListener eventHandle:/*(GObject<IDispatchObject>*)*/(SEL) eventHandle;
- (void) removeRouteHandle:(int) evtId eventListener:(MsgRouteHandleBase*) eventListener eventHandle:/*(GObject<IDispatchObject>*)*/(SEL) eventHandle;
- (void) handleMsg:(MsgRouteBase*) msg;

@end
