#import <Foundation/Foundation.h>

@interface UtilLog : NSObject

+ (void) log:(String) strContent;
+ (void) warn:(String) strContent;
+ (void) error:(String) strContent;

@end