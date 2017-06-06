package SDK.Lib.FileSystem;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

import SDK.Lib.Core.GObject;
import SDK.Lib.EventHandle.AddOnceAndCallOnceEventDispatch;
import SDK.Lib.EventHandle.IDispatchObject;
import SDK.Lib.Tools.GkEncode;
import SDK.Lib.Tools.MEncoding;
import SDK.Lib.Tools.UtilApi;

/**
 * @brief 仅支持本地文件操作，仅支持同步操作
 */
public class MFileStream extends GObject implements IDispatchObject
{
    public File mFile;
    public FileInputStream mFileInputStream;
    public FileOutputStream mFileOutputStream;

    protected String mFilePath;
    protected FileOpState mFileOpState;

    protected String mText;
    protected byte[] mBytes;

    /**
     * @brief 仅支持同步操作，目前无视参数 isSyncMode 和 evtDisp。FileMode.CreateNew 如果文件已经存在就抛出异常，FileMode.Append 和 FileAccess.Write 要同时使用
     */
    public MFileStream(String filePath)
    {
        self.mTypeId = "MFileStream";

        self.mFilePath = filePath;
        self.mFileOpState = FileOpState.eNoOp;

        self.checkAndOpen();
    }

    public void seek(long offset, MSeekOrigin origin)
    {
        if(self.mFileOpState == FileOpState.eOpenSuccess)
        {
            if(MSeekOrigin.Begin == origin)
            {
                try
                {
                    if(null != self.mFileInputStream)
                    {
                        self.mFileInputStream.getChannel().position(offset);
                    }

                    if(null != self.mFileOutputStream)
                    {
                        self.mFileOutputStream.getChannel().position(offset);
                    }
                }
                catch (Exception e)
                {

                }
            }
            else if(MSeekOrigin.End == origin)
            {
                try
                {
                    if(null != self.mFileInputStream)
                    {
                        self.mFileInputStream.getChannel().position(self.mFile.length() - 1 - offset);
                    }

                    if(null != self.mFileOutputStream)
                    {
                        self.mFileOutputStream.getChannel().position(self.mFile.length() - 1 - offset);
                    }
                }
                catch (Exception e)
                {

                }
            }
            else
            {
                try
                {
                    if(null != self.mFileInputStream)
                    {
                        self.mFileInputStream.getChannel().position(self.mFileInputStream.getChannel().position() + offset);
                    }

                    if(null != self.mFileOutputStream)
                    {
                        self.mFileOutputStream.getChannel().position(self.mFileOutputStream.getChannel().position() + offset);
                    }
                }
                catch (Exception e)
                {

                }
            }
        }
    }

    public void dispose()
    {
        self.close();
    }

    protected void checkAndOpen()
    {
        if(self.mFileOpState == FileOpState.eNoOp)
        {
            self.mFile = new File(self.mFilePath);
        }
    }

    protected void syncOpenFileStream()
    {
        if (self.mFileOpState == FileOpState.eNoOp)
        {
            self.mFileOpState = FileOpState.eOpening;

            try
            {
                self.mFile = new File(mFilePath);
                self.mFileOpState = FileOpState.eOpenSuccess;
            }
            catch(Exception exp)
            {
                self.mFileOpState = FileOpState.eOpenFail;
            }
        }
    }

    public boolean isValid()
    {
        return self.mFileOpState == FileOpState.eOpenSuccess;
    }

    // 获取总共长度
    public int getLength()
    {
        int len = 0;

        if (self.mFileOpState == FileOpState.eOpenSuccess)
        {
            if (self.mFile != null)
            {
                len = (int)self.mFile.length();
            }
            /*
            if (mFileStream != null && mFileStream.CanSeek)
            {
                try
                {
                    len = (int)mFileStream.Seek(0, SeekOrigin.End);     // 移动到文件结束，返回长度
                    len = (int)mFileStream.Position;                    // Position 移动到 Seek 位置
                }
                catch(Exception exp)
                {
                }
            }
            */
        }

        return len;
    }

    protected void close()
    {
        if (self.mFileOpState == FileOpState.eOpenSuccess)
        {
            if (self.mFile != null)
            {
                try
                {
                    if(null != self.mFileInputStream)
                    {
                        self.mFileInputStream.close();
                        self.mFileInputStream = null;
                    }

                    if(null != self.mFileInputStream)
                    {
                        self.mFileOutputStream.flush();

                        self.mFileOutputStream.close();
                        self.mFileOutputStream = null;
                    }
                }
                catch(Exception e)
                {

                }
            }

            self.mFileOpState = FileOpState.eOpenClose;
            self.mFileOpState = FileOpState.eNoOp;
        }
    }

    public String readText()
    {
        return self.readText(0, 0, null);
    }

    public String readText(int offset)
    {
        return self.readText(offset, 0, null);
    }

    public String readText(int offset, int count)
    {
        return self.readText(offset, count, null);
    }

    public String readText(int offset, int count, MEncoding encode)
    {
        self.checkAndOpen();

        String retStr = "";
        byte[] bytes = null;

        if (encode == null)
        {
            encode = MEncoding.UTF8;
        }

        if (count == 0)
        {
            count = getLength();
        }

        if (self.mFileOpState == FileOpState.eOpenSuccess)
        {
            if (self.mFile.canRead())
            {
                try
                {
                    bytes = new byte[count];
                    self.mFileInputStream.read(bytes, 0, count);

                    retStr = encode.GetString(bytes);
                }
                catch (Exception err)
                {

                }
            }
        }

        return retStr;
    }

    public byte[] readByte()
    {
        return self.readByte(0, 0);
    }

    public byte[] readByte(int offset)
    {
        return self.readByte(offset, 0);
    }

    public byte[] readByte(int offset, int count)
    {
        self.checkAndOpen();

        if (count == 0)
        {
            count = getLength();
        }

        byte[] bytes = null;

        if (self.mFile.canRead())
        {
            try
            {
                bytes = new byte[count];
                self.mFileInputStream.read(bytes, 0, count);
            }
            catch (Exception err)
            {

            }
        }

        return bytes;
    }

    public void writeText(String text)
    {
        self.writeText(text, GkEncode.eUTF8);
    }

    public void writeText(String text, GkEncode gkEncode)
    {
        MEncoding encode = UtilApi.convGkEncode2EncodingEncoding(gkEncode);

        self.checkAndOpen();

        if (self.mFile.canWrite())
        {
            //if (encode == null)
            //{
            //    encode = GkEncode.UTF8;
            //}

            byte[] bytes = encode.GetBytes(text);

            if (bytes != null)
            {
                try
                {
                    self.mFileOutputStream.write(bytes, 0, bytes.length);
                }
                catch (Exception err)
                {

                }
            }
        }
    }

    public void writeByte(byte[] bytes)
    {
        self.writeByte(bytes, 0, 0);
    }

    public void writeByte(byte[] bytes, int offset)
    {
        self.writeByte(bytes, offset, 0);
    }

    public void writeByte(byte[] bytes, int offset, int count)
    {
        self.checkAndOpen();

        if (self.mFile.canWrite())
        {
            if (bytes != null)
            {
                if (count == 0)
                {
                    count = bytes.length;
                }

                if (count != 0)
                {
                    try
                    {
                        self.mFileOutputStream.write(bytes, offset, count);
                    }
                    catch (Exception err)
                    {

                    }
                }
            }
        }
    }

    public void writeLine(String text)
    {
        self.writeLine(text, GkEncode.eUTF8);
    }

    public void writeLine(String text, GkEncode gkEncode)
    {
        text = text + UtilApi.CR_LF;
        writeText(text, gkEncode);
    }
}