#import "Test/TestSyntax/TestSyntax.h"
#import "Test/TestSyntax/TestSyntaxClassAa.h"

@implementation TestSyntax

- (id) init
{
    if(self = [super init])
    {
        
    }
    
    return self;
}

- (void) run
{
    [super run];
    [self _testA];
    [self _testB];
}

- (void) _testA
{
    TestSyntaxClassAa* TestSyntaxClassAa = [[TestSyntaxClassAa alloc] init]
}

- (void) _testB
{
    TestSyntaxClassAa* testSyntaxClassAa = [[TestSyntaxClassAa alloc] init]
}

@end