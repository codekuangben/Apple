#import <Foundation/Foundation.h>

@protocol ITickedObject <NSObject>

@required
- (void) onTick:(float) delta;

@end