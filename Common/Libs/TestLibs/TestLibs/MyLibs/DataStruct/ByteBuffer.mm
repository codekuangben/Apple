#import "MyLibs/DataStruct/ByteBuffer.h"
#import "MyLibs/DataStruct/BufferCV.h"

@implementation ByteBuffer

- (id) init
{
    [self init:BufferCV.INIT_CAPACITY maxCapacity:BufferCV.MAX_CAPACITY endian:EEndian.eLITTLE_ENDIAN]
    
    return self;
}

- (id) init:(int) initCapacity
{
    [self init:initCapacity maxCapacity:BufferCV.MAX_CAPACITY endian:EEndian.eLITTLE_ENDIAN]
    
    return self;
}

- (id) init:(int) initCapacity maxCapacity:(int) maxCapacity
{
    [self init:initCapacity maxCapacity endian:EEndian.eLITTLE_ENDIAN]
    
    return self;
}

- (id)init:(int)initCapacity maxCapacity:(int)maxCapacity endian:(EEndian)endian
{
    self->mEndian = endian;        // 缓冲区默认是小端的数据，因为服务器是 linux 的
	self->mDynBuffer = [[DynByteBuffer alloc] init:initCapacity maxCapacity:maxCapacity];

	int index = 0;
	int listLen = sizeof(float);
	
	while(index < listLen)
	{
		self->mReadFloatBytes[index] = 0;
		index += 1;
	}
	
	index = 0;
	listLen = sizeof(double);
	
	while(index < listLen)
	{
		self->mReadDoubleBytes[index] = 0;
		index += 1;
	}
    
    return self;
}

- (DynByteBuffer*)getDynBuffer
{
	return self->mDynBuffer;
}

- (int)getBytesAvailable
{
	return (self->mDynBuffer->getSize() - self->mPos);
}

- (EEndian)getEndian
{
	return self->mEndian;
}

- (void)setEndian:(EEndian)end
{
	self->mEndian = end;
}

- (int)getLength
{
	return self->mDynBuffer.getSize();
}

- (void)setLength:(int)value
{
	self->mDynBuffer->setSize(value);
}

- (void)setPos:(int) pos
{
	self->mPos = pos;
}

- (int)getPos
{
	return self->mPos;
}

- (int)getPosition
{
	return self->mPos;
}

- (void)setPosition:(int) value
{
	self->mPos = value;
}

- (void)clear
{
	self->mPos = 0;
	self->mDynBuffer.setSize(0);
}

// 检查是否有足够的大小可以扩展
- (BOOL) canWrite:(int) delta
{
	if(self->mDynBuffer.getSize() + delta > self->mDynBuffer.getCapacity())
	{
		return false;
	}

	return true;
}

// 读取检查
- (BOOL) canRead:(int) delta
{
	if (self->mPos + delta > self->mDynBuffer.getSize())
	{
		return false;
	}

	return true;
}

- (void) extendDeltaCapicity:(int) delta
{
	self->mDynBuffer.extendDeltaCapicity(delta);
}

- (void) advPos:(int) num
{
	self->mPos += num;
}

- (void) advPosAndLen:(int) num
{
	self->mPos += num;
	self->setLength(self->mPos);
}

- (void) incPosDelta:(int) delta        // 添加 pos delta 数量
{
	self->mPos += (int)delta;
}

- (void) decPosDelta:(int) delta     // 减少 pos delta 数量
{
	self->mPos -= (int)delta;
}

- (ByteBuffer*) readInt8:(char) tmpByte
{
	if (canRead(Character.SIZE))
	{
		tmpByte = (char)mDynBuffer.getBuffer()[(int)mPos];
		advPos(Character.SIZE);
	}

	return this;
}

- (ByteBuffer*) readUnsignedInt8:(char) tmpByte
{
	if (canRead(Byte.SIZE))
	{
		tmpByte = mDynBuffer.getBuffer()[(int)mPos];
		advPos(Byte.SIZE);
	}

	return this;
}

