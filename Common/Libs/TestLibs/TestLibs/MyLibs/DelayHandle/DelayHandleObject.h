#import "MyLibs/DelayHandle/IDelayHandleItem.h"
#import "MyLibs/DelayHandle/DelayHandleParamBase.h"

@interface DelayHandleObject
{
@public
    
}

@property (nonatomic, readwrite, retain) IDelayHandleItem mDelayObject;
@property (nonatomic, readwrite, retain) DelayHandleParamBase mDelayParam;

- (id) init;

@end