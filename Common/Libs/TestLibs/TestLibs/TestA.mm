#import "TestA.h"

static int msB = 0;

@implementation TestA

//static int msB = 0;

+ (void) setB: (int) paramB
{
    msB = paramB;
}

- (id) init
{
    if(self = [super init])
    {
        mA = 10;
    }
    
    return self;
}

- (void) dealloc
{
    //dealloc 不可以人为调用
    [super dealloc];
}

- (void) setA: (int) paramA
{
    mA = paramA;
}

- (void) setAll: (int) paramA paramStr: (NSString*) paramC
{
    mA = paramA;
    mStr = paramC;
}

- (NSString*) stepMsg
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

@end
