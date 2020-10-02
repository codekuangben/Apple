#import <Foundation/Foundation.h>
#import "MyLibs/MsgRoute/MsgRouteBase.h"

// 线程日志
@interface ThreadLogMR : MsgRouteBase
{
@public
	NSString* mLogSys;
}

//@property() NSString* mLogSys;

-(id) init;

@end