- (ByteBuffer*) readInt16:(short) tmpShort
{
	if (canRead(Short.SIZE))
	{
		tmpShort = MBitConverter.ToInt16(mDynBuffer.getBuffer(), (int)mPos, mEndian);

		advPos(Short.SIZE);
	}

	return this;
}

- (ByteBuffer*) readUnsignedInt16:(short) tmpUshort
{
	if (canRead(Short.SIZE))
	{
		tmpUshort = MBitConverter.ToUInt16(mDynBuffer.getBuffer(), (int)mPos, mEndian);

		advPos(Short.SIZE);
	}

	return this;
}

- (ByteBuffer*) readInt32:(int) tmpInt
{
	if (canRead(Integer.SIZE))
	{
		tmpInt = MBitConverter.ToInt32(mDynBuffer.getBuffer(), (int)mPos, mEndian);

		advPos(Integer.SIZE);
	}

	return this;
}

- (ByteBuffer*) readUnsignedInt32:(int) tmpUint
{
	if (canRead(Integer.SIZE))
	{
		// 如果字节序和本地字节序不同，需要转换
		tmpUint = MBitConverter.ToUInt32(mDynBuffer.getBuffer(), (int)mPos, mEndian);

		advPos(Integer.SIZE);
	}

	return this;
}

- (ByteBuffer*) readInt64:(long) tmpLong
{
	if (canRead(Long.SIZE))
	{
		tmpLong = MBitConverter.ToInt64(mDynBuffer.getBuffer(), (int)mPos, mEndian);

		advPos(Long.SIZE);
	}

	return this;
}

- (ByteBuffer*) readUnsignedInt64:(long) tmpUlong
{
	if (canRead(Long.SIZE))
	{
		tmpUlong = MBitConverter.ToUInt64(mDynBuffer.getBuffer(), (int)mPos, mEndian);

		advPos(Long.SIZE);
	}

	return this;
}

- (ByteBuffer*) readFloat:(float) tmpFloat
{
	if (canRead(Float.SIZE))
	{
		if (mEndian != SystemEndian.msLocalEndian)
		{
			MArray.Copy(mDynBuffer.getBuffer(), (int)mPos, mReadFloatBytes, 0, Float.SIZE);
			MArray.Reverse(mReadFloatBytes, 0, Float.SIZE);
			tmpFloat = MBitConverter.ToFloat(mReadFloatBytes, (int)mPos);
		}
		else
		{
			tmpFloat = MBitConverter.ToFloat(mDynBuffer.getBuffer(), (int)mPos);
		}

		advPos(Float.SIZE);
	}

	return this;
}

- (ByteBuffer*) readDouble:(double) tmpDouble
{
	if (canRead(Double.SIZE))
	{
		if (mEndian != SystemEndian.msLocalEndian)
		{
			MArray.Copy(mDynBuffer.getBuffer(), (int)mPos, mReadDoubleBytes, 0, Double.SIZE);
			MArray.Reverse(mReadDoubleBytes, 0, Double.SIZE);
			tmpDouble = MBitConverter.ToDouble(mReadDoubleBytes, (int)mPos);
		}
		else
		{
			tmpDouble = MBitConverter.ToDouble(mDynBuffer.getBuffer(), (int)mPos);
		}

		advPos(Double.SIZE);
	}

	return this;
}

- (ByteBuffer*) readMultiByte:(String)tmpStr len:(int)len gkCharSet:(GkEncode)gkCharSet
{
	MEncoding charSet = UtilSysLibsWrap.convGkEncode2EncodingEncoding(gkCharSet);

	// 如果是 unicode ，需要大小端判断
	if (canRead(len))
	{
		tmpStr = charSet.GetString(mDynBuffer.getBuffer(), (int)mPos, (int)len);
		advPos(len);
	}

	return this;
}

// 这个是字节读取，没有大小端的区别
- (ByteBuffer*) readBytes:(char[])tmpBytes, len:(int)len
{
	if (canRead(len))
	{
		MArray.Copy(mDynBuffer.getBuffer(), (int)mPos, tmpBytes, 0, (int)len);
		advPos(len);
	}

	return this;
}

