package SDK.Lib.Tools;

import java.io.UnsupportedEncodingException;

import SDK.Lib.DataStruct.MArray;

public class MEncoding
{
    public static final String UTF8_STR  = "UTF-8";
    public static final String GB2312_STR  = "GB2312";
    public static final String Unicode_STR  = "Unicode";
    public static final String Default_STR  = "UTF-8";

    public static final MEncoding UTF8  = new MEncoding(MEncoding.UTF8_STR);
    public static final MEncoding GB2312  = new MEncoding(MEncoding.GB2312_STR);
    public static final MEncoding Unicode  = new MEncoding(MEncoding.Unicode_STR);
    public static final MEncoding Default  = new MEncoding(MEncoding.Default_STR);

    protected String mEncodeStr;

    public MEncoding(String encodeStr)
    {
        self.mEncodeStr = encodeStr;
    }

    public String GetString(byte[] bytes)
    {
        return  self.GetString(bytes, 0, bytes.length);
    }

    public String GetString(byte[] bytes, int startIndex)
    {
        return self.GetString(bytes, startIndex, bytes.length - startIndex);
    }

    public String GetString(byte[] bytes, int startIndex, int len)
    {
        String ret = "";

        try
        {
            ret = new String(MArray.getSubBytes(bytes, startIndex, len), self.mEncodeStr);
        }
        catch(UnsupportedEncodingException e)
        {

        }

        return ret;
    }

    public int GetByteCount(String str)
    {
        int len = 0;

        try
        {
            byte[] bytes = str.getBytes(self.mEncodeStr);
            len = bytes.length;
        }
        catch(UnsupportedEncodingException e)
        {

        }

        return len;
    }

    public byte[] GetBytes(String str)
    {
        byte[] bytes = null;

        try
        {
            bytes = str.getBytes(self.mEncodeStr);
        }
        catch(UnsupportedEncodingException e)
        {

        }

        return bytes;
    }
}