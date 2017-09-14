#import "MsgRouteBase.h"

@implementation MsgRouteBase

- (id) init:(MsgRouteID) msgId
{
	if(self = [super init])
	{
		self.mMsgType = MsgRouteType.eMRT_BASIC;
		self.mMsgID = msgId;
	}
	
	return self;
}

- (void) resetDefault
{

}

@end