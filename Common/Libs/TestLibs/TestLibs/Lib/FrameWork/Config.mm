package SDK.Lib.FrameWork;

/**
 * @brief 宏定义说明区域
 */

import SDK.Lib.DataStruct.MList;

/**
 * @brief 基本的配置
 */
public class Config
{
    public static String StreamingAssets;

    public String mIp;
    public (int) mPort;
    public short mZone;

    public String mWebIP;               // web 服务器
    public (int) mWebPort;

    public String[] mPathLst;
    public String mDataPath;
    public String mNetLogPhp;       // Php 处理文件
    public MList<String> mPakExtNameList;       // 打包的扩展名字列表

    public boolean mIsActorMoveUseFixUpdate;    // Actor 移动是否使用固定更新，主要是方便参与物理运算

    public Config()
    {
        StreamingAssets = "StreamingAssets/";

        self.mIp = "192.168.96.14";
        self.mPort = 20013;
        self.mZone = 30;

        self.mWebIP = "http://127.0.0.1/UnityServer/";
        self.mWebPort = 80;
        self.mNetLogPhp = "/netlog/NetLog.php";
        self.mPakExtNameList = new MList<String>();

//        self.mPathLst = new string[((int))ResPathType.eTotal];
//        self.mPathLst[((int))ResPathType.ePathScene] = "Scenes/";
//        self.mPathLst[((int))ResPathType.ePathSceneXml] = "Scenes/Xml/";
//        self.mPathLst[((int))ResPathType.ePathModule] = "Module/";

        self.mPakExtNameList.Add("prefab");
        self.mPakExtNameList.Add("png");
        self.mPakExtNameList.Add("shader");
        self.mPakExtNameList.Add("unity");

        self.mIsActorMoveUseFixUpdate = true;
    }
}