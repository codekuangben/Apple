@interface MBitConverter

+ (BOOL) ToBoolean:(Byte[]) bytes
        startIndex: (int) startIndex;
+ (BOOL) ToBoolean:(byte[]) bytes
        startIndex: (int) startIndex
        endian:(EEndian) endian;

+ (char) ToChar:(byte[]) bytes
        startIndex: (int) startIndex;

+ (char) ToChar:(byte[]) bytes
        startIndex: (int) startIndex
        endian: (EEndian) endian;

+ (short) ToInt16:(byte[]) bytes
        startIndex: (int) startIndex;

+ (short) ToInt16:(byte[]) bytes
        startIndex: (int) startIndex
        endian: (EEndian) endian;

+ (short) ToUInt16:(byte[]) bytes
        startIndex:(int) startIndex;

+ (short) ToUInt16:(byte[]) bytes
        startIndex:(int) startIndex
        endian:(EEndian) endian;

+ (int) ToInt32:(byte[]) bytes
        startIndex:(int) startIndex;

+ (int) ToInt32:(byte[]) bytes
        startIndex:(int) startIndex
        endian:(EEndian) endian;
+ (int) ToUInt32:(byte[]) bytes
        startIndex:(int) startIndex;

+ (int) ToUInt32:(byte[]) bytes
        startIndex:(int) startIndex
        endian:(EEndian) endian;
+ (long) ToInt64:(byte[]) bytes
        startIndex:(int) startIndex;

+ (long) ToInt64:(byte[]) bytes
    startIndex:(int) startIndex
    endian:(EEndian) endian;
+ (long) ToUInt64:(byte[]) bytes
        startIndex:(int) startIndex;
+ (long) ToUInt64:(byte[]) bytes
        startIndex:(int) startIndex
        endian:(EEndian) endian;
/**
 * 字节转换为浮点
 *
 * @param b 字节（至少4个字节）
 * @param index 开始位置
 * @return
 */
+ (float) ToFloat:(byte[]) b index:(int) index;

+ (double) ToDouble:(byte[]) bytes
        (int) startIndex;

+ (void) GetBytes:(BOOL) data
        bytes:(byte[]) bytes
        startIndex:(int) startIndex;

+ (void) GetBytes:(BOOL) data
    bytes:(byte[]) bytes
    startIndex:(int) startIndex
    endian:(EEndian) endian;
+ (void) GetBytes:(char) data
        bytes:(byte[]) bytes
        startIndex:(int) startIndex;

+ (void) GetBytes:char data
    bytes:(byte[]) bytes
    startIndex:(int) startIndex
    endian:(EEndian) endian;

+ (void) GetBytes:(short) data
        bytes:(byte[]) bytes
        startIndex:(int) startIndex;
+ (void) GetBytes:(short) data
    bytes:(byte[]) bytes
    startIndex:(int) startIndex
    endian:(EEndian) endian;

+ (void) GetBytes:(int) data
        bytes:(byte[]) bytes
        startIndex:(int) startIndex;
+ (void) GetBytes:(int) data
    bytes:(byte[]) bytes
    startIndex:(int) startIndex
    endian:(EEndian) endian;
+ (void) GetBytes:(long) data
        bytes:(byte[]) bytes
        startIndex:(int) startIndex;

+ (void) GetBytes:(long) data
    bytes:(byte[]) bytes
    startIndex:(int) startIndex
    endian:(EEndian) endian;
+ (byte[]) GetBytes:(float) f;
+ (byte[]) GetBytes:(double) data;

+ (byte[]) GetBytes:(double) data
        bytes:(byte[]) bytes
        startIndex:(int) startIndex;

+ (int) ToInt32: (NSString*) value;

+ (int) toUnsigned: (short) value;


@end