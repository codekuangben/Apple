#import "MyLibs/Base/Gobject.h"
#import "MyLibs/EventHandle/EventDispatchGroup.h"

@class MsgRouteHandleBase;
@class MsgRouteBase;
@protocol IDispatchObject;

@interface MsgRouteDispHandle : GObject
{
@protected
	EventDispatchGroup* mEventDispatchGroup;
}

//@property() EventDispatchGroup mEventDispatchGroup;

-(id) init;
- (void) addRouteHandle:(int) evtId pThis:(MsgRouteHandleBase*) pThis handle:(GObject<IDispatchObject>*) handle;
- (void) removeRouteHandle:(int) evtId pThis:(MsgRouteHandleBase*) pThis handle:(GObject<IDispatchObject>*) handle;
- (void) handleMsg:(MsgRouteBase*) msg;

@end
