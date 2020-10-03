#import "MyLibs/EventHandle/EventDispatch.h"
#import "MyLibs/EventHandle/IDispatchObject.h"
#import "MyLibs/Base/GObject.h"

/**
 * @brief 资源实例化事件分发器
 */
@interface ResInsEventDispatch : EventDispatch <IDispatchObject>
{
@public
    BOOL mIsValid;
    GObject* mInsGO;
}

//@property (nonatomic, readwrite, retain) BOOL mIsValid;
//@property (nonatomic, readwrite, retain) NSObject mInsGO;

- (id) init;
- (void) setIsValid: (BOOL) value;
- (BOOL) getIsValid;
- (void) setInsGO: (GObject*) go;
- (GObject*) getInsGO;

- (void) dispatchEvent: (GObject<IDispatchObject>*) dispatchObject;

@end
