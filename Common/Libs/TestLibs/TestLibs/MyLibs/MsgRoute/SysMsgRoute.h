/**
 * @brief 系统消息流程，整个系统的消息分发都走这里，仅限单线程
 */
@interface SysMsgRoute : LockQueue<MsgRouteBase>
{
    
}

-(id) init:(String) name;
-(void) dispose;

@end