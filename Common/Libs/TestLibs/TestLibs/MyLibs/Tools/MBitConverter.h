@interface MBitConverter

+ (BOOL) ToBoolean:
        (Byte[]) bytes
        startIndex: (int) startIndex
                   );
+ (BOOL) ToBoolean:
    (byte[]) bytes
    startIndex: (int) startIndex
    endian:(EEndian) endian
                                );

+ (char) ToChar:
        (byte[]) bytes
        startIndex: (int) startIndex
                          );

+ (char) ToChar:
    (byte[]) bytes
startIndex: (int) startIndex
endian: (EEndian) endian
                          );

+ (short) ToInt16:
        (byte[]) bytes
startIndex: (int) startIndex
                            );

+ (short) ToInt16:
    (byte[]) bytes
startIndex: (int) startIndex
endian: (EEndian) endian
                            );
+ (short) ToUInt16(
        byte[] bytes,
        (int) startIndex
                             );

+ short ToUInt16(
    byte[] bytes,
    (int) startIndex,
    EEndian endian
                             );

+ (int) ToInt32(
        byte[] bytes,
        (int) startIndex
                            );

+ (int) ToInt32(
    byte[] bytes,
    (int) startIndex,
    EEndian endian
                            );
+ (int) ToUInt32(
        byte[] bytes,
        (int) startIndex
                             );

+ (int) ToUInt32(
    byte[] bytes,
    (int) startIndex,
    EEndian endian
                             );
+ long ToInt64(
        byte[] bytes,
        (int) startIndex
                           );

+ long ToInt64(
    byte[] bytes,
    (int) startIndex,
    EEndian endian
                           );
+ long ToUInt64(
        byte[] bytes,
        (int) startIndex
                            );
+ long ToUInt64(
    byte[] bytes,
    (int) startIndex,
    EEndian endian
                            );
/**
 * 字节转换为浮点
 *
 * @param b 字节（至少4个字节）
 * @param index 开始位置
 * @return
 */
+ (float) ToFloat(byte[] b, (int) index);

+ (double) ToDouble(
        byte[] bytes,
        (int) startIndex
                              );

+ (void) GetBytes(
        BOOL data,
        byte[] bytes,
        (int) startIndex
                              );

+ (void) GetBytes(
    BOOL data,
    byte[] bytes,
    (int) startIndex,
    EEndian endian
                              );
+ (void) GetBytes(
        char data,
        byte[] bytes,
        (int) startIndex
                              );

+ (void) GetBytes(
    char data,
    byte[] bytes,
    (int) startIndex,
    EEndian endian
                              );

+ (void) GetBytes(
        short data,
        byte[] bytes,
        (int) startIndex
                              );
+ (void) GetBytes(
    short data,
    byte[] bytes,
    (int) startIndex,
    EEndian endian
                              );

+ (void) GetBytes(
        (int) data,
        byte[] bytes,
        (int) startIndex
                              );
+ (void) GetBytes:
    (int) data,
    byte[] bytes,
    (int) startIndex,
    EEndian endian
                              );
+ (void) GetBytes:
        long data,
        byte[] bytes,
        (int) startIndex
                              );

+ (void) GetBytes:
    long data,
    byte[] bytes,
    (int) startIndex,
    EEndian endian
                              );
+ byte[] GetBytes:float f);
+ byte[] GetBytes:
        double data
                              );

+ byte[] GetBytes:
        double data,
        byte[] bytes,
        (int) startIndex
                              );

+ (int) ToInt32: (NSString) value;

+ (int) toUnsigned: (short) value;


@end