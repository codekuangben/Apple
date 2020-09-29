#import "Lib/EventHandle/ICalleeObjectNoRetNoParam.h"

@interface LoopDepth
{
    @private 
    int mLoopDepth;         // 是否在循环中，支持多层嵌套，就是循环中再次调用循环
    ICalleeObjectNoRetNoParam mIncHandle;     // 增加处理器
    ICalleeObjectNoRetNoParam mDecHandle;     // 减少处理器
    ICalleeObjectNoRetNoParam mZeroHandle;    // 减少到 0 处理器
}

- (id) init;
- (void) setIncHandle:(ICalleeObjectNoRetNoParam*) value;
- (void) setDecHandle:(ICalleeObjectNoRetNoParam*) value;
- (void) setZeroHandle:(ICalleeObjectNoRetNoParam*) value;
- (void) incDepth;
- (void) decDepth;
- (BOOL) isInDepth;

@end