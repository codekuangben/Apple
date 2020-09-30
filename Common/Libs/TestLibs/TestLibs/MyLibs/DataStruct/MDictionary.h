#import <Foundation/Foundation.h>

@interface MDictionary
{
@protected
    //NSDictionary* mData;
    NSMutableDictionary* mData;
}

- (id) init;
- (NSMutableDictionary*) getData;
- (id) value:(id) key;
- (int) Count;
- (void) add:(id) key, value:(id) value;
- (void) Remove:(id) key;
- (void) Clear;
- (BOOL) TryGetValue:(id) key value:(TValue) value;
- (BOOL) ContainsKey:(id) key;
// https://blog.csdn.net/q_023/article/details/78438000
- (NSMutableArray*) allKeys;
- (NSMutableArray*) getValues;

@end