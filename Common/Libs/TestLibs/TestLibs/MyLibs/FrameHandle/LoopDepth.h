#import "MyLibs/EventHandle/ICalleeObjectNoRetNoParam.h"
#import "MyLibs/Base/GObject.h"

@interface LoopDepth : GObject
{
    @private 
    int mLoopDepth;         // 是否在循环中，支持多层嵌套，就是循环中再次调用循环
    GObject<ICalleeObjectNoRetNoParam>* mIncHandle;     // 增加处理器
    GObject<ICalleeObjectNoRetNoParam>* mDecHandle;     // 减少处理器
    GObject<ICalleeObjectNoRetNoParam>* mZeroHandle;    // 减少到 0 处理器
}

- (id) init;
- (void) setIncHandle:(GObject<ICalleeObjectNoRetNoParam>*) value;
- (void) setDecHandle:(GObject<ICalleeObjectNoRetNoParam>*) value;
- (void) setZeroHandle:(GObject<ICalleeObjectNoRetNoParam>*) value;
- (void) incDepth;
- (void) decDepth;
- (BOOL) isInDepth;

@end
