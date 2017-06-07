#ifndef __BufferCV_h
#define __BufferCV_h

@import "IDispatchObject.h"

/**
 *@brief ByteBuffer 功能
 */
public class ByteBuffer : IDispatchObject
{
    // 读写临时缓存，这个如果是单线程其实可以共享的
    @public
    Byte[] mWriteFloatBytes;
    Byte[] mWriteDoubleBytes;

    Byte[] mReadFloatBytes;
    Byte[] mReadDoubleBytes;

    @protected
    DynByteBuffer mDynBuffer;
    (int) mPos;          // 当前可以读取的位置索引
    EEndian mEndian;          // 大端小端

    Byte[] mPadBytes;
}



#endif