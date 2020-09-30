#import "MyLibs/DataStruct/MList.h"

/**
 * @brief 对系统 List 的封装
 */
@implementation MList

- (id) init
{
    self->mList = [NSMutableArray arrayWithCapacity:0];
}

- (id) initWithParams:(int) capacity
{
    self->mList = [NSMutableArray arrayWithCapacity:capacity];
}

- (NSMutableArray*) list
{
    return self->mList;
}

- (int) getUniqueId
{
    return self->mUniqueId;
}

- (void) setUniqueId:(int) value
{
    self->mUniqueId = value;
}

- (void) Add:(id) item
{
    [self->mList addObject:item];
}

- (BOOL) Remove:(id) item
{
    [self->mList removeObject:item];
}

- (id) get:(int) index
{
    return [self->mList objectAtIndex:index];
}

- (void) set:(int) index, value:(id) value
{
    [self->mList replaceObjectAtIndex:index withObject:value];
}

- (void) Clear
{
    [self->mList removeAllObjects];
}

- (int) Count
{
    return [self->mList count];
}

- (void) setLength:(int) value
{
    self->mList.ensureCapacity(value);
}

- (void) RemoveAt:(int) index
{
    [self->mList removeObjectAtIndex:index];
}

- (int) IndexOf:(id) item
{
    return [self->mList indexOfObject:item];
}

- (void) Insert:(int) index item:(id) item
{
    if (index <= self->Count())
    {
        [self->mList insertObject:item atIndex:index];
    }
}

- (BOOL) Contains:(id) item
{
    return [self->mList containsObject:item];
}

@end