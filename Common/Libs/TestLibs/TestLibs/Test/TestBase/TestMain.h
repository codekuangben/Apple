#import "MyLibs/Base/GObject.h"

@class TestSyntax;

@interface TestMain : GObject
{
    TestSyntax* _TestSyntax;
}

- (id) init;
- (void) dispose;
- (void) run;

@end
