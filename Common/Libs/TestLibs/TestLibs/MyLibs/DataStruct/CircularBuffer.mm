// #import "MyLibs/DataStruct/CircularBuffer.h"

// @implementation CircularBuffer

// - (id) init
// {
// 	[self init:BufferCV.INIT_CAPACITY maxCapacity:BufferCV.MAX_CAPACITY];
	
// 	return self;
// }

// - (id) init:(int)initCapacity
// {
// 	[self init:initCapacity maxCapacity:BufferCV.MAX_CAPACITY];
	
// 	return self;
// }

// - (id) init:(int)initCapacity maxCapacity:(int)maxCapacity
// {
// 	self->mDynBuffer = [[DynByteBuffer alloc] init:initCapacity maxCapacity:maxCapacity];

// 	self->mFirst = 0;
// 	self->mLast = 0;

// 	self->mTmpBA = [[ByteBuffer alloc] init];
	
// 	return self;
// }

// -(void)dealloc
// {
//     //[super dealloc];	// 注意启用了ARC，此处不需要调用
// }

// - (int) getFirst
// {
// 	return mFirst;
// }

// - (int) getLast
// {
// 	return mLast;
// }

// - (char[]) getbuffer
// {
// 	return mDynBuffer.mBuffer;
// }

// - (int) getSize
// {
// 	return mDynBuffer.mSize;
// }

// - (void) setSize:(int) value
// {
// 	mDynBuffer.setSize(value);
// }

// - (BOOL) isLinearized
// {
// 	if ([self getSize] == 0)
// 	{
// 		return true;
// 	}

// 	return self->mFirst < self->mLast;
// }

// - (BOOL) empty
// {
// 	return self->mDynBuffer->mSize == 0;
// }

// - (int) capacity
// {
// 	return self->mDynBuffer->mCapacity;
// }

// - (BOOL) full
// {
// 	return [self capacity] == [self getSize];
// }

// // 清空缓冲区
// - (void) clear
// {
// 	self->mDynBuffer->mSize = 0;
// 	self->mFirst = 0;
// 	self->mLast = 0;
// }

// /**
//  * @brief 将数据尽量按照存储地址的从小到大排列
//  */
// - (void) linearize
// {
// 	if ([self empty])        // 没有数据
// 	{
// 		return;
// 	}
// 	if ([self isLinearized])      // 数据已经是在一块连续的内存空间
// 	{
// 		return;
// 	}
// 	else
// 	{
// 		// 数据在两个不连续的内存空间中
// 		char[] tmp = new char[mLast];
// 		MArray.Copy(mDynBuffer.mBuffer, 0, tmp, 0, mLast);  // 拷贝一段内存空间中的数据到 tmp
// 		MArray.Copy(mDynBuffer.mBuffer, mFirst, mDynBuffer.mBuffer, 0, mDynBuffer.mCapacity - mFirst);  // 拷贝第一段数据到 0 索引位置
// 		MArray.Copy(tmp, 0, mDynBuffer.mBuffer, mDynBuffer.mCapacity - mFirst, mLast);      // 拷贝第二段数据到缓冲区

// 		self->mFirst = 0;
// 		self->mLast = [self getSize];
// 	}
// }

// /**
//  * @brief 更改存储内容空间大小
//  */
// - (void) setCapacity:(int) newCapacity
// {
// 	if (newCapacity == capacity())
// 	{
// 		return;
// 	}
// 	if (newCapacity < self->getSize())       // 不能分配比当前已经占有的空间还小的空间
// 	{
// 		return;
// 	}
// 	char[] tmpbuff = new char[newCapacity];   // 分配新的空间
// 	if (isLinearized()) // 如果是在一段内存空间
// 	{
// 		// 已经是线性空间了仍然将数据移动到索引 0 的位置
// 		MArray.Copy(mDynBuffer.mBuffer, mFirst, tmpbuff, 0, mDynBuffer.mSize);
// 	}
// 	else    // 如果在两端内存空间
// 	{
// 		MArray.Copy(mDynBuffer.mBuffer, mFirst, tmpbuff, 0, mDynBuffer.mCapacity - mFirst);
// 		MArray.Copy(mDynBuffer.mBuffer, 0, tmpbuff, mDynBuffer.mCapacity - mFirst, mLast);
// 	}

// 	mFirst = 0;
// 	mLast = mDynBuffer.mSize;
// 	mDynBuffer.mCapacity = newCapacity;
// 	mDynBuffer.mBuffer = tmpbuff;
// }

// /**
//  *@brief 能否添加 num 长度的数据
//  */
// - BOOL canAddData:(int) num
// {
// 	if (mDynBuffer.mCapacity - mDynBuffer.mSize > num) // 浪费一个字节，不用 >= ，使用 >
// 	{
// 		return true;
// 	}

// 	return false;
// }

// /**
//  *@brief 向存储空尾部添加一段内容
//  */
// - (void) pushBackArr:(char[]) items start:(int) start len:(int) len
// {
// 	if (!canAddData(len)) // 存储空间必须要比实际数据至少多 1
// 	{
// 		(int) closeSize = DynBufResizePolicy.getCloseSize(len + mDynBuffer.mSize, mDynBuffer.mCapacity, mDynBuffer.mMaxCapacity);
// 		setCapacity(closeSize);
// 	}

