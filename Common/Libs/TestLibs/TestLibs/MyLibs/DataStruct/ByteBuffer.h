#import "MyLibs/EventHandle/IDispatchObject.h"
#import "MyLibs/Tools/EEndian.h"
#import "MyLibs/Tools/GkEncode.h"

@class DynByteBuffer;

/**
 *@brief ByteBuffer 功能
 */
@interface ByteBuffer <IDispatchObject>
{
    // 读写临时缓存，这个如果是单线程其实可以共享的
@public
    char mWriteFloatBytes[];
    char mWriteDoubleBytes[];

    char mReadFloatBytes[];
    char mReadDoubleBytes[];

@protected
    DynByteBuffer* mDynBuffer;
    int mPos;          // 当前可以读取的位置索引
    EEndian mEndian;          // 大端小端

    char mPadBytes[];
}

/*
@property (nonatomic, readwrite, retain) char mWriteFloatBytes[];
@property (nonatomic, readwrite, retain) char mWriteDoubleBytes[];

@property (nonatomic, readwrite, retain) char mReadFloatBytes[];
@property (nonatomic, readwrite, retain) char mReadDoubleBytes[];

@property (nonatomic, readwrite, retain) DynByteBuffer* mDynBuffer[];
@property (nonatomic, readwrite, retain) int mPos;          // 当前可以读取的位置索引
@property (nonatomic, readwrite, retain) EEndian mEndian;          // 大端小端

@property (nonatomic, readwrite, retain) char[] mPadBytes;
*/

- (id) init;
- (id) init:(int) initCapacity;
- (id) init:(int) initCapacity maxCapacity:(int) maxCapacity;
- (id)init:(int)initCapacity maxCapacity:(int)maxCapacity endian:(EEndian)endian;
- (DynByteBuffer*)getDynBuffer;
- (int)getBytesAvailable;
- (EEndian)getEndian;
- (void)setEndian:(EEndian)end;
- (int)getLength;
- (void)setLength:(int)value;
- (void)setPos:(int) pos;
- (int)getPos;
- (int)getPosition;
- (void)setPosition:(int) value;
- (void)clear;
// 检查是否有足够的大小可以扩展
- (BOOL) canWrite:(int) delta;
// 读取检查
- (BOOL) canRead:(int) delta;
- (void) extendDeltaCapicity:(int) delta;
- (void) advPos:(int) num;
- (void) advPosAndLen:(int) num;
- (void) incPosDelta:(int) delta;        // 添加 pos delta 数量
- (void) decPosDelta:(int) delta;     // 减少 pos delta 数量
- (ByteBuffer*) readInt8:(char) tmpByte;
- (ByteBuffer*) readUnsignedInt8:(char) tmpByte;
- (ByteBuffer*) readInt16:(short) tmpShort;
- (ByteBuffer*) readUnsignedInt16:(short) tmpUshort;
- (ByteBuffer*) readInt32:(int) tmpInt;
- (ByteBuffer*) readUnsignedInt32:(int) tmpUint;
- (ByteBuffer*) readInt64:(long) tmpLong;
- (ByteBuffer*) readUnsignedInt64:(long) tmpUlong;
- (ByteBuffer*) readFloat:(float) tmpFloat;
- (ByteBuffer*) readDouble:(double) tmpDouble;
- (ByteBuffer*) readMultiByte:(NSString*)tmpStr len:(int)len gkCharSet:(GkEncode)gkCharSet;
// 这个是字节读取，没有大小端的区别
- (ByteBuffer*) readBytes:(char[])tmpBytes len:(int)len;
// 如果要使用 writeInt8 ，直接使用 writeMultiByte 这个函数
- (void) writeInt8:(char)value;
- (void) writeUnsignedInt8:(char) value;
- (void) writeInt16:(short) value;
- (void) writeUnsignedInt16:(short) value;
- (void) writeInt32:(int) value;
- (void) writeUnsignedInt32:(int) value;
- (void) writeUnsignedInt32:(int) value bchangeLen:(BOOL) bchangeLen;
- (void) writeInt64:(long) value;
- (void) writeUnsignedInt64:(long) value;
- (void) writeFloat:(float) value;
- (void) writeDouble:(double) value;
- (void) writeBytes:(char[]) value start:(int) start len:(int) len;
// 写入字节， bchangeLen 是否改变长度
- (void) writeBytes:(char[]) value start:(int) start len:(int) len bchangeLen:(BOOL) bchangeLen;
// 写入字符串
- (void) writeMultiByte:(String) value, gkCharSet:(GkEncode) gkCharSet len:(int) len;
- (void) replace:(char[]) srcBytes srcStartPos:(int) srcStartPos;
- (void) replace:(char[]) srcBytes srcStartPos:(int) srcStartPos srclen_:(int) srclen_;
- (void) replace:(char[]) srcBytes srcStartPos:(int) srcStartPos srclen_:(int) srclen_; destStartPos:(int) destStartPos;
// 替换已经有的一段数据
- (void) replace:(char[]) srcBytes srcStartPos:(int) srcStartPos srclen_:(int) srclen_ destStartPos:(int) destStartPos, destlen_:(int) destlen_);
- (void) insertUnsignedInt32:(int) value;
- ByteBuffer* readUnsignedLongByOffset:(long) tmpUlong offset:(int) offset;
// 写入 EOF 结束符
- (void) end;
- ByteBuffer* readBoolean:(BOOL) tmpBool;

@end
