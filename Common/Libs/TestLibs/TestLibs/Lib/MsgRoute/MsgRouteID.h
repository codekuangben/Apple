#ifndef __MsgRouteID_h
#define __MsgRouteID_h

enum
{
    eMRIDSocketOpened,      // socket Opened
    eMRIDSocketClosed,      // socket Closed
    eMRIDLoadedWebRes,      // web 资源加载完成
    eMRIDThreadLog,      // 线程打日志
} MsgRouteID;

#endif