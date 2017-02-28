#ifndef __UniqueNumIdGen_h
#define __UniqueNumIdGen_h

#import "GObject.h"

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

#endif
