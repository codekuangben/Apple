#import "MyLibs/EventHandle/AddOnceEventDispatch.h"

@implementation AddOnceEventDispatch

- (id) init
{
    if(self = [super init])
    {
        [self init: 0];
    }
    
    return self;
}

- (id) init: (int) eventId_
{
    if(self = [super init: eventId_])
    {
        
    }
    
    return self;
}

- (void) addEventHandle: (GObject<IListenerObject>*) eventListener eventHandle: (GObject<IDispatchObject>*) eventHandle
{
	// 这个判断说明相同的函数只能加一次，但是如果不同资源使用相同的回调函数就会有问题，但是这个判断可以保证只添加一次函数，值得，因此不同资源需要不同回调函数
	if (![self isExistEventHandle: eventListener and: eventHandle])
	{
		[super addEventHandle: eventListener and: eventHandle];
	}
}

@end
