// #import <Foundation/Foundation.h>
// #import "MyLibs/Tools/MEndian.h"

// @interface MBitConverter

// + (BOOL) ToBoolean:(char[]) bytes
//         startIndex: (int) startIndex;
// + (BOOL) ToBoolean:(char[]) bytes
//         startIndex: (int) startIndex
//         endian:(MEndian) endian;

// + (char) ToChar:(char[]) bytes
//         startIndex: (int) startIndex;

// + (char) ToChar:(char[]) bytes
//         startIndex: (int) startIndex
//         endian: (MEndian) endian;

// + (short) ToInt16:(char[]) bytes
//         startIndex: (int) startIndex;

// + (short) ToInt16:(char[]) bytes
//         startIndex: (int) startIndex
//         endian: (MEndian) endian;

// + (short) ToUInt16:(char[]) bytes
//         startIndex:(int) startIndex;

// + (short) ToUInt16:(char[]) bytes
//         startIndex:(int) startIndex
//         endian:(MEndian) endian;

// + (int) ToInt32:(char[]) bytes
//         startIndex:(int) startIndex;

// + (int) ToInt32:(char[]) bytes
//         startIndex:(int) startIndex
//         endian:(MEndian) endian;
// + (int) ToUInt32:(char[]) bytes
//         startIndex:(int) startIndex;

// + (int) ToUInt32:(char[]) bytes
//         startIndex:(int) startIndex
//         endian:(MEndian) endian;
// + (long) ToInt64:(char[]) bytes
//         startIndex:(int) startIndex;

// + (long) ToInt64:(char[]) bytes
//     startIndex:(int) startIndex
//     endian:(MEndian) endian;
// + (long) ToUInt64:(char[]) bytes
//         startIndex:(int) startIndex;
// + (long) ToUInt64:(char[]) bytes
//         startIndex:(int) startIndex
//         endian:(MEndian) endian;
// /**
//  * 字节转换为浮点
//  *
//  * @param b 字节（至少4个字节）
//  * @param index 开始位置
//  * @return
//  */
// + (float) ToFloat:(char[]) b index:(int) index;

// + (double) ToDouble:(char[]) bytes
//             startIndex:(int) startIndex;

// + (void) GetBytes:(BOOL) data
//         bytes:(char[]) bytes
//         startIndex:(int) startIndex;

// + (void) GetBytes:(BOOL) data
//     bytes:(char[]) bytes
//     startIndex:(int) startIndex
//     endian:(MEndian) endian;
// + (void) GetBytes:(char) data
//         bytes:(char[]) bytes
//         startIndex:(int) startIndex;

// + (void) GetBytes:char data
//     bytes:(char[]) bytes
//     startIndex:(int) startIndex
//     endian:(MEndian) endian;

// + (void) GetBytes:(short) data
//         bytes:(char[]) bytes
//         startIndex:(int) startIndex;
// + (void) GetBytes:(short) data
//     bytes:(char[]) bytes
//     startIndex:(int) startIndex
//     endian:(MEndian) endian;

// + (void) GetBytes:(int) data
//         bytes:(char[]) bytes
//         startIndex:(int) startIndex;
// + (void) GetBytes:(int) data
//     bytes:(char[]) bytes
//     startIndex:(int) startIndex
//     endian:(MEndian) endian;
// + (void) GetBytes:(long) data
//         bytes:(char[]) bytes
//         startIndex:(int) startIndex;

// + (void) GetBytes:(long) data
//     bytes:(char[]) bytes
//     startIndex:(int) startIndex
//     endian:(MEndian) endian;
// + (char[]) GetBytes:(float) f;
// + (char[]) GetBytes:(double) data;

// + (char[]) GetBytes:(double) data
//         bytes:(char[]) bytes
//         startIndex:(int) startIndex;

// + (int) ToInt32: (NSString*) value;

// + (int) toUnsigned: (short) value;


// @end