// 如果要使用 writeInt8 ，直接使用 writeMultiByte 这个函数
- (void) writeInt8:(char)value
{
	if (!canWrite(Byte.SIZE))
	{
		extendDeltaCapicity(Byte.SIZE);
	}
	mDynBuffer.getBuffer()[mPos] = (byte)value;
	advPosAndLen(Byte.SIZE);
}

- (void) writeUnsignedInt8:(byte) value
{
	if (!canWrite(Byte.SIZE))
	{
		extendDeltaCapicity(Byte.SIZE);
	}
	mDynBuffer.getBuffer()[mPos] = value;
	advPosAndLen(Byte.SIZE);
}

- (void) writeInt16:(short) value
{
	if (!canWrite(Short.SIZE))
	{
		extendDeltaCapicity(Short.SIZE);
	}

	MBitConverter.GetBytes(value, mDynBuffer.getBuffer(), (int)mPos, mEndian);

	advPosAndLen(Short.SIZE);
}

- (void) writeUnsignedInt16:(short) value
{
	if (!canWrite(Short.SIZE))
	{
		extendDeltaCapicity(Short.SIZE);
	}

	MBitConverter.GetBytes(value, mDynBuffer.getBuffer(), (int)mPos, mEndian);

	advPosAndLen(Short.SIZE);
}

- (void) writeInt32:(int) value
{
	if (!canWrite(Integer.SIZE))
	{
		extendDeltaCapicity(Integer.SIZE);
	}

	MBitConverter.GetBytes(value, mDynBuffer.getBuffer(), (int)mPos, mEndian);

	advPosAndLen(Integer.SIZE);
}

- (void) writeUnsignedInt32:(int) value
{
	self->writeUnsignedInt32(value, true);
}

- (void) writeUnsignedInt32:(int) value bchangeLen:(BOOL) bchangeLen
{
	if (!canWrite(Integer.SIZE))
	{
		extendDeltaCapicity(Integer.SIZE);
	}

	MBitConverter.GetBytes(value, mDynBuffer.getBuffer(), (int)mPos, mEndian);

	if (bchangeLen)
	{
		advPosAndLen(Integer.SIZE);
	}
	else
	{
		advPos(Integer.SIZE);
	}
}

- (void) writeInt64:(long) value
{
	if (!canWrite(Long.SIZE))
	{
		extendDeltaCapicity(Long.SIZE);
	}

	MBitConverter.GetBytes(value, mDynBuffer.getBuffer(), (int)mPos, mEndian);

	advPosAndLen(Long.SIZE);
}

- (void) writeUnsignedInt64:(long) value
{
	if (!canWrite(Long.SIZE))
	{
		extendDeltaCapicity(Long.SIZE);
	}

	MBitConverter.GetBytes(value, mDynBuffer.getBuffer(), (int)mPos, mEndian);

	advPosAndLen(Long.SIZE);
}

- (void) writeFloat:(float) value
{
	if (!canWrite(Float.SIZE))
	{
		extendDeltaCapicity(Float.SIZE);
	}

	mWriteFloatBytes = MBitConverter.GetBytes(value);
	if (mEndian != SystemEndian.msLocalEndian)
	{
		MArray.Reverse(mWriteFloatBytes);
	}
	MArray.Copy(mWriteFloatBytes, 0, mDynBuffer.getBuffer(), mPos, Float.SIZE);

	advPosAndLen(Float.SIZE);
}

- (void) writeDouble:(double) value
{
	if (!canWrite(Double.SIZE))
	{
		extendDeltaCapicity(Double.SIZE);
	}

	mWriteDoubleBytes = MBitConverter.GetBytes(value);
	if (mEndian != SystemEndian.msLocalEndian)
	{
		MArray.Reverse(mWriteDoubleBytes);
	}
	MArray.Copy(mWriteDoubleBytes, 0, mDynBuffer.getBuffer(), mPos, Double.SIZE);

	advPosAndLen(Double.SIZE);
}

- (void) writeBytes:(char[]) value start:(int) start len:(int) len
{
	self->writeBytes(value, start, len, true);
}

