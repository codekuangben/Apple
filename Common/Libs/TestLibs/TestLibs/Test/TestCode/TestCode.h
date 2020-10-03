#import <Foundation/Foundation.h>
#import "Test/TestBase/TestBase.h"
#import "MyLibs/Base/GObject.h"
#import "MyLibs/EventHandle/IDispatchObject.h"

@interface TestCode : TestBase
{

}

- (id) init;
- (void) run;
- (void) _onEventHandle:GObject<IDispatchObject>* dispatchObject userParam:(id)userParam;

@end
