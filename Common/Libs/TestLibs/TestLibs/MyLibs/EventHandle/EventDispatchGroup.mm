#import "MyLibs/EventHandle/EventDispatchGroup.h"
#import "MyLibs/DataStruct/MDictionary.h"
#import "MyLibs/Eventhandle/EventDispatch.h"

@implementation EventDispatchGroup

- (id) init
{
    self->mGroupID2DispatchDic = [[MDictionary alloc] init];
    self->mIsInLoop = false;
}

// 添加分发器
- (void) addEventDispatch:(int) groupID disp:(EventDispatch*) disp
{
    if (![self->mGroupID2DispatchDic ContainsKey:groupID])
    {
        [self->mGroupID2DispatchDic:set:groupID, value:disp];
    }
}

- (void) addEventHandle:(int) groupID pThis:(GObject<ICalleeObject>*) pThis handle:(GObject<IDispatchObject>*) handle
{
    // 如果没有就创建一个
    if (![self->mGroupID2DispatchDic ContainsKey:groupID])
    {
        [self addEventDispatch:groupID, [[EventDispatch alloc] init];
    }

    [[self->mGroupID2DispatchDic get:groupID] addEventHandle:pThis handle:handle];
}

- (void) removeEventHandle:(int) groupID pThis:(GObject<ICalleeObject>*) pThis handle:(GObject<IDispatchObject>*) handle
{
    if ([self->mGroupID2DispatchDic ContainsKey:groupID])
    {
        [[self->mGroupID2DispatchDic get:groupID] removeEventHandle:pThis handle:handle];

        // 如果已经没有了
        if (![[self->mGroupID2DispatchDic get:groupID] hasEventHandle]
        {
            [self->mGroupID2DispatchDic Remove:groupID];
        }
    }
    else
    {

    }
}

- (void) dispatchEvent:(int) groupID dispatchObject:(GObject<IDispatchObject>*) dispatchObject
{
    self->mIsInLoop = true;
    if ([self->mGroupID2DispatchDic ContainsKey:groupID])
    {
        [[self->mGroupID2DispatchDic get:groupID] dispatchEvent:dispatchObject];
    }
    else
    {

    }
    self->mIsInLoop = false;
}

- (void) clearAllEventHandle
{
    if (!self->mIsInLoop)
    {
        [[self->mGroupID2DispatchDic getData] enumerateKeysAndObjectsUsingBlock:^(id key, id obj,BOOL *stop) {
         NSLog(@"key = %@ and obj = %@", key, obj);
       }];
        for (EventDispatch* dispatch in [self->mGroupID2DispatchDic getValues])
        {
            [dispatch clearEventHandle];
        }

        [self->mGroupID2DispatchDic Clear];
    }
    else
    {

    }
}

- (void) clearGroupEventHandle:(int) groupID
{
    if (!self->mIsInLoop)
    {
        if ([self->mGroupID2DispatchDic ContainsKey:groupID])
        {
            [[self->mGroupID2DispatchDic.get:groupID] clearEventHandle];
            [self->mGroupID2DispatchDic Remove:groupID];
        }
        else
        {

        }
    }
    else
    {

    }
}

- (BOOL) hasEventHandle:(int) groupID
{
    if([self->mGroupID2DispatchDic ContainsKey:groupID])
    {
        return [[self->mGroupID2DispatchDic get:groupID] hasEventHandle];
    }

    return false;
}

@end
