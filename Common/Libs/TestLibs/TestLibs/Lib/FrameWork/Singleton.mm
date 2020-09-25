﻿package SDK.Lib.FrameWork;

import SDK.Lib.Tools.TClassOp;

@interface Singleton<T>
{
    // 模板对象不能是静态对象
    //protected static T msSingleton;
    protected static Object msSingleton;

    //public Singleton(Class<T> classT)

    public static Object getSingletonPtr()
    {
        if (null == msSingleton)
        {
            //msSingleton = TClassOp.createObject();
            //msSingleton.init();
        }

        return msSingleton;
    }

    public static (void) deleteSingletonPtr()
    {
        if (null != msSingleton)
        {
            //msSingleton.dispose();
            msSingleton = null;
        }
    }
}