#import "MyLibs/Tools/SystemEndian.h"
#import "MyLibs/Tools/MEndian.h"

static MEndian msLocalEndian = eLITTLE_ENDIAN;   // 本地字节序
static MEndian msNetEndian = eBIG_ENDIAN;        // 网络字节序
static MEndian msServerEndian = msNetEndian;// 服务器字节序，规定服务器字节序就是网络字节序

@implementation SystemEndian

+ (MEndian) IsLocalEndian
{
    return msLocalEndian;
}

+ (MEndian) IsNetEndian
{
    return msNetEndian;
}
+ (MEndian) IsServerEndian
{
    return msServerEndian;
}

@end
