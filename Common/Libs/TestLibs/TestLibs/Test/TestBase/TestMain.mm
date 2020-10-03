#import "Test/TestBase/TestMain.h"
#import "Test/TestSyntax/TestSyntax.h"
#import "Test/TestCode/TestCode.h"

@implementation TestMain

- (id) init
{
    if(self = [super init])
    {
        self->_TestSyntax = [[TestSyntax alloc] init];
        self->_TestCode = [[TestCode alloc] init];
    }
    
    return self;
}

- (void) dispose
{

}

- (void) run
{
    [self->_TestCode run];
}

@end
