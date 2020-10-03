#import "MyLibs/Base/GObject.h"
#import "MyLibs/DataStruct/MList.h"

@class MsgRouteBase;
@class MsgRouteDispatchHandle;

@interface MsgRouteNotify : GObject
{
    @protected
    MList* mDispList;
}

-(id) init;
- (void) addOneDisp:(MsgRouteDispatchHandle*) disp;
- (void) removeOneDisp:(MsgRouteDispatchHandle*) disp;
- (void) handleMsg:(MsgRouteBase*) msg;

@end
