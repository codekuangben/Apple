#ifndef __EventDispatchGroup_h
#define __EventDispatchGroup_h

#import "EventDispatch.h"
#import "IDispatchObject.h"

/**
 * @brief 资源实例化事件分发器
 */
@interface ResInsEventDispatch : EventDispatch, IDispatchObject
{
    protected boolean mIsValid;
    protected Object mInsGO;

    public ResInsEventDispatch()
    {
        this.mIsValid = true;
    }

    public void setIsValid(boolean value)
    {
        this.mIsValid = value;
    }

    public boolean getIsValid()
    {
        return this.mIsValid;
    }

    public void setInsGO(Object go)
    {
        this.mInsGO = go;
    }

    public Object getInsGO()
    {
        return this.mInsGO;
    }

    @Override
    public void dispatchEvent(IDispatchObject dispatchObject)
    {
        if(this.mIsValid)
        {
            super.dispatchEvent(dispatchObject);
        }
        else
        {
            this.mInsGO = null;
        }
    }
}

@end

#endif