#import "MyLibs/Base/GObject.h"

@interface UniqueNumIdGen : GObject
{
@protected
    int mPreIdx;
    int mCurId;
}

- (id) init: (int) baseUniqueId;
- (int) genNewId;
- (int) getCurId;

@end