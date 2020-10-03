#import "MyLibs/Base/GObject.h"

@class TestSyntax;
@class TestCode;

@interface TestMain : GObject
{
    TestSyntax* _TestSyntax;
    TestCode* _TestCode;
}

- (id) init;
- (void) dispose;
- (void) run;

@end
