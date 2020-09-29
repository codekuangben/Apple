#import "MyLibs/DataStruct/MsgCV.h"

static int PACKET_ZIP_MIN = 32;
static int PACKET_ZIP = 0x40000000;
static int HEADER_SIZE = 4;   // 包长度占据几个字节

@implementation MsgCV

+ (int) PACKET_ZIP_MIN
{
    return PACKET_ZIP_MIN;
}

+ (int) PACKET_ZIP
{
    return PACKET_ZIP;
}

+ (int) HEADER_SIZE
{
    return HEADER_SIZE;
}

@end