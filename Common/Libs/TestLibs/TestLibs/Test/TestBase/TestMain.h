#import "MyLibs/Base/GObject.h"

@class id;
@class TestSyntax;

@interface TestMain : NSObject
{
    TestSyntax* _TestSyntax;
}

- (id) init;
- (void) dispose;
- (void) run;

@end