// #import "MyLibs/Base/GObject.h"
// #import "MyLibs/FrameWork/MacroDef.h"
// #import "MyLibs/Tools/MEndian.h"

// @interface MsgBuffer : GObject
// {
// @protected
//     CircularBuffer* mCircularBuffer;  // 环形缓冲区
//     ByteBuffer* mHeaderBA;            // 主要是用来分析头的大小
//     ByteBuffer* mMsgBodyBA;           // 返回的字节数组
// }

// - (id) init;
// - (id) initWithParams:(int) initCapacity maxCapacity:(int) maxCapacity;
// - (ByteBuffer*) getHeaderBA;
// - (ByteBuffer*) getMsgBodyBA;
// - (CircularBuffer*) getCircularBuffer;

// // 设置网络字节序
// - (void) setEndian:(MEndian) end;

// /**
//     * @brief 检查 CB 中是否有一个完整的消息
//     */
// - (BOOL) checkHasMsg;
// /**
//  * @brief 获取前面的第一个完整的消息数据块
//  */
// - (BOOL) popFront;
// /**
//  * @brief KBEngine 引擎消息处理
//  */
// - (BOOL) popFrontAll;

// @end