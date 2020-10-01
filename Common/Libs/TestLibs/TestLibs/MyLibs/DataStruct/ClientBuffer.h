#import "MyLibs/Base/GObject.h"

/**
 *@brief 网络数据缓冲区
 */
@interface ClientBuffer : GObject
{
@protected
	MsgBuffer* mRawBuffer;      // 直接从服务器接收到的原始的数据，可能压缩和加密过
    MsgBuffer* mMsgBuffer;      // 可以使用的缓冲区
    // ByteBuffer* mSendTmpBA;   // 发送临时缓冲区，发送的数据都暂时放在这里
	MsgBuffer* mSendTmpBuffer;  // 发送临时缓冲区，发送的数据都暂时放在这里
	ByteBuffer* mSocketSendBA;       // 真正发送缓冲区
	
	DynBuffer<char> mDynBuffer;        // 接收到的临时数据，将要放到 mRawBuffer 中去
	ByteBuffer* mUnCompressHeaderBA;  // 存放解压后的头的长度
	ByteBuffer* mSendData;            // 存放将要发送的数据，将要放到 m_sendBuffer 中去
	ByteBuffer* mTmpData;             // 临时需要转换的数据放在这里
	ByteBuffer* mTmp1fData;           // 临时需要转换的数据放在这里
	
    MMutex* mReadMutex;   // 读互斥
    MMutex* mWriteMutex;  // 写互斥

    CryptContext* mCryptContext;
}

@property MsgBuffer* mRawBuffer;
@property MsgBuffer* mMsgBuffer;
@property MsgBuffer* mSendTmpBuffer;
@property ByteBuffer* mSocketSendBA;

@property DynBuffer<char> mDynBuffer;
@property ByteBuffer* mUnCompressHeaderBA;
@property ByteBuffer* mSendData;
@property ByteBuffer* mTmpData;
@property ByteBuffer* mTmp1fData;

@property MMutex* mReadMutex;
@property MMutex* mWriteMutex;

@property CryptContext* mCryptContext;

- (id) init;
(-) (DynBuffer*) getDynBuffer;
- (MsgBuffer*) getSendTmpBuffer;
- (ByteBuffer*) getSendBuffer;
- (ByteBuffer*) getSendData;
// 设置 ClientBuffer 字节序
- (void) setEndian:(EEndian) end;
- (void) setCryptKey:(char[]) encrypt;
- (void) checkDES;
- (MsgBuffer*) getRawBuffer;
- (void) SetRevBufferSize:(int) size;
- (void) moveDyn2Raw;
- (void) moveDyn2Raw_KBE;
// 自己的消息逻辑
- (void) moveRaw2Msg;
// KBEngine 引擎消息流程
- (void) moveRaw2Msg_KBE;
- (void) send:(BOOL) bnet;
// TODO: KBEngine 引擎发送
- (void) send_KBE:(BOOL) isSendToNet;
- ByteBuffer getMsg;
// 弹出 KBEngine 消息
- ByteBuffer getMsg_KBE;
// 获取数据，然后压缩加密
- (void) getSocketSendData;
// TODO: KBEngine 获取发送数据
- (void) getSocketSendData_KBE;
// 压缩加密每一个包
- (void) CompressAndEncryptEveryOne;
// 压缩解密作为一个包
- (void) CompressAndEncryptAllInOne;
// 消息格式
// |------------- 加密的整个消息  -------------------------------------|
// |----4 Header----|-压缩的 body----|----4 Header----|-压缩的 body----|
// |                |                |                |                |
- (void) UnCompressAndDecryptEveryOne;
- (void) UnCompressAndDecryptAllInOne;

@end