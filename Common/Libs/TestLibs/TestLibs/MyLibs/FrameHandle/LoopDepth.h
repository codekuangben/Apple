#import "MyLibs/EventHandle/EventDispatchFunctionObject.h"
#import "MyLibs/Base/GObject.h"

@interface LoopDepth : GObject
{
    @private 
    int mLoopDepth;         // 是否在循环中，支持多层嵌套，就是循环中再次调用循环
    EventDispatchFunctionObject* mIncHandle;     // 增加处理器
    EventDispatchFunctionObject* mDecHandle;     // 减少处理器
    EventDispatchFunctionObject* mZeroHandle;    // 减少到 0 处理器
}

- (id) init;
- (void) setIncHandle:(GObject<IListenerObject>*) eventListener eventHandle:(SEL) eventHandle;
- (void) setDecHandle:(GObject<IListenerObject>*) eventListener eventHandle:(SEL) eventHandle;
- (void) setZeroHandle:(GObject<IListenerObject>*) eventListener eventHandle:(SEL) eventHandle;
- (void) incDepth;
- (void) decDepth;
- (BOOL) isInDepth;

@end
