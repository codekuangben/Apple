/**
 * @brief Tick 的优先级
 * @brief TP TickPriority 缩写
 */
enum TickPriority
{
    eTPResizeMgr = 100000,   // 窗口大小改变
    eTPDelayTaskMgr = 1,   // 延迟任务
    eTPLoadProgressMgr = 1,   // 更新加载进度
};
