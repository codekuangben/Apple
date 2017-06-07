package SDK.Lib.Thread;

//import java.util.concurrent.CyclicBarrier;

/**
 * @同步使用的 Event
 */
public class MEvent
{
    //private CyclicBarrier mEvent;
    private Object mEvent;

    public MEvent(boolean initialState)
    {
        //self.mEvent = new CyclicBarrier(2);
    }

    synchronized public (void) WaitOne()
    {
        try
        {
            self.mEvent.wait();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }

    synchronized public boolean Reset()
    {
        //self.mEvent.reset();
        return true;
    }

    synchronized public boolean Set()
    {
        self.mEvent.notify();
        return true;
    }
}