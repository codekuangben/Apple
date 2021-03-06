﻿// #import "MyLibs/Tools/MEndian.h"

// @implementation MsgBuffer

// - (id) init
// {
//     this(BufferCV.INIT_CAPACITY, BufferCV.MAX_CAPACITY);
// }

// - (id) initWithParams:(int) initCapacity (int) maxCapacity
// {
//     mCircularBuffer = new CircularBuffer(initCapacity, maxCapacity);
//     mHeaderBA = new ByteBuffer();
//     mMsgBodyBA = new ByteBuffer();
// }

// - (ByteBuffer*) getHeaderBA
// {
//     return mHeaderBA;
// }

// - (ByteBuffer*) getMsgBodyBA
// {
//     return mMsgBodyBA;
// }

// - (CircularBuffer*) getCircularBuffer
// {
//     return mCircularBuffer;
// }

// // 设置网络字节序
// - (void) setEndian:(MEndian) end
// {
//     mHeaderBA.setEndian(end);
//     mMsgBodyBA.setEndian(end);
// }

// /**
//     * @brief 检查 CB 中是否有一个完整的消息
//     */
// - (BOOL) checkHasMsg
// {
//     mCircularBuffer.frontBA(mHeaderBA, MsgCV.HEADER_SIZE);  // 将数据读取到 mHeaderBA
//     (int) msglen = 0;
//     mHeaderBA.readUnsignedInt32(msglen);
//     if (MacroDef.MSG_COMPRESS)
//     {
//         if ((msglen & MsgCV.PACKET_ZIP) > 0)         // 如果有压缩标志
//         {
//             msglen &= (~MsgCV.PACKET_ZIP);         // 去掉压缩标志位
//         }
//     }
//     if (msglen <= mCircularBuffer.getSize() - MsgCV.HEADER_SIZE)
//     {
//         return true;
//     }
//     else
//     {
//         return false;
//     }
// }

// /**
//  * @brief 获取前面的第一个完整的消息数据块
//  */
// - (BOOL) popFront
// {
//     BOOL ret = false;
//     if (mCircularBuffer.getSize() > MsgCV.HEADER_SIZE)         // 至少要是 DataCV.HEADER_SIZE 大小加 1 ，如果正好是 DataCV.HEADER_SIZE ，那只能说是只有大小字段，没有内容
//     {
//         mCircularBuffer.frontBA(mHeaderBA, MsgCV.HEADER_SIZE);  // 如果不够整个消息的长度，还是不能去掉消息头的
//         (int) msglen = 0;
//         mHeaderBA.readUnsignedInt32(msglen);
//         if (MacroDef.MSG_COMPRESS)
//         {
//             if ((msglen & MsgCV.PACKET_ZIP) > 0)         // 如果有压缩标志
//             {
//                 msglen &= (~MsgCV.PACKET_ZIP);         // 去掉压缩标志位
//             }
//         }

//         if (msglen <= mCircularBuffer.getSize() - MsgCV.HEADER_SIZE)
//         {
//             mCircularBuffer.popFrontLen(MsgCV.HEADER_SIZE);
//             mCircularBuffer.popFrontBA(mMsgBodyBA, msglen);
//             ret = true;
//         }
//     }

//     if (mCircularBuffer.empty())     // 如果已经清空，就直接重置
//     {
//         mCircularBuffer.clear();    // 读写指针从头开始，方式写入需要写入两部分
//     }

//     return ret;
// }

// /**
//  * @brief KBEngine 引擎消息处理
//  */
// - (BOOL) popFrontAll
// {
//     BOOL ret = false;

//     if (!mCircularBuffer.empty())
//     {
//         ret = true;
//         mCircularBuffer.linearize();
//         mCircularBuffer.popFrontBA(mMsgBodyBA, mCircularBuffer.getSize());
//         mCircularBuffer.clear();
//     }

//     return ret;
// }

// @end