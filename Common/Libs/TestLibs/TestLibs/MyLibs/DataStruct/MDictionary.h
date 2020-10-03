#import <Foundation/Foundation.h>
#import "MyLibs/Base/GObject.h"

@interface MDictionary : GObject
{
@protected
    //NSDictionary* mData;
    NSMutableDictionary* mData;
}

- (id) init;
- (NSMutableDictionary*) getData;
- (id) value:(id) key;
- (int) Count;
- (void) add:(id) key value:(id) value;
- (void) Remove:(id) key;
- (void) Clear;
- (BOOL) TryGetValue:(id) key value:(id) value;
- (BOOL) ContainsKey:(id) key;
// https://blog.csdn.net/q_023/article/details/78438000
- (NSMutableArray*) allKeys;
- (NSMutableArray*) getValues;

@end
