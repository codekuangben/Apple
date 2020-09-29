@interface MsgRouteNotify
{
    @protected
    MList<MsgRouteDispHandle> mDispList;
}

-(id) init;
- (void) addOneDisp:(MsgRouteDispHandle) disp;
- (void) removeOneDisp:(MsgRouteDispHandle) disp;
- (void) handleMsg:(MsgRouteBase) msg;

@end