#import "MyLibs/Tools/SystemEndian.h"
#import "MyLibs/Tools/EEndian.h"

static EEndian msLocalEndian = eLITTLE_ENDIAN;   // 本地字节序
static EEndian msNetEndian = eBIG_ENDIAN;        // 网络字节序
static EEndian msServerEndian = msNetEndian;// 服务器字节序，规定服务器字节序就是网络字节序

@implementation SystemEndian

+ (EEndian) IsLocalEndian
{
    return msLocalEndian;
}

+ (EEndian) IsNetEndian
{
    return msNetEndian;
}
+ (EEndian) IsServerEndian
{
    return msServerEndian;
}

@end
