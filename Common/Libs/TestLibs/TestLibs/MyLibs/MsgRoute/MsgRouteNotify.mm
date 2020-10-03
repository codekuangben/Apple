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

- (void) addOneDisp:(MsgRouteDispHandle*) disp
{
	if(![self->mDispList Contains:disp])
	{
		[self->mDispList Add:disp];
	}
}

- (void) removeOneDisp:(MsgRouteDispHandle*) disp
{
	if([self->mDispList Contains:disp])
	{
		[self->mDispList Remove:disp];
	}
}

- (void) handleMsg:(MsgRouteBase*) msg
{
	for(MsgRouteDispHandle* item in [self->mDispList list])
	{
		[item handleMsg:msg];
	}

	//[Ctx ins]->mPoolSys.deleteObj(msg);
}

@end
