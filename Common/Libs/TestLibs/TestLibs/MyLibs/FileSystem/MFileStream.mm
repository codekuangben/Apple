#import "MyLibs/FileSystem/MFileStream.h"

@implementation MFileStream

-(id) init:(String) filePath
{
	if(self = [super init])
	{
		self.mTypeId = "MFileStream";

		self.mFilePath = filePath;
		self.mFileOpState = FileOpState.eNoOp;

		[self checkAndOpen];
	}
}

-(void) seek:(long) offset origin:(MSeekOrigin) origin
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

-(void) dispose
{
	[self close];
}

-(void) checkAndOpen
{
	if(self.mFileOpState == FileOpState.eNoOp)
	{
		self.mFile = new File(self.mFilePath);
	}
}

-(void) syncOpenFileStream
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

-(BOOL) isValid
{
	return self.mFileOpState == FileOpState.eOpenSuccess;
}

// 获取总共长度
-(int) getLength
{
	(int) len = 0;

	if (self.mFileOpState == FileOpState.eOpenSuccess)
	{
		if (self.mFile != null)
		{
			len = ((int))self.mFile.length();
		}
		/*
		if (mFileStream != null && mFileStream.CanSeek)
		{
			try
			{
				len = ((int))mFileStream.Seek(0, SeekOrigin.End);     // 移动到文件结束，返回长度
				len = ((int))mFileStream.Position;                    // Position 移动到 Seek 位置
			}
			catch(Exception exp)
			{
			}
		}
		*/
	}

	return len;
}

-(void) close
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

-(String) readText
{
	return self.readText(0, 0, null);
}

-(String) readText:(int) offset
{
	return self.readText(offset, 0, null);
}

-(String) readText:(int) offset count:(int) count
{
	return self.readText(offset, count, null);
}

-(String) readText:(int) offset count:(int) count encode:(MEncoding) encode
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

-(byte[]) readByte
{
	return self.readByte(0, 0);
}

-(byte[]) readByte:(int) offset
{
	return self.readByte(offset, 0);
}

-(byte[]) readByte:(int) offset count:(int) count
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

-(void) writeText:(String) text
{
	self.writeText(text, GkEncode.eUTF8);
}

-(void) writeText:(String) text gkEncode:(GkEncode) gkEncode
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

-(void) writeByte:(byte[]) bytes
{
	self.writeByte(bytes, 0, 0);
}

-(void) writeByte:(byte[]) bytes offset:(int) offset
{
	self.writeByte(bytes, offset, 0);
}

-(void) writeByte:(byte[]) bytes offset:(int) offset count:(int) count
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

-(void) writeLine:(String) text
{
	self.writeLine(text, GkEncode.eUTF8);
}

-(void) writeLine:(String) text gkEncode:(GkEncode) gkEncode
{
	text = text + UtilApi.CR_LF;
	writeText(text, gkEncode);
}

@end