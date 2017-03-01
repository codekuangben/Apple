#ifndef __EventDispatchGroup_h
#define __EventDispatchGroup_h

/**
 * @brief 可被调用的函数对象
 */
@interface ICalleeObject
{
    
}

- (void) call: (IDispatchObject) dispObj;

@end

#endif