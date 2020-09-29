#import "MyLibs/Base/GObject.h"

/**
 * @brief 环形缓冲区，不支持多线程写操作
 * @brief 浪费一个自己，这样判断也好判断，并且索引也不用减 1 ，因此浪费一个字节
 * @brief 判空: mFirst == mLast
 * @brief 判满: mFirst == (mLast + 1) % len
 */
@interface CircularBuffer : GObject
{
@protected
	DynByteBuffer* mDynBuffer;
    int mFirst;             // 当前缓冲区数据的第一个索引
    int mLast;              // 当前缓冲区数据的最后一个索引的后面一个索引，浪费一个字节
    ByteBuffer* mTmpBA;        // 临时数据
}

@property (nonatomic, readwrite, retain) DynByteBuffer* mDynBuffer;
@property (nonatomic, readwrite, retain) int mFirst;
@property (nonatomic, readwrite, retain) int mLast;
@property (nonatomic, readwrite, retain) ByteBuffer* mTmpBA;

- (id) init;
- (id) init:(int)initCapacity;
- (id) init:(int)initCapacity maxCapacity:(int)maxCapacity;
-(void)dealloc;
- (int) getFirst;
- (int) getLast;
- (char[]) getbuffer;
- (int) getSize;
- (void) setSize:(int) value;
- (BOOL) isLinearized;
- (BOOL) empty;
- (int) capacity;
- (BOOL) full;
// 清空缓冲区
- (void) clear;
/**
 * @brief 将数据尽量按照存储地址的从小到大排列
 */
- (void) linearize;
/**
 * @brief 更改存储内容空间大小
 */
- (void) setCapacity:(int) newCapacity;
/**
 *@brief 能否添加 num 长度的数据
 */
- BOOL canAddData:(int) num;
/**
 *@brief 向存储空尾部添加一段内容
 */
- (void) pushBackArr:(char[]) items start:(int) start len:(int) len;
- (void) pushBackBA:ByteBuffer* bu;
/**
 *@brief 向存储空头部添加一段内容
 */
- (void) pushFrontArr:(char[]) items;
/**
 * @brief 从 CB 中读取内容，并且将数据删除
 */
- (void) popFrontBA:(ByteBuffer*) bytearray len:(int) len
{
	frontBA(bytearray, len);
	popFrontLen(len);
}
// 仅仅是获取数据，并不删除
- (void) frontBA:(ByteBuffer*) bytearray len:(int) len;
/**
 * @brief 从 CB 头部删除数据
 */
- (void) popFrontLen:(int) len;
// 向自己尾部添加一个 CircularBuffer
- (void) pushBackCB:(CircularBuffer*) rhv;
	
@end