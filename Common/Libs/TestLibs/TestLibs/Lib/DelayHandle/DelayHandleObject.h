#ifndef __DelayHandleObject_h
#define __DelayHandleObject_h

#import "IDelayHandleItem.h"
#import "DelayHandleParamBase.h"

@interface DelayHandleObject
{
@public
    
}

@property (nonatomic, readwrite, retain) IDelayHandleItem mDelayObject;
@property (nonatomic, readwrite, retain) DelayHandleParamBase mDelayParam;

- (id) init;

@end

#endif