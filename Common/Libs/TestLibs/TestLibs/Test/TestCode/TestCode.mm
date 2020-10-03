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
    SEL eventHandle = @selector(_onEventHandle:userParam:);
    //SEL eventHandle = [self @selector(_onEventHandle:userParam:)];
    //[eventDispatch addEventHandle:self eventHandle:[self @selector(_onEventHandle:userParam:)]];
    [eventDispatch addEventHandle:self eventHandle:eventHandle];
    [eventDispatch dispatchEvent:nil];
}

- (void) _onEventHandle:(GObject<IDispatchObject>*) dispatchObject userParam:(id)userParam
{
    [UtilLog log:@"aaa"];
}

- (void) call: (GObject<IDispatchObject>*) dispatchObject
{
    
}

@end
