#ifndef __GObject_h
#define __GObject_h

#import <Foundation/Foundation.h>

@interface GObject : NSObject
{
@protected
    NSString* mTypeId;     // 名字
}

- (id) init;
- (NSString*) getTypeId;

@end

#endif