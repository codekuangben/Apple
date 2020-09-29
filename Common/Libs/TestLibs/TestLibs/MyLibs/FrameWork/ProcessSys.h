/**
* @brief 系统循环
*/

@interface ProcessSys
{

}

- (id) init;
- (void) ProcessNextFrame;
- (void) Advance:(float) delta;
- (void) ProcessNextFixedFrame;
- (void) FixedAdvance:(float) delta;

@end