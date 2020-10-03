#import "MyLibs/EventHandle/ResInsEventDispatch.h"
#import "MyLibs/EventHandle/EventDispatch.h"
#import "MyLibs/EventHandle/IDispatchObject.h"

@implementation ResInsEventDispatch

- (id) init
{
    if(self = [super init])
    {
		self->mIsValid = YES;
    }
    
    return self;
}

- (void) setIsValid: (BOOL) value
{
	self->mIsValid = value;
}

- (BOOL) getIsValid
{
	return self->mIsValid;
}

- (void) setInsGO: (GObject*) go
{
	self->mInsGO = go;
}

- (NSObject*) getInsGO
{
	return self->mInsGO;
}

- (void) dispatchEvent: (GObject<IDispatchObject>*) dispatchObject
{
	if(self->mIsValid)
	{
		[super dispatchEvent: dispatchObject];
	}
	else
	{
		self->mInsGO = nil;
	}
}

@end
