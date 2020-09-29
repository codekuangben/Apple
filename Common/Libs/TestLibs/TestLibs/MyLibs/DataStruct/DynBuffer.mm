#import "MyLibs/DataStruct/DynBuffer.h"

@implementation DynBuffer

- (id)init      // mono 模板类中使用常亮报错， vs 可以
{
	self = [self init:1 * 1024/*DataCV.INIT_CAPACITY*/ maxCapacity: 8 * 1024 * 1024/*DataCV.MAX_CAPACITY*/];
}

- (id) init:(int) initCapacity
{
	[self init:initCapacity, maxCapacity: 8 * 1024 * 1024/*DataCV.MAX_CAPACITY*/];
}

- (id) init:(int) initCapacity maxCapacity:(int) maxCapacity      // mono 模板类中使用常亮报错， vs 可以
{
	self.mMaxCapacity = maxCapacity;
	self.mCapacity = initCapacity;
	self.mSize = 0;
	//self.mBuffer = new T[mCapacity];
	//self.mBuffer = (T[]) new Object[self.mCapacity];
	self.mBuffer = self.createArray(mClassT, self.mCapacity);
}

// 获取模板类型
- Class getTClass:(int) index
{
	Type genType = getClass().getGenericSuperclass();

	if (!(genType instanceof ParameterizedType))
	{
		return Object.class;
	}

	Type[] params = ((ParameterizedType) genType).getActualTypeArguments();

	if (index >= params.length || index < 0)
	{
		throw new RuntimeException("Index outof bounds");
	}

	if (!(params[index] instanceof Class))
	{
		return Object.class;
	}

	return (Class) params[index];
}

- T createObject()
{
	Constructor constructor = null;

	try
	{
		constructor = mClassT.getConstructor(new Class[]{});
	}
	catch(Exception e)
	{

	}

	T ret = null;

	try
	{
		if(null != constructor)
		{
			ret = (T) constructor.newInstance();
		}
	}
	catch(Exception e)
	{

	}

	return ret;
}

- T[] createArray(Class<T> type, (int) initCapacity)
{
	return (T[]) Array.newInstance(type, initCapacity);
}

- T[] getBuffer()
{
	return self.mBuffer;
}

- (void) setBuffer(T[] value)
{
	self.mBuffer = value;
	self.mCapacity = ((int))self.mBuffer.length;
}

- (int) getMaxCapacity()
{
	return self.mMaxCapacity;
}

- (void) setMaxCapacity((int) value)
{
	self.mMaxCapacity = value;
}

- (int) getCapacity()
{
		return self.mCapacity;
}

- (void) setCapacity((int) value)
{
	if (value == self.mCapacity)
	{
		return;
	}
	if (value < self.getSize())       // 不能分配比当前已经占有的空间还小的空间
	{
		return;
	}
	//T[] tmpbuff = new T[value];   // 分配新的空间
	//T[] tmpbuff = (T[]) new Object[value];
	T[] tmpbuff = self.createArray(mClassT, self.mCapacity);
	MArray.Copy(self.mBuffer, 0, tmpbuff, 0, self.mSize);  // 这个地方是 mSize 还是应该是 mCapacity，如果是 CircleBuffer 好像应该是 mCapacity，如果是 ByteBuffer ，好像应该是 mCapacity。但是 DynBuffer 只有 ByteBuffer 才会使用这个函数，因此使用 mSize 就行了，但是如果使用 mCapacity 也没有问题

	self.mBuffer = tmpbuff;
	self.mCapacity = value;
}

- (int) getSize()
{
	return self.mSize;
}

- (void) setSize((int) value)
{
	if (value > self.getCapacity())
	{
		self.extendDeltaCapicity(value - self.getSize());
	}

	self.mSize = value;
}

- (void) extendDeltaCapicity((int) delta)
{
	self.setCapacity(DynBufResizePolicy.getCloseSize(self.getSize() + delta, self.getCapacity(), self.getMaxCapacity()));
}

@end