#ifndef __BufferCV_h
#define __BufferCV_h

enum BufferCV : NSUInteger
{
	//extern const (int) BufferCV.INIT_ELEM_CAPACITY = 32;          // 默认分配 32 元素
	//extern const (int) BufferCV.INIT_CAPACITY = 1 * 1024;         // 默认分配 1 K
	//extern const (int) BufferCV.MAX_CAPACITY = 8 * 1024 * 1024;   // 最大允许分配 8 M
	
	BufferCV.INIT_ELEM_CAPACITY = 32,          // 默认分配 32 元素
	BufferCV.INIT_CAPACITY = 1 * 1024,         // 默认分配 1 K
	BufferCV.MAX_CAPACITY = 8 * 1024 * 1024,   // 最大允许分配 8 M
};

#endif