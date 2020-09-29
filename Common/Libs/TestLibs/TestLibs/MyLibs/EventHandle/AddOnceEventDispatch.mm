﻿#import "AddOnceEventDispatch.h"

/**
* @brief 事件回调函数只能添加一次
*/
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

- ((void)) addEventHandle: (ICalleeObject) pThis and: (IDispatchObject) handle
{
	// 这个判断说明相同的函数只能加一次，但是如果不同资源使用相同的回调函数就会有问题，但是这个判断可以保证只添加一次函数，值得，因此不同资源需要不同回调函数
	if (![this isExistEventHandle: pThis and: handle])
	{
		[super addEventHandle: pThis, and: handle];
	}
}

@end