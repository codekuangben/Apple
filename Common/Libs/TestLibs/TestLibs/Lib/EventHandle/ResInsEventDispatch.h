#ifndef __EventDispatchGroup_h
#define __EventDispatchGroup_h

#import "EventDispatch.h"
#import "IDispatchObject.h"

/**
 * @brief 资源实例化事件分发器
 */
@interface ResInsEventDispatch : EventDispatch, IDispatchObject
{

}

@property (nonatomic, readwrite, retain) bool mIsValid;
@property (nonatomic, readwrite, retain) NSObject mInsGO;

- (id) init;
- (void) setIsValid: (bool) value;
- (bool) getIsValid;
- (void) setInsGO: (NSObject) go;
- (NSObject) getInsGO;

- (void) dispatchEvent: (IDispatchObject) dispatchObject;

@end

#endif