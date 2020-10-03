#import "MyLibs/Base/GObject.h"

@interface Singleton : GObject
{
@protected 
    id msSingleton;
}

- (id) getSingletonPtr;
- (void) deleteSingletonPtr;

@end
