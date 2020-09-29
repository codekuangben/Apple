#import "MyLibs/Base/GObject.h"

/**
 * @brief 动态增长的缓冲区，不是环形的，从 0 开始增长的
 */
@interface DynBuffer : GObject
{
@public 
	int mCapacity;         // 分配的内存空间大小，单位大小是字节
    int mMaxCapacity;      // 最大允许分配的存储空间大小
    int mSize;              // 存储在当前缓冲区中的数量
    id* mBuffer;            // 当前环形缓冲区
}

@property int mCapacity;
@property int mMaxCapacity;
@property int mSize;
@property id* mBuffer;
	
@end