#import "MyLibs/MsgRoute/MsgRouteNotify.h"

@implementation MsgRouteNotify

-(id) init
{
	if(self = [super init])
	{
		self->mDispList = [[MList alloc] init];
	}
	
	return self;
}

- (void) addOneDisp:(MsgRouteDispatchHandle*) disp
{
	if(![self->mDispList Contains:disp])
	{
		[self->mDispList Add:disp];
	}
}

- (void) removeOneDisp:(MsgRouteDispatchHandle*) disp
{
	if([self->mDispList Contains:disp])
	{
		[self->mDispList Remove:disp];
	}
}

- (void) handleMsg:(MsgRouteBase*) msg
{
	for(MsgRouteDispatchHandle* item in [self->mDispList list])
	{
		[item handleMsg:msg];
	}

	//[Ctx ins]->mPoolSys.deleteObj(msg);
}

@end
