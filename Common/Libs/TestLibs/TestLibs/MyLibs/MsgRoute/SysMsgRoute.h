#import <Foundation/Foundation.h>
#import "MyLibs/DataStruct/MList.h"

/**
 * @brief 系统消息流程，整个系统的消息分发都走这里，仅限单线程
 */
@interface SysMsgRoute : MList
{
    
}

-(id) init:(NSString*) name;
-(void) dispose;

@end
