package SDK.Lib.FrameHandle;

import SDK.Lib.DataStruct.MList;
import SDK.Lib.DelayHandle.DelayHandleMgrBase;
import SDK.Lib.DelayHandle.IDelayHandleItem;
import SDK.Lib.Tools.UtilApi;

@interface ResizeMgr : DelayHandleMgrBase implements ITickedObject, IDelayHandleItem
{
    protected (int) mPreWidth;       // 之前宽度
    protected (int) mPreHeight;
    protected (int) mCurWidth;       // 现在宽度
    protected (int) mCurHeight;

    protected (int) mCurHalfWidth;       // 当前一半宽度
    protected (int) mCurHalfHeight;

    protected MList<IResizeObject> mResizeList;

    public ResizeMgr()
    {
        self.mResizeList = new MList<IResizeObject>();
    }

    @Override
    public (void) init()
    {

    }

    @Override
    public (void) dispose()
    {
        self.mResizeList.Clear();
    }

    public (int) getWidth()
    {
        return self.mCurWidth;
    }

    public (int) getHeight()
    {
        return self.mCurHeight;
    }

    public (int) getHalfWidth()
    {
        return self.mCurHalfWidth;
    }

    public (int) getHalfHeight()
    {
        return self.mCurHalfHeight;
    }

    @Override
    protected (void) addObject(IDelayHandleItem delayObject)
    {
        self.addObject(delayObject, 0);
    }

    @Override
    protected (void) addObject(IDelayHandleItem delayObject, float priority)
    {
        if(self.mLoopDepth.isInDepth())
        {
            super.addObject(delayObject, priority);
        }
        else
        {
            self.addResizeObject((IResizeObject)delayObject, priority);
        }
    }

    @Override
    protected (void) removeObject(IDelayHandleItem delayObject)
    {
        if(self.mLoopDepth.isInDepth())
        {
            super.removeObject(delayObject);
        }
        else
        {
            self.removeResizeObject((IResizeObject)delayObject);
        }
    }

    public (void) addResizeObject(IResizeObject obj)
    {
        self.addResizeObject(obj, 0);
    }

    public (void) addResizeObject(IResizeObject obj, float priority)
    {
        if (!self.mResizeList.Contains(obj))
        {
            self.mResizeList.Add(obj);
        }
    }

    public (void) removeResizeObject(IResizeObject obj)
    {
        if (self.mResizeList.IndexOf(obj) != -1)
        {
            self.mResizeList.Remove(obj);
        }
    }

    public (void) onTick(float delta)
    {
        self.mPreWidth = self.mCurWidth;
        self.mCurWidth = UtilApi.getScreenWidth();
        self.mCurHalfWidth = self.mCurWidth / 2;

        self.mPreHeight = self.mCurHeight;
        self.mCurHeight = UtilApi.getScreenHeight();
        self.mCurHalfHeight = self.mCurHeight / 2;

        if (self.mPreWidth != self.mCurWidth || self.mPreHeight != self.mCurHeight)
        {
            self.onResize(self.mCurWidth, self.mCurHeight);
        }
    }

    public (void) onResize((int) viewWidth, (int) viewHeight)
    {
        for(IResizeObject resizeObj : mResizeList.list())
        {
            resizeObj.onResize(viewWidth, viewHeight);
        }
    }

    public (void) setClientDispose(boolean isDispose)
    {

    }

    public boolean isClientDispose()
    {
        return false;
    }
}