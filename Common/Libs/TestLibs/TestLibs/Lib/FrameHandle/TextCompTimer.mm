package SDK.Lib.FrameHandle;

@interface TextCompTimer : DaoJiShiTimer
{
    //protected Text mText;

    @Override
    protected (void) onPreCallBack()
    {
        super.onPreCallBack();
        //self.mText.text = UtilLogic.formatTime(((int))self.mCurRunTime);
    }
}