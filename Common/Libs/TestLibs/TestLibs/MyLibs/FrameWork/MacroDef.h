enum MacroDef
{
    // 宏定义开始
    // 调试不需要网络
    DEBUG_NOTNET = 0,

    // 网络处理多线程，主要是调试的时候使用单线程，方便调试，运行的时候使用多线程
    NET_MULTHREAD = 1,

    // 是否检查函数接口调用线程
    THREAD_CALLCHECK = 1,

    // 开启窗口日志
    ENABLE_WINLOG = 1,

    // 开启网络日志
    ENABLE_NETLOG = 0,

    // 开启文件日志
    ENABLE_FILELOG = 0,

    // 单元测试，这个需要宏定义
    UNIT_TEST = 1,

    // 开启日志
    ENABLE_LOG = 1,

    // 开启警告
    ENABLE_WARN = 0,

    // 开启错误
    ENABLE_ERROR = 1,

    // 压缩
    MSG_COMPRESS = 1,
    // 宏定义结束
}