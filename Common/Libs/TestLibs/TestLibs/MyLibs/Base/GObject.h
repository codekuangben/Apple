#import <Foundation/Foundation.h>

@interface GObject : NSObject
{
@protected
    String mTypeId;     // 名字
}

- (id) init;
- (String) getTypeId;

@end