// 	if (isLinearized())
// 	{
// 		if (len <= (mDynBuffer.mCapacity - mLast))
// 		{
// 			MArray.Copy(items, start, mDynBuffer.mBuffer, mLast, len);
// 		}
// 		else
// 		{
// 			MArray.Copy(items, start, mDynBuffer.mBuffer, mLast, mDynBuffer.mCapacity - mLast);
// 			MArray.Copy(items, mDynBuffer.mCapacity - mLast, mDynBuffer.mBuffer, 0, len - (mDynBuffer.mCapacity - mLast));
// 		}
// 	}
// 	else
// 	{
// 		MArray.Copy(items, start, mDynBuffer.mBuffer, mLast, len);
// 	}

// 	mLast += len;
// 	mLast %= mDynBuffer.mCapacity;

// 	mDynBuffer.mSize += len;
// }

// - (void) pushBackBA:ByteBuffer* bu
// {
// 	//pushBack(bu.dynBuff.buffer, bu.position, bu.bytesAvailable);
// 	pushBackArr(bu.getDynBuffer().getBuffer(), 0, bu.getLength());
// }

// /**
//  *@brief 向存储空头部添加一段内容
//  */
// - (void) pushFrontArr:(char[]) items
// {
// 	if (!canAddData(((int))items.length)) // 存储空间必须要比实际数据至少多 1
// 	{
// 		(int) closeSize = DynBufResizePolicy.getCloseSize(((int))items.length + mDynBuffer.mSize, mDynBuffer.mCapacity, mDynBuffer.mMaxCapacity);
// 		setCapacity(closeSize);
// 	}

// 	if (isLinearized())
// 	{
// 		if (items.length <= mFirst)
// 		{
// 			MArray.Copy(items, 0, mDynBuffer.mBuffer, mFirst - items.length, items.length);
// 		}
// 		else
// 		{
// 			MArray.Copy(items, items.length - mFirst, mDynBuffer.mBuffer, 0, mFirst);
// 			MArray.Copy(items, 0, mDynBuffer.mBuffer, mDynBuffer.mCapacity - (items.length - mFirst), items.length - mFirst);
// 		}
// 	}
// 	else
// 	{
// 		MArray.Copy(items, 0, mDynBuffer.mBuffer, mFirst - items.length, items.length);
// 	}

// 	if (items.length<= mFirst)
// 	{
// 		mFirst -= ((int))items.length;
// 	}
// 	else
// 	{
// 		mFirst = mDynBuffer.mCapacity - (((int))items.length - mFirst);
// 	}
// 	mDynBuffer.mSize += ((int))items.length;
// }

// /**
//  * @brief 从 CB 中读取内容，并且将数据删除
//  */
// - (void) popFrontBA:(ByteBuffer*) bytearray len:(int) len
// {
// 	frontBA(bytearray, len);
// 	popFrontLen(len);
// }

// // 仅仅是获取数据，并不删除
// - (void) frontBA:(ByteBuffer*) bytearray len:(int) len
// {
// 	bytearray.clear();          // 设置数据为初始值
// 	if (mDynBuffer.mSize >= len)          // 头部占据 4 个字节
// 	{
// 		if (isLinearized())      // 在一段连续的内存
// 		{
// 			bytearray.writeBytes(mDynBuffer.mBuffer, mFirst, len);
// 		}
// 		else if (mDynBuffer.mCapacity - mFirst >= len)
// 		{
// 			bytearray.writeBytes(mDynBuffer.mBuffer, mFirst, len);
// 		}
// 		else
// 		{
// 			bytearray.writeBytes(mDynBuffer.mBuffer, mFirst, mDynBuffer.mCapacity - mFirst);
// 			bytearray.writeBytes(mDynBuffer.mBuffer, 0, len - (mDynBuffer.mCapacity - mFirst));
// 		}
// 	}

// 	bytearray.setPosition(0);;        // 设置数据读取起始位置
// }

// /**
//  * @brief 从 CB 头部删除数据
//  */
// - (void) popFrontLen:(int) len
// {
// 	if (isLinearized())  // 在一段连续的内存
// 	{
// 		mFirst += len;
// 	}
// 	else if (mDynBuffer.mCapacity - mFirst >= len)
// 	{
// 		mFirst += len;
// 	}
// 	else
// 	{
// 		mFirst = len - (mDynBuffer.mCapacity - mFirst);
// 	}

// 	mDynBuffer.mSize -= len;
// }

// // 向自己尾部添加一个 CircularBuffer
// - (void) pushBackCB:(CircularBuffer*) rhv
// {
// 	if(mDynBuffer.mCapacity - mDynBuffer.mSize < rhv.getSize())
// 	{
// 		(int) closeSize = DynBufResizePolicy.getCloseSize(rhv.getSize() + mDynBuffer.mSize, mDynBuffer.mCapacity, mDynBuffer.mMaxCapacity);
// 		setCapacity(closeSize);
// 	}
// 	//self->mSize += rhv.size;
// 	//self->mLast = self->mSize;

// 	//mTmpBA.clear();
// 	rhv.frontBA(mTmpBA, rhv.getSize());
// 	pushBackBA(mTmpBA);

// 	//if (rhv.isLinearized()) // 如果是在一段内存空间
// 	//{
// 	//    Array.Copy(rhv.buff, rhv.first, mBuffer, 0, rhv.size);
// 	//}
// 	//else    // 如果在两端内存空间
// 	//{
// 	//    Array.Copy(rhv.buff, rhv.first, mBuffer, 0, rhv.capacity() - rhv.first);
// 	//    Array.Copy(mBuffer, 0, mBuffer, rhv.capacity() - rhv.first, rhv.last);
// 	//}
// 	//rhv.clear();
// }

// @end