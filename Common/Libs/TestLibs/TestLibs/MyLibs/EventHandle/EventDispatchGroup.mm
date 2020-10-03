#import "MyLibs/EventHandle/EventDispatchGroup.h"
#import "MyLibs/DataStruct/MDictionary.h"
#import "MyLibs/Eventhandle/EventDispatch.h"
#import <Foundation/Foundation.h>

@implementation EventDispatchGroup

- (id) init
{
    self->mGroupID2DispatchDic = [[MDictionary alloc] init];
    self->mIsInLoop = false;
    return self;
}

// 添加分发器
- (void) addEventDispatch:(int) groupID disp:(EventDispatch*) disp
{
    NSString* strKey = [NSString stringWithFormat:@"%d",groupID]; 
    if (![self->mGroupID2DispatchDic ContainsKey:strKey/*groupID*/])
    {
        [self->mGroupID2DispatchDic:groupID value:disp];
    }
}

- (void) addEventHandle:(int) groupID eventListener:(GObject<IListenerObject>*) eventListener eventHandle:/*(GObject<IDispatchObject>*)*/(SEL) eventHandle
{
    NSString* strKey = [NSString stringWithFormat:@"%d",groupID]; 
    // 如果没有就创建一个
    if (![self->mGroupID2DispatchDic ContainsKey:strKey/*groupID*/])
    {
        [self addEventDispatch:groupID disp:[[EventDispatch alloc] init]];
    }

    [[self->mGroupID2DispatchDic get:groupID] addEventHandle:eventListener eventHandle:eventHandle];
}

- (void) removeEventHandle:(int) groupID eventListener:(GObject<IListenerObject>*) eventListener eventHandle:/*(GObject<IDispatchObject>*)*/(SEL) eventHandle
{
    NSString* strKey = [NSString stringWithFormat:@"%d",groupID]; 
    if ([self->mGroupID2DispatchDic ContainsKey:strKey/*groupID*/])
    {
        [[self->mGroupID2DispatchDic get:groupID] removeEventHandle:eventListener eventHandle:eventHandle];

        // 如果已经没有了
        if (![[self->mGroupID2DispatchDic get:groupID] hasEventHandle])
        {
            [self->mGroupID2DispatchDic Remove:strKey/*groupID*/];
        }
    }
    else
    {

    }
}

- (void) dispatchEvent:(int) groupID dispatchObject:(GObject<IDispatchObject>*) dispatchObject
{
    NSString* strKey = [NSString stringWithFormat:@"%d",groupID]; 
    self->mIsInLoop = true;
    if ([self->mGroupID2DispatchDic ContainsKey:strKey/*groupID*/])
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
    NSString* strKey = [NSString stringWithFormat:@"%d",groupID]; 
    if (!self->mIsInLoop)
    {
        if ([self->mGroupID2DispatchDic ContainsKey:strKey/*groupID*/])
        {
            [[self->mGroupID2DispatchDic get:groupID] clearEventHandle];
            [self->mGroupID2DispatchDic Remove:strKey/*groupID*/];
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
    NSString* strKey = [NSString stringWithFormat:@"%d",groupID]; 
    if([self->mGroupID2DispatchDic ContainsKey:strKey/*groupID*/])
    {
        return [[self->mGroupID2DispatchDic get:groupID] hasEventHandle];
    }

    return false;
}

@end
