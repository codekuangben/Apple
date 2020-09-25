package SDK.Lib.Log;

/**
 * @brief 文件日志
 */
@interface WinLogDevice : LogDeviceBase
{
    @Override
    public (void) logout(String message)
    {
        self.logout(message, LogColor.eLC_LOG);
    }

    @Override
    public (void) logout(String message, LogColor type)
    {
        if (type == LogColor.eLC_LOG)
        {
            //Debug.Log(message);
        }
        else if (type == LogColor.eLC_WARN)
        {
            //Debug.LogWarning(message);
        }
        else if (type == LogColor.eLC_ERROR)
        {
            //Debug.LogError(message);
        }
    }
}