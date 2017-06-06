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
    int mPos;          // 当前可以读取的位置索引
    EEndian mEndian;          // 大端小端

    Byte[] mPadBytes;
}

public ByteBuffer()
public ByteBuffer(int initCapacity)
    public ByteBuffer(int initCapacity, int maxCapacity)
    public ByteBuffer(int initCapacity, int maxCapacity, EEndian endian)
    public DynByteBuffer getDynBuffer()
    public int getBytesAvailable()
    public EEndian getEndian()
    public void setEndian(EEndian end)
    public int getLength()
    public void setLength(int value)
    public void setPos(int pos)
    public int getPos()
    public int getPosition()
    public void setPosition(int value)
    public void clear ()
    // 检查是否有足够的大小可以扩展
    protected boolean canWrite(int delta)
    // 读取检查
    protected boolean canRead(int delta)
    protected void extendDeltaCapicity(int delta)
    protected void advPos(int num)
    protected void advPosAndLen(int num)
    public void incPosDelta(int delta)        // 添加 pos delta 数量
    public void decPosDelta(int delta)     // 减少 pos delta 数量
    public ByteBuffer readInt8(char tmpByte)
    public ByteBuffer readUnsignedInt8(byte tmpByte)
    public ByteBuffer readInt16(short tmpShort)
    public ByteBuffer readUnsignedInt16(short tmpUshort)
    public ByteBuffer readInt32(int tmpInt)
    public ByteBuffer readUnsignedInt32(int tmpUint)
    public ByteBuffer readInt64(long tmpLong)
    public ByteBuffer readUnsignedInt64(long tmpUlong)
    public ByteBuffer readFloat(float tmpFloat)
    public ByteBuffer readDouble(double tmpDouble)
    //public ByteBuffer readMultiByte(ref string tmpStr, uint len, Encoding charSet)
    public ByteBuffer readMultiByte(String tmpStr, int len, GkEncode gkCharSet)
    // 这个是字节读取，没有大小端的区别
    public ByteBuffer readBytes(byte[] tmpBytes, int len)
    // 如果要使用 writeInt8 ，直接使用 writeMultiByte 这个函数
    public void writeInt8(char value)
    public void writeUnsignedInt8(byte value)
    public void writeInt16 (short value)
    public void writeUnsignedInt16(short value)
    public void writeInt32(int value)
    public void writeUnsignedInt32 (int value)
    public void writeUnsignedInt32 (int value, boolean bchangeLen)
    public void writeInt64(long value)
    public void writeUnsignedInt64(long value)
    public void writeFloat(float value)
    public void writeDouble(double value)
    public void writeBytes(byte[] value, int start, int len)
    // 写入字节， bchangeLen 是否改变长度
    public void writeBytes(byte[] value, int start, int len, boolean bchangeLen)
    // 写入字符串
    public void writeMultiByte(String value, GkEncode gkCharSet, int len)
    protected void replace(byte[] srcBytes, int srcStartPos)
    protected void replace(byte[] srcBytes, int srcStartPos, int srclen_)
    protected void replace(byte[] srcBytes, int srcStartPos, int srclen_, int destStartPos)
    // 替换已经有的一段数据
    protected void replace(byte[] srcBytes, int srcStartPos, int srclen_, int destStartPos, int destlen_)
    public void insertUnsignedInt32(int value)
    public ByteBuffer readUnsignedLongByOffset(long tmpUlong, int offset)
    // 写入 EOF 结束符
    public void end()
    public ByteBuffer readBoolean(boolean tmpBool)

#endif
