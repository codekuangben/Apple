#import "MyLibs/DataStruct/DynByteBuffer.h"

@implementation DynByteBuffer

- (id) init
{
    this(1 * 1024/*DataCV.INIT_CAPACITY*/, 8 * 1024 * 1024/*DataCV.MAX_CAPACITY*/);
}

- (id) initWithParams:(int) initCapacity (int) maxCapacity;
{
    self->mMaxCapacity = maxCapacity;
    self->mCapacity = initCapacity;
    self->mSize = 0;
    self->mBuffer = new byte[mCapacity];
}

- (byte[]) getBuffer
{
    return self->mBuffer;
}

- (void) setBuffer:(byte[]) value
{
    self->mBuffer = value;
    self->mCapacity = ((int))self->mBuffer.length;
}

- (int) getMaxCapacity
{
    return self->mMaxCapacity;
}

- (void) setMaxCapacity:(int) value
{
    self->mMaxCapacity = value;
}

- (int) getCapacity
{
    return self->mCapacity;
}

- (void) setCapacity:(int) value
{
    if (value == self->mCapacity)
    {
        return;
    }
    if (value < self->getSize())       // 不能分配比当前已经占有的空间还小的空间
    {
        return;
    }
    byte[] tmpbuff = new byte[value];   // 分配新的空间
    MArray.Copy(self->mBuffer, 0, tmpbuff, 0, self->mSize);  // 这个地方是 mSize 还是应该是 mCapacity，如果是 CircleBuffer 好像应该是 mCapacity，如果是 ByteBuffer ，好像应该是 mCapacity。但是 DynBuffer 只有 ByteBuffer 才会使用这个函数，因此使用 mSize 就行了，但是如果使用 mCapacity 也没有问题

    self->mBuffer = tmpbuff;
    self->mCapacity = value;
}

- (int) getSize
{
    return self->mSize;
}

- (void) setSize:(int) value
{
    if (value > self->getCapacity())
    {
        self->extendDeltaCapicity(value - self->getSize());
    }

    self->mSize = value;
}

- (void) extendDeltaCapicity:(int) delta
{
    self->setCapacity(DynBufResizePolicy.getCloseSize(self->getSize() + delta, self->getCapacity(), self->getMaxCapacity()));
}

@end