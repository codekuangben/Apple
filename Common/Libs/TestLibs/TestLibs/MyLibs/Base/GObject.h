#import <Foundation/Foundation.h>

@interface GObject : NSObject
{
@protected
    NSString* mTypeId;     // 名字
}

- (id) init;
- (NSString*) getTypeId;

@end