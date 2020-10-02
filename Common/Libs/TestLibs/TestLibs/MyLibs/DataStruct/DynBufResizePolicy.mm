#import "MyLibs/DataStruct/DynBufResizePolicy.h"

@implementation DynBufResizePolicy

+ (int) getCloseSize:(int) needSize capacity:(int) capacity maxCapacity:(int) maxCapacity
{
    int ret = 0;
    if (capacity > needSize)        // 使用 > ，不适用 >= ，浪费一个自己，方便判断
    {
        ret = capacity;
    }
    else
    {
        ret = 2 * capacity;
        while (ret < needSize && ret < maxCapacity)
        {
            ret *= 2;
        }

        if (ret > maxCapacity)
        {
            ret = maxCapacity;
        }

        if (ret < needSize)      // 分配失败
        {
            //[Ctx ins]->mLogSys.error(string.Format("Malloc char buffer failed，cannot malloc {0} char buffer", needSize));
        }
    }

    return ret;
}

@end
