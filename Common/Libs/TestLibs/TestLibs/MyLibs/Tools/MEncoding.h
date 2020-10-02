#import <Foundation/Foundation.h>
#import "MyLibs/Base/GObject.h"

@interface MEncoding : GObject
{
@public

@protected
    NSString* mEncodeStr;
}

//@property() NSString*mEncodeStr;

- (id) init: (NSString*) encodeStr;
- (NSString*) GetString: (char[]) bytes;
- (NSString*) GetString: (char[]) bytes startIndex: (int) startIndex;
- (NSString*) GetString:(char[]) bytes startIndex: (int) startIndex len:(int) len;
- (int) GetByteCount: (NSString*) str;
- (char*) GetBytes:(NSString*) str;

@end
