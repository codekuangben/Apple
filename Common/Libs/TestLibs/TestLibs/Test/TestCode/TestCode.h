#import <Foundation/Foundation.h>
#import "Test/TestBase/TestBase.h"
#import "MyLibs/Base/GObject.h"
#import "MyLibs/EventHandle/IDispatchObject.h"
#import "MyLibs/EventHandle/ICalleeObject.h"

@interface TestCode : TestBase <ICalleeObject>
{

}

- (id) init;
- (void) run;
- (void) _onEventHandle:(GObject<IDispatchObject>*) dispatchObject userParam:(id)userParam;
- (void) call: (GObject<IDispatchObject>*) dispObj;

@end
