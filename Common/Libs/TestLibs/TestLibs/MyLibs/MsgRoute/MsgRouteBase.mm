#import "MyLibs/MsgRoute/MsgRouteBase.h"

@implementation MsgRouteBase

- (id) init:(MsgRouteID) msgId
{
	if(self = [super init])
	{
		self->mMsgType = eMRT_BASIC;
		self->mMsgID = msgId;
	}
	
	return self;
}

- (void) resetDefault
{

}

@end
