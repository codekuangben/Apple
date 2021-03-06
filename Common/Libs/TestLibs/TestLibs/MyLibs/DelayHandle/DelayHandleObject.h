#import "MyLibs/DelayHandle/IDelayHandleItem.h"
#import "MyLibs/DelayHandle/DelayHandleParamBase.h"
#import "MyLibs/Base/GObject.h"

@interface DelayHandleObject : GObject
{
@public
    GObject<IDelayHandleItem>* mDelayObject;
    DelayHandleParamBase* mDelayParam;
}

//@property (nonatomic, readwrite/*, retain*/) GObject<IDelayHandleItem>* mDelayObject;
//@property (nonatomic, readwrite/*, retain*/) DelayHandleParamBase* mDelayParam;

- (id) init;

@end
