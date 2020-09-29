#import <Foundation/Foundation.h>

enum MsgCV : NSUInteger
{
    PACKET_ZIP_MIN = 32;
    PACKET_ZIP = 0x40000000;
    HEADER_SIZE = 4;   // 包长度占据几个字节
}