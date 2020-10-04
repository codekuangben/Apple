#import <Foundation/Foundation.h>

@interface UtilLog : NSObject

+ (void) log:(NSString*) strContent ...;
+ (void) warn:(NSString*) strContent ...;
+ (void) error:(NSString*) strContent ...;

@end