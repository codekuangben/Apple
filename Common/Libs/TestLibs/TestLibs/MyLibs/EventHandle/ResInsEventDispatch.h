#import "MyLibs/EventHandle/EventDispatch.h"
#import "MyLibs/EventHandle/IDispatchObject.h"

/**
 * @brief 资源实例化事件分发器
 */
@interface ResInsEventDispatch : EventDispatch, IDispatchObject
{

}

@property (nonatomic, readwrite, retain) BOOL mIsValid;
@property (nonatomic, readwrite, retain) NSObject mInsGO;

- (id) init;
- (void) setIsValid: (BOOL) value;
- (BOOL) getIsValid;
- (void) setInsGO: (NSObject*) go;
- (NSObject*) getInsGO;

- (void) dispatchEvent: (IDispatchObject) dispatchObject;

@end