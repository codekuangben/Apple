#import "MyLibs/Base/GObject.h"

@interface DynBufResizePolicy : GObject

// 获取一个最近的大小
+ (int) getCloseSize:(int) needSize capacity:(int) capacity maxCapacity:(int) maxCapacity;

@end
