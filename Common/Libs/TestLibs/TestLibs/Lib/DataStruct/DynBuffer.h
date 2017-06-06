package SDK.Lib.DataStruct;

import java.lang.reflect.Array;
import java.lang.reflect.Constructor;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;

/**
 * @brief 动态增长的缓冲区，不是环形的，从 0 开始增长的
 */
public class DynBuffer<T>
{
    public int mCapacity;         // 分配的内存空间大小，单位大小是字节
    public int mMaxCapacity;      // 最大允许分配的存储空间大小
    public int mSize;              // 存储在当前缓冲区中的数量
    public T[] mBuffer;            // 当前环形缓冲区

    private Class<T> mClassT;   // 传递的模板类型的类型信息

    public DynBuffer()      // mono 模板类中使用常亮报错， vs 可以
    {
        this(1 * 1024/*DataCV.INIT_CAPACITY*/, 8 * 1024 * 1024/*DataCV.MAX_CAPACITY*/);
    }

    public DynBuffer(int initCapacity)
    {
        this(initCapacity, 8 * 1024 * 1024/*DataCV.MAX_CAPACITY*/);
    }

    public DynBuffer(int initCapacity, int maxCapacity)      // mono 模板类中使用常亮报错， vs 可以
    {
        self.mMaxCapacity = maxCapacity;
        self.mCapacity = initCapacity;
        self.mSize = 0;
        //self.mBuffer = new T[mCapacity];
        //self.mBuffer = (T[]) new Object[self.mCapacity];
        self.mBuffer = self.createArray(mClassT, self.mCapacity);
    }

    // 获取模板类型
    public Class getTClass(int index)
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

    public T createObject()
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

    public T[] createArray(Class<T> type, int initCapacity)
    {
        return (T[]) Array.newInstance(type, initCapacity);
    }

    public T[] getBuffer()
    {
        return self.mBuffer;
    }

    public void setBuffer(T[] value)
    {
        self.mBuffer = value;
        self.mCapacity = (int)self.mBuffer.length;
    }

    public int getMaxCapacity()
    {
        return self.mMaxCapacity;
    }

    public void setMaxCapacity(int value)
    {
        self.mMaxCapacity = value;
    }

    public int getCapacity()
    {
            return self.mCapacity;
    }

    public void setCapacity(int value)
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

    public int getSize()
    {
        return self.mSize;
    }

    public void setSize(int value)
    {
        if (value > self.getCapacity())
        {
            self.extendDeltaCapicity(value - self.getSize());
        }

        self.mSize = value;
    }

    public void extendDeltaCapicity(int delta)
    {
        self.setCapacity(DynBufResizePolicy.getCloseSize(self.getSize() + delta, self.getCapacity(), self.getMaxCapacity()));
    }
}