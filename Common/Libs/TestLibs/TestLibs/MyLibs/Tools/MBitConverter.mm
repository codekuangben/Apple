#import "MyLibs/Tools/MBitConverter.h"

@implementation MBitConverter

+ (BOOL) ToBoolean:(Byte[]) bytes
        startIndex: (int) startIndex
{
    return MBitConverter.ToBoolean(bytes, startIndex, EEndian.eLITTLE_ENDIAN);
}

+ (BOOL) ToBoolean:(char[]) bytes
        startIndex: (int) startIndex
        endian:(EEndian) endian
{
    return bytes[startIndex] != 0;
}

+ (char) ToChar:(char[]) bytes
        startIndex: (int) startIndex
{
    return MBitConverter.ToChar(bytes, startIndex, EEndian.eLITTLE_ENDIAN);
}

+ (char) ToChar:(char[]) bytes
        startIndex: (int) startIndex
        endian: (EEndian) endian

{
    return (char)bytes[startIndex];
}

+ (short) ToInt16:(char[]) bytes
        startIndex: (int) startIndex
{
    return MBitConverter.ToInt16(bytes, startIndex, EEndian.eLITTLE_ENDIAN);
}

+ (short) ToInt16:(char[]) bytes
        startIndex: (int) startIndex
        endian: (EEndian) endian
{
    short retValue = 0;
    if (endian == EEndian.eLITTLE_ENDIAN)
    {
        retValue = (short)(
                           (bytes[startIndex + 1] << 8) +
                           bytes[startIndex]
                           );
    }
    else
    {
        retValue = (short)(
                           (bytes[startIndex] << 8) +
                           bytes[startIndex + 1]
                           );
    }
    return retValue;
}

+ (short) ToUInt16:(char[]) bytes
        startIndex:(int) startIndex
{
    return MBitConverter.ToUInt16(bytes, startIndex, EEndian.eLITTLE_ENDIAN);
}

+ (short) ToUInt16:(char[]) bytes
        startIndex:(int) startIndex
        endian:(EEndian) endian
{
    short retValue = 0;
    if (endian == EEndian.eLITTLE_ENDIAN)
    {
        retValue = (short)(
                           (bytes[startIndex + 1] << 8) +
                           bytes[startIndex]
                           );
    }
    else
    {
        retValue = (short)(
                           (bytes[startIndex] << 8) +
                           bytes[startIndex + 1]
                           );
    }
    return retValue;
}

+ (int) ToInt32:(char[]) bytes
        startIndex:(int) startIndex
{
    return MBitConverter.ToInt32(bytes, startIndex, EEndian.eLITTLE_ENDIAN);
}

+ (int) ToInt32:(char[]) bytes
        startIndex:(int) startIndex
        endian:(EEndian) endian
{
    (int) retValue = 0;
    if (endian == EEndian.eLITTLE_ENDIAN)
    {
        retValue = ((int))(
                           (bytes[startIndex + 3] << 24) +
                           (bytes[startIndex + 2] << 16) +
                           (bytes[startIndex + 1] << 8) +
                           bytes[startIndex]
                           );
    }
    else
    {
        retValue = ((int))(
                           (bytes[startIndex] << 24) +
                           (bytes[startIndex + 1] << 16) +
                           (bytes[startIndex + 2] << 8) +
                           bytes[startIndex + 3]
                           );
    }
    return retValue;
}

+ (int) ToUInt32:(char[]) bytes
        startIndex:(int) startIndex
{
    return MBitConverter.ToUInt32(bytes, startIndex, EEndian.eLITTLE_ENDIAN);
}

+ (int) ToUInt32:(char[]) bytes
        startIndex:(int) startIndex
        endian:(EEndian) endian
{
    (int) retValue = 0;
    if (endian == EEndian.eLITTLE_ENDIAN)
    {
        retValue = ((int))(
                           (bytes[startIndex + 3] << 24) +
                           (bytes[startIndex + 2] << 16) +
                           (bytes[startIndex + 1] << 8) +
                           bytes[startIndex]
                           );
    }
    else
    {
        retValue = ((int))(
                           (bytes[startIndex] << 24) +
                           (bytes[startIndex + 1] << 16) +
                           (bytes[startIndex + 2] << 8) +
                           bytes[startIndex + 3]
                           );
    }
    return retValue;
}

+ (long) ToInt64:(char[]) bytes
        startIndex:(int) startIndex
{
    return MBitConverter.ToInt64(bytes, startIndex, EEndian.eLITTLE_ENDIAN);
}

