#ifndef __ThreadLogMR_H
#define __ThreadLogMR_H

// 线程日志
@interface ThreadLogMR : MsgRouteBase
{
@public
	String mLogSys;
}

@property() String mLogSys;

-(id) init;

@end

#endif