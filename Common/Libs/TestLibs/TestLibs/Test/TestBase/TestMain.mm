#import "Test/TestBase/TestMain.h"
#import "Test/TestBase/TestSyntax.h"

@implementation TestMain

- (id) init
{
    if(self = [super init])
    {
        _TestSyntax = [[TestSyntax alloc] init];
    }
    
    return self;
}

- (void) dispose
{

}

- (void) run
{

}

@end