#ifndef __LoadedWebResMR_h
#define __LoadedWebResMR_h

@interface LoadedWebResMR : MsgRouteBase
{
@public
	ITask mTask;
}

// 属性区域
@property() ITask mTask;

// 接口区域
- (id) init;
- (void) resetDefault;

@end

#endif