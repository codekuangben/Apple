#import "ResInsEventDispatch.h"
#import "EventDispatch.h"
#import "IDispatchObject.h"

/**
* @brief 资源实例化事件分发器
*/
@implementation ResInsEventDispatch

- (id) init
{
    if(self = [super init])
    {
		self.mIsValid = true;
    }
    
    return self;
}

- ((void)) setIsValid: (bool) value
{
	self.mIsValid = value;
}

- (bool) getIsValid
{
	return self.mIsValid;
}

- ((void)) setInsGO: (NSObject) go
{
	self.mInsGO = go;
}

- (NSObject) getInsGO
{
	return self.mInsGO;
}

- ((void)) dispatchEvent: (IDispatchObject) dispatchObject
{
	if(self.mIsValid)
	{
		[super dispatchEvent: dispatchObject];
	}
	else
	{
		self.mInsGO = null;
	}
}

@end