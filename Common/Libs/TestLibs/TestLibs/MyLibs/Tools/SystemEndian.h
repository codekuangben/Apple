#include "MyLibs/Base/GObject.h"
#import "MyLibs/Tools/MEndian.h"

@interface SystemEndian : GObject
{
@public

}

+ (MEndian) IsLocalEndian;   // 本地字节序
+ (MEndian) IsNetEndian;        // 网络字节序
+ (MEndian) IsServerEndian;// 服务器字节序，规定服务器字节序就是网络字节序

@end
