#import <Foundation/Foundation.h>

enum BufferCV : NSUInteger
{
	INIT_ELEM_CAPACITY = 32,          // 默认分配 32 元素
	INIT_CAPACITY = 1 * 1024,         // 默认分配 1 K
	MAX_CAPACITY = 8 * 1024 * 1024,   // 最大允许分配 8 M
}