+ (long) ToInt64:(char[]) bytes
    startIndex:(int) startIndex
    endian:(EEndian) endian
{
    long retValue = 0;
    if (endian == EEndian.eLITTLE_ENDIAN)
    {
        retValue = (long)(
                          (bytes[startIndex + 7] << 56) +
                          (bytes[startIndex + 6] << 48) +
                          (bytes[startIndex + 5] << 40) +
                          (bytes[startIndex + 4] << 32) +
                          (bytes[startIndex + 3] << 24) +
                          (bytes[startIndex + 2] << 16) +
                          (bytes[startIndex + 1] << 8) +
                          bytes[startIndex]
                          );
    }
    else
    {
        retValue = (long)(
                          (bytes[startIndex] << 56) +
                          (bytes[startIndex + 1] << 48) +
                          (bytes[startIndex + 2] << 40) +
                          (bytes[startIndex + 3] << 32) +
                          (bytes[startIndex + 4] << 24) +
                          (bytes[startIndex + 5] << 16) +
                          (bytes[startIndex + 6] << 8) +
                          bytes[startIndex + 7]
                          );
    }
    return retValue;
}

+ (long) ToUInt64:(char[]) bytes
        startIndex:(int) startIndex
{
    return MBitConverter.ToUInt64(bytes, startIndex, EEndian.eLITTLE_ENDIAN);
}

+ (long) ToUInt64:(char[]) bytes
        startIndex:(int) startIndex
        endian:(EEndian) endian
{
    long retValue = 0;
    if (endian == EEndian.eLITTLE_ENDIAN)
    {
        retValue = (long)(
                          (bytes[startIndex + 7] << 56) +
                          (bytes[startIndex + 6] << 48) +
                          (bytes[startIndex + 5] << 40) +
                          (bytes[startIndex + 4] << 32) +
                          (bytes[startIndex + 3] << 24) +
                          (bytes[startIndex + 2] << 16) +
                          (bytes[startIndex + 1] << 8) +
                          bytes[startIndex]
                          );
    }
    else
    {
        retValue = (long)(
                          (bytes[startIndex] << 56) +
                          (bytes[startIndex + 1] << 48) +
                          (bytes[startIndex + 2] << 40) +
                          (bytes[startIndex + 3] << 32) +
                          (bytes[startIndex + 4] << 24) +
                          (bytes[startIndex + 5] << 16) +
                          (bytes[startIndex + 6] << 8) +
                          bytes[startIndex + 7]
                          );
    }
    return retValue;
}

/**
 * 字节转换为浮点
 *
 * @param b 字节（至少4个字节）
 * @param index 开始位置
 * @return
 */
+ (float) ToFloat:(char[]) b index:(int) index
{
    (int) l;
    l = b[index + 0];
    l &= 0xff;
    l |= ((long) b[index + 1] << 8);
    l &= 0xffff;
    l |= ((long) b[index + 2] << 16);
    l &= 0xffffff;
    l |= ((long) b[index + 3] << 24);
    return Float.intBitsToFloat(l);
}

+ (double) ToDouble:(char[]) bytes
        (int) startIndex
{
    long value = 0;
    for ((int) i = 0; i < 8; i++)
    {
        value |= ((long) (bytes[i] & 0xff)) << (8 * i);
    }
    return Double.longBitsToDouble(value);
}

+ (void) GetBytes:(BOOL) data
        bytes:(char[]) bytes
        startIndex:(int) startIndex
{
    MBitConverter.GetBytes(data, bytes, startIndex, EEndian.eLITTLE_ENDIAN);
}

+ (void) GetBytes:(BOOL) data
    bytes:(char[]) bytes
    startIndex:(int) startIndex
    endian:(EEndian) endian
{
    bytes[startIndex] = (char)(data ? 1 : 0);
}

+ (void) GetBytes:(char) data
        bytes:(char[]) bytes
        startIndex:(int) startIndex
{
    MBitConverter.GetBytes(data, bytes, startIndex, EEndian.eLITTLE_ENDIAN);
}

+ (void) GetBytes:char data
    bytes:(char[]) bytes
    startIndex:(int) startIndex
    endian:(EEndian) endian
{
    bytes[startIndex] = (char)data;
}

+ (void) GetBytes:(short) data
        bytes:(char[]) bytes
        startIndex:(int) startIndex
{
    MBitConverter.GetBytes(data, bytes, startIndex, EEndian.eLITTLE_ENDIAN);
}

+ (void) GetBytes:(short) data
    bytes:(char[]) bytes
    startIndex:(int) startIndex
    endian:(EEndian) endian
{
    if (endian == EEndian.eLITTLE_ENDIAN)
    {
        //bytes[index] = (char)(data & 0x00FF);
        //bytes[index + 1] = (char)((data & 0xFF00) >> 8);
        bytes[startIndex] = (char)(data << 8 >> 8);
        bytes[startIndex + 1] = (char)(data >> 8);
    }
    else
    {
        //bytes[index + 1] = (char)((data & 0xFF00) >> 8);
        //bytes[index] = (char)(data & 0x00FF);
        bytes[startIndex] = (char)(data >> 8);
        bytes[startIndex + 1] = (char)(data << 8 >> 8);
    }
}

