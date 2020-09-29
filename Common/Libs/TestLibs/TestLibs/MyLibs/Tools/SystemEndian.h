@interface SystemEndian
{
@public

}

+ (EEndian) IsLocalEndian;   // 本地字节序
+ (EEndian) IsNetEndian;        // 网络字节序
+ (EEndian) IsServerEndian;// 服务器字节序，规定服务器字节序就是网络字节序

@end