﻿/**
* @brief 定时器类型
*/
typedef enum
{
    eTickTimer,             // 每一帧定时器
    eOneSecTimer,           // 1 秒定时器
    eFiveSecTimer,          // 5 秒定时器
    eTimerTotla             // 总共定时器种类
} TimerType;