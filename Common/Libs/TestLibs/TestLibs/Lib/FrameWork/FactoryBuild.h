package SDK.Lib.FrameWork;

import SDK.Lib.DataStruct.ByteBuffer;

/**
 * @brief 生成一些需要的数据结构
 */
@interface FactoryBuild
{
    public ByteBuffer buildByteBuffer()
    {
        return new ByteBuffer();
    }
}