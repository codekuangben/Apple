#import "MyLibs/Base/GObject.h"
#import "MyLibs/MsgRoute/MsgRouteType.h"
#import "MyLibs/MsgRoute/MsgRouteID.h"
#import "MyLibs/EventHandle/IDispatchObject.h"

@interface MsgRouteBase : GObject <IDispatchObject>
{
@public 
	MsgRouteType mMsgType;
@public 
	MsgRouteID mMsgID;          // 只需要一个 ID 就行了
}

//@property() MsgRouteType mMsgType;
//@property() MsgRouteID mMsgID;

- (id) init:(MsgRouteID) msgId;
- (void) resetDefault;

@end
