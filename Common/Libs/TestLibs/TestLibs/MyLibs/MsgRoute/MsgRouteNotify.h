#import "MyLibs/Base/GObject.h"
#import "MyLibs/DataStruct/MList.h"

@class MsgRouteBase;
@class MsgRouteDispHandle;

@interface MsgRouteNotify : GObject
{
    @protected
    MList* mDispList;
}

-(id) init;
- (void) addOneDisp:(MsgRouteDispHandle*) disp;
- (void) removeOneDisp:(MsgRouteDispHandle*) disp;
- (void) handleMsg:(MsgRouteBase*) msg;

@end
