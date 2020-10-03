#import "MyLibs/DataStruct/MDictionary.h"

@implementation MDictionary

- (id) init
{
    mData = [NSMutableDictionary dictionary];
    return self;
}

- (NSMutableDictionary*) getData
{
    return self->mData;
}

- (id) value:(id) key
{
    if ([self->mData containsKey:key])
    {
        return self->mData[key];
    }

    return nil;
}

- (int) Count
{
    return [self->mData count];
}

- (void) add:(id)key value:(id)value
{
    [self->mData setObject:value forKey:key];
}

- (void) Remove:(id) key
{
    [self->mData removeObjectForKey:key];
}

- (void) Clear
{
    [self->mData removeAllObjects];
}

- (BOOL) TryGetValue:(id) key value:(id) value
{
    value = [self->mData get:key];
    return true;
}

- (BOOL) ContainsKey:(id) key
{
    [self->mData objectForKey:key];
    return YES;
}

- (NSMutableArray*) allKeys
{
    return [self->mData allKeys];
}

- (NSMutableArray*) getValues
{
    return [self->mData allValues];
}

@end
