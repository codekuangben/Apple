#import "ResInsEventDispatch.h"
#import "EventDispatch.h"
#import "IDispatchObject.h"

/**
* @brief 资源实例化事件分发器
*/
@implementation ResInsEventDispatch

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

@end