+ (void) GetBytes:(int) data
        bytes:(char[]) bytes
        startIndex:(int) startIndex
{
    MBitConverter.GetBytes(data, bytes, startIndex, EEndian.eLITTLE_ENDIAN);
}

+ (void) GetBytes:(int) data
    bytes:(char[]) bytes
    startIndex:(int) startIndex
    endian:(EEndian) endian
{
    if (endian == EEndian.eLITTLE_ENDIAN)
    {
        bytes[startIndex] = (char)(data << 24 >> 24);
        bytes[startIndex + 1] = (char)(data << 16 >> 24);
        bytes[startIndex + 2] = (char)(data << 8 >> 24);
        bytes[startIndex + 3] = (char)(data >> 24);
    }
    else
    {
        bytes[startIndex] = (char)(data >> 24);
        bytes[startIndex + 1] = (char)(data << 8 >> 24);
        bytes[startIndex + 2] = (char)(data << 16 >> 24);
        bytes[startIndex + 3] = (char)(data << 24 >> 24);
    }
}

+ (void) GetBytes:(long) data
        bytes:(char[]) bytes
        startIndex:(int) startIndex
{
    MBitConverter.GetBytes(data, bytes, startIndex, EEndian.eLITTLE_ENDIAN);
}

+ (void) GetBytes:(long) data
    bytes:(char[]) bytes
    startIndex:(int) startIndex
    endian:(EEndian) endian
{
    if (endian == EEndian.eLITTLE_ENDIAN)
    {
        bytes[startIndex] = (char)(data << 56 >> 56);
        bytes[startIndex + 1] = (char)(data << 48 >> 56);
        bytes[startIndex + 2] = (char)(data << 40 >> 56);
        bytes[startIndex + 3] = (char)(data << 32 >> 56);
        
        bytes[startIndex + 4] = (char)(data << 24 >> 56);
        bytes[startIndex + 5] = (char)(data << 16 >> 56);
        bytes[startIndex + 6] = (char)(data << 8 >> 56);
        bytes[startIndex + 7] = (char)(data >> 56);
    }
    else
    {
        bytes[startIndex] = (char)(data >> 56);
        bytes[startIndex + 1] = (char)(data << 8 >> 56);
        bytes[startIndex + 2] = (char)(data << 16 >> 56);
        bytes[startIndex + 3] = (char)(data << 24 >> 56);
        
        bytes[startIndex + 4] = (char)(data << 32 >> 56);
        bytes[startIndex + 5] = (char)(data << 40 >> 56);
        bytes[startIndex + 6] = (char)(data << 48 >> 56);
        bytes[startIndex + 7] = (char)(data << 56 >> 56);
    }
}

+ (char[]) GetBytes:(float) f
{
    // 把float转换为byte[]
    (int) fbit = Float.floatToIntBits(f);
    
    char[] b = new char[4];
    for ((int) i = 0; i < 4; i++) {
        b[i] = (char) (fbit >> (24 - i * 8));
    }
    
    // 翻转数组
    (int) len = b.length;
    // 建立一个与源数组元素类型相同的数组
    char[] dest = new char[len];
    // 为了防止修改源数组，将源数组拷贝一份副本
    System.arraycopy(b, 0, dest, 0, len);
    char temp;
    // 将顺位第i个与倒数第i个交换
    for ((int) i = 0; i < len / 2; ++i) {
        temp = dest[i];
        dest[i] = dest[len - i - 1];
        dest[len - i - 1] = temp;
    }
    
    return dest;
}

+ (char[]) GetBytes:(double) data
{
    long value = Double.doubleToRawLongBits(data);
    char[] bytes = new char[8];
    
    for ((int) i = 0; i < 8; i++)
    {
        bytes[i] = (char) ((value >> 8 * i) & 0xff);
    }
    
    return bytes;
}

+ (char[]) GetBytes:(double) data
        bytes:(char[]) bytes
        startIndex:(int) startIndex
{
    long value = Double.doubleToRawLongBits(data);
    bytes = new char[8];
    
    for ((int) i = 0; i < 8; i++)
    {
        bytes[i] = (char) ((value >> 8 * i) & 0xff);
    }
    
    return bytes;
}

+ (int) ToInt32: (NSString*) value
{
    return Integer.parseInt(value);
}

+ (int) toUnsigned: (short) value
{
    return value & 0x0FFFF;
}

@end
