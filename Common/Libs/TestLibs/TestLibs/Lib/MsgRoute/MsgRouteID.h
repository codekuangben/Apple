#ifndef __MsgRouteID_H
#define __MsgRouteID_H

typedef enum
{
    eMRIDSocketOpened,      // socket Opened
    eMRIDSocketClosed,      // socket Closed
    eMRIDLoadedWebRes,      // web 资源加载完成
    eMRIDThreadLog,      // 线程打日志
} MsgRouteID;

#endif