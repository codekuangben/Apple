#import <Foundation/Foundation.h>
#import "MyLibs/Base/GObject.h"

/**
 * @brief 对系统 List 的封装
 */
@interface MList : GObject
{
@protected
    //NSArray* mList;
    NSMutableArray* mList;
    int mUniqueId;       // 唯一 Id ，调试使用
}

- (id) init;
- (id) initWithParams:(int) capacity;
- (NSMutableArray*) list;
- (int) getUniqueId;
- (void) setUniqueId:(int) value;
- (void) Add:(id) item;
- (BOOL) Remove:(id) item;
- (id) get:(int) index;
- (void) set:(int) index, value:(id) value;
- (void) Clear;
- (int) Count;
- (void) setLength:(int) value;
- (void) RemoveAt:(int) index;
- (int) IndexOf:(id) item;
- (void) Insert:(int) index item:(id) item;
- (BOOL) Contains:(id) item;

@end