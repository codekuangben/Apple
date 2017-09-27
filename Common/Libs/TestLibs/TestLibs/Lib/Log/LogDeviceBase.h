#ifndef __LogDeviceBase_H
#define __LogDeviceBase_H

/**
 * @brief 日志设备
 */
@interface LogDeviceBase
{
    
}

-(void) initDevice;
-(void) closeDevice;
-(void) logout:(String) message;
-(void) logout:(String) message type:(LogColor) type;

@end

#endif