package SDK.Lib.DataStruct;

import java.lang.reflect.Array;

/**
 * @brief 动态增长的缓冲区，不是环形的，从 0 开始增长的
 * @error java 模板参数不能是基本数据类型(primitive type)，因此只能新建一个类
 */
@interface DynByteBuffer
{
@public
    int mCapacity;         // 分配的内存空间大小，单位大小是字节
    int mMaxCapacity;      // 最大允许分配的存储空间大小
    int mSize;              // 存储在当前缓冲区中的数量
    byte[] mBuffer;            // 当前环形缓冲区
}

- (id) init
- (id) initWithParams:(int) initCapacity (int) maxCapacity;
- byte[] getBuffer
- (void) setBuffer:(byte[]) value
- (int) getMaxCapacity
- (void) setMaxCapacity:(int) value
- (int) getCapacity
- (void) setCapacity:(int) value
- (int) getSize
- (void) setSize:(int) value
- (void) extendDeltaCapicity:(int) delta

@end