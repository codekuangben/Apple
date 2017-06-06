package SDK.Lib.DataStruct;

import java.util.ArrayList;
import java.util.List;

/**
 * @brief 对系统 List 的封装
 */
public class MList<T>
{
    //public delegate int CompareFunc(T left, T right);

    protected ArrayList<T> mList;
    protected int mUniqueId;       // 唯一 Id ，调试使用

    protected MDictionary<T, Integer> mDic;    // 为了加快查找速度，当前 Element 到索引映射
    protected boolean mIsSpeedUpFind;  // 是否加快查询

    public MList()
    {
        self.mList = new ArrayList<T>();
        self.mDic = new MDictionary<T, Integer>();
        self.mIsSpeedUpFind = true;
    }

    public MList(int capacity)
    {
        self.mList = new ArrayList<T>(capacity);
    }

    public T[] ToArray()
    {
        return (T[])self.mList.toArray();
    }

    public List<T> list()
    {
        return self.mList;
    }

    public int getUniqueId()
    {
        return self.mUniqueId;
    }

    public void setUniqueId(int value)
    {
        self.mUniqueId = value;
    }

    public List<T> getBuffer()
    {
        return self.mList;
    }

    public int getSize()
    {
        return self.mList.size();
    }

    public void Add(T item)
    {
        self.mList.add(item);

        if (self.mIsSpeedUpFind)
        {
            self.mDic.set(item, self.mList.size() - 1);
        }
    }

    // 主要是 Add 一个 float 类型的 Vector3
    public void Add(T item_1, T item_2, T item_3)
    {
        self.mList.add(item_1);
        self.mList.add(item_2);
        self.mList.add(item_3);

        if(self.mIsSpeedUpFind)
        {
            self.mDic.set(item_1, self.mList.size() - 3);
            self.mDic.set(item_2, self.mList.size() - 2);
            self.mDic.set(item_3, self.mList.size() - 1);
        }
    }

    // 主要是 Add 一个 float 类型的 UV
    public void Add(T item_1, T item_2)
    {
        self.mList.add(item_1);
        self.mList.add(item_2);

        if (self.mIsSpeedUpFind)
        {
            self.mDic.set(item_1, self.mList.size() - 2);
            self.mDic.set(item_2, self.mList.size() - 1);
        }
    }

    // 主要是 Add 一个 byte 类型的 Color32
    public void Add(T item_1, T item_2, T item_3, T item_4)
    {
        self.mList.add(item_1);
        self.mList.add(item_2);
        self.mList.add(item_3);
        self.mList.add(item_4);

        if (self.mIsSpeedUpFind)
        {
            self.mDic.set(item_1, self.mList.size() - 4);
            self.mDic.set(item_2, self.mList.size() - 3);
            self.mDic.set(item_3, self.mList.size() - 2);
            self.mDic.set(item_4, self.mList.size() - 1);
        }
    }

    public void push(T item)
    {
        self.mList.add(item);

        if (self.mIsSpeedUpFind)
        {
            self.mDic.set(item, self.mList.size() - 1);
        }
    }

    public boolean Remove(T item)
    {
        if (self.mIsSpeedUpFind)
        {
            return self.effectiveRemove(item);
        }
        else
        {
            return self.mList.remove(item);
        }
    }

    public T get(int index)
    {
        return self.mList.get(index);
    }

    public void set(int index, T value)
    {
        if (self.mIsSpeedUpFind)
        {
            self.mDic.set(value, index);
        }

        self.mList.add(index, value);
    }

    public void Clear()
    {
        self.mList.clear();

        if (self.mIsSpeedUpFind)
        {
            self.mDic.Clear();
        }
    }

    public int Count()
    {
        return self.mList.size();
    }

    public int length()
    {
        return self.mList.size();
    }

    public void setLength(int value)
    {
        self.mList.ensureCapacity(value);
    }

    public void RemoveAt(int index)
    {
        if (self.mIsSpeedUpFind)
        {
            self.effectiveRemove(self.mList.get(index));
        }
        else
        {
            self.mList.remove(index);
        }
    }

    public int IndexOf(T item)
    {
        if (self.mIsSpeedUpFind)
        {
            if (self.mDic.ContainsKey(item))
            {
                return self.mDic.get(item);
            }
            else
            {
                return -1;
            }
        }
        else
        {
            return self.mList.indexOf(item);
        }
    }

    public void Insert(int index, T item)
    {
        if (index <= self.Count())
        {
            if (self.mIsSpeedUpFind)
            {
                self.mDic.set(item, index);
            }

            //self.mList.Insert(index, item);
            self.mList.add(index, item);

            if (self.mIsSpeedUpFind)
            {
                self.updateIndex(index + 1);
            }
        }
        else
        {

        }
    }

    public boolean Contains(T item)
    {
        if (self.mIsSpeedUpFind)
        {
            return self.mDic.ContainsKey(item);
        }
        else
        {
            return self.mList.contains(item);
        }
    }

//    public void Sort(System.Comparison<T> comparer)
//    {
//        self.mList.Sort(comparer);
//    }

    public void merge(MList<T> appendList)
    {
        if(appendList != null)
        {
            for(T item : appendList.list())
            {
                self.mList.add(item);

                if (self.mIsSpeedUpFind)
                {
                    self.mDic.set(item, self.mList.size() - 1);
                }
            }
        }
    }

    // 快速移除元素
    protected boolean effectiveRemove(T item)
    {
        boolean ret = false;

        if (self.mDic.ContainsKey(item))
        {
            ret = true;

            int idx = self.mDic.get(item);
            self.mDic.Remove(item);

            if (idx == self.mList.size() - 1)    // 如果是最后一个元素，直接移除
            {
                //self.mList.RemoveAt(idx);
                self.mList.remove(idx);
            }
            else
            {
                self.mList.set(idx, self.mList.get(self.mList.size() - 1));
                //self.mList.RemoveAt(self.mList.size() - 1);
                self.mList.remove(self.mList.size() - 1);
                self.mDic.set(self.mList.get(idx), idx);
            }
        }

        return ret;
    }

    protected void updateIndex(int idx)
    {
        int len = self.mList.size();

        while(idx < len)
        {
            self.mDic.set(self.mList.get(idx), idx);

            ++idx;
        }
    }
}