// 写入字节， bchangeLen 是否改变长度
- (void) writeBytes:(char[]) value start:(int) start len:(int) len bchangeLen:(BOOL) bchangeLen
{
	if (len > 0)            // 如果有长度才写入
	{
		if (!canWrite(len))
		{
			extendDeltaCapicity(len);
		}
		MArray.Copy(value, start, mDynBuffer.getBuffer(), mPos, len);
		if (bchangeLen)
		{
			advPosAndLen(len);
		}
		else
		{
			advPos(len);
		}
	}
}

// 写入字符串
- (void) writeMultiByte:(String) value, gkCharSet:(GkEncode) gkCharSet len:(int) len
{
	MEncoding charSet = UtilSysLibsWrap.convGkEncode2EncodingEncoding(gkCharSet);
	(int) num = 0;

	if (nil != value)
	{
		//char[] charPtr = value.ToCharArray();
		num = charSet.GetByteCount(value);

		if (0 == len)
		{
			len = num;
		}

		if (!canWrite((int)len))
		{
			extendDeltaCapicity((int)len);
		}

		if (num < len)
		{
			MArray.Copy(charSet.GetBytes(value), 0, mDynBuffer.getBuffer(), mPos, num);
			// 后面补齐 0
			MArray.Clear(mDynBuffer.getBuffer(), (int)(mPos + num), len - num);
		}
		else
		{
			MArray.Copy(charSet.GetBytes(value), 0, mDynBuffer.getBuffer(), mPos, len);
		}
		advPosAndLen((int)len);
	}
	else
	{
		if (!canWrite(((int))len))
		{
			extendDeltaCapicity(((int))len);
		}

		advPosAndLen(((int))len);
	}
}

- (void) replace:(char[]) srcBytes srcStartPos:(int) srcStartPos
{
	self->replace(srcBytes, srcStartPos, 0, 0, 0);
}

- (void) replace:(char[]) srcBytes srcStartPos:(int) srcStartPos srclen_:(int) srclen_
{
	self->replace(srcBytes, srcStartPos, srclen_, 0, 0);
}

- (void) replace:(char[]) srcBytes srcStartPos:(int) srcStartPos srclen_:(int) srclen_ destStartPos:(int) destStartPos
{
	self->replace(srcBytes, srcStartPos, srclen_, destStartPos, 0);
}

// 替换已经有的一段数据
- (void) replace:(char[]) srcBytes srcStartPos:(int) srcStartPos srclen_:(int) srclen_ destStartPos:(int) destStartPos, destlen_:(int) destlen_)
{
	(int) lastLeft = self->getLength() - destStartPos - destlen_;        // 最后一段的长度
	self->setLength(destStartPos + srclen_ + lastLeft);      // 设置大小，保证足够大小空间

	self->setPosition(destStartPos + srclen_);
	if (lastLeft > 0)
	{
		writeBytes(mDynBuffer.getBuffer(), destStartPos + destlen_, lastLeft, false);          // 这个地方自己区域覆盖自己区域，可以保证自己不覆盖自己区域
	}

	self->setPosition(destStartPos);
	writeBytes(srcBytes, srcStartPos, srclen_, false);
}

- (void) insertUnsignedInt32:(int) value
{
	self->setLength(self->getLength() + Integer.SIZE);       // 扩大长度
	writeUnsignedInt32(value);     // 写入
}

- ByteBuffer* readUnsignedLongByOffset:(long) tmpUlong offset:(int) offset
{
	self->setPosition(offset);
	readUnsignedInt64(tmpUlong);
	return this;
}

// 写入 EOF 结束符
- (void) end
{
	mDynBuffer.getBuffer()[self->getLength()] = 0;
}

- ByteBuffer* readBoolean:(BOOL) tmpBool
{
	if (canRead(Byte.SIZE))
	{
		tmpBool = MBitConverter.ToBoolean(mDynBuffer.getBuffer(), ((int))mPos);
		advPos(Byte.SIZE);
	}

	return this;
}

@end
