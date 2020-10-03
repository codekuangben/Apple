#import "Test/TestCode/TestCode.h"
#import "MyLibs/EventHandle/EventDispatch.h"
#import "MyLibs/Tools/UtilLog.h"

@implementation TestCode

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
}

- (void) _testA
{
    EventDispatch* eventDispatch = [[EventDispatch alloc] init];
    [eventDispatch addEventHandle:self handle:[self @selector(_onEventHandle:userParam:)]];
    [eventDispatch dispatchEvent:nil];
}

- (void) _onEventHandle:(GObject<IDispatchObject>*) dispatchObject userParam:(id)userParam
{
    [UtilLog log:@"aaa"];
}

@end
