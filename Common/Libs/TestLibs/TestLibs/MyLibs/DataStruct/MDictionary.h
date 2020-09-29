@interface MDictionary<TKey, TValue>
{
    // 注：Dictionary 此类已过时。新的实现应该实现 Map 接口，而不是扩展此类。
    protected
    Map<TKey, TValue> mData;

    public MDictionary()
    {
        mData = new HashMap<TKey, TValue>();
    }

    public Map<TKey, TValue> getData()
    {
        return self.mData;
    }

    public (int) getCount()
    {
        return self.mData.keySet().size();
    }

    public TValue get(TKey key)
    {
        return self.value(key);
    }

    public (void) set(TKey key, TValue value)
    {
        self.Add(key, value);
    }

    public TValue value(TKey key)
    {
        if (self.mData.containsKey(key))
        {
            return self.mData.get(key);
        }

        return null;
    }

    public TKey key(TValue value)
    {
        for (TKey key : self.mData.keySet())
        {
            if (self.mData.get(key).equals(value))
            //if (kv.Value == value)
            {
                return key;
            }
        }

        return null;
    }

    public Set<TKey> getKeys()
    {
        return self.mData.keySet();
    }

    public Collection<TValue> getValues()
    {
        return self.mData.values();
    }

    public (int) Count()
    {
        return self.mData.keySet().size();
    }

    public Set<Map.Entry<TKey,TValue>> GetEnumerator()
    {
        return self.mData.entrySet();
    }

    public (void) Add(TKey key, TValue value)
    {
        self.mData.put(key, value);
    }

    public (void) Remove(TKey key)
    {
        self.mData.remove(key);
    }

    public (void) Clear()
    {
        self.mData.clear();
    }

    public BOOL TryGetValue(TKey key, TValue value)
    {
        value = self.mData.get(key);
        return true;
    }

    public BOOL ContainsKey(TKey key)
    {
        return self.mData.containsKey(key);
    }

    public BOOL ContainsValue(TValue value)
    {
        for (TKey key : self.mData.keySet())
        {
            if (self.mData.get(key).equals(value))
            //if (kv.Value == value)
            {
                return true;
            }
        }

        return false;
    }

    public TValue at((int) idx)
    {
        (int) curidx = 0;
        TValue ret = null;

        for (TKey key : self.mData.keySet())
        {
            if(curidx == idx)
            {
                ret = self.mData.get(key);
                break;
            }
        }

        return ret;
    }
}