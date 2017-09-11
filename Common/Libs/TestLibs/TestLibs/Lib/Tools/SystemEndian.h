#ifndef __SystemEndian_h
#define __SystemEndian_h

@interface SystemEndian
{
@public
    static EEndian msLocalEndian = EEndian.eLITTLE_ENDIAN;   // 本地字节序
    static EEndian msNetEndian = EEndian.eBIG_ENDIAN;        // 网络字节序
    static EEndian msServerEndian = SystemEndian.msNetEndian;// 服务器字节序，规定服务器字节序就是网络字节序
}

#endif
