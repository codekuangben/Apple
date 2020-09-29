#import "MyLibs/Base/GObject.h"
#import "MyLibs/EventHandle/IDispatchObject.h"

/**
 * @brief 仅支持本地文件操作，仅支持同步操作
 */
@interface MFileStream : GObject, IDispatchObject
{
@public 
	File mFile;
    FileInputStream mFileInputStream;
    FileOutputStream mFileOutputStream;

@protected
	String mFilePath;
    FileOpState mFileOpState;

    String mText;
    byte[] mBytes;
}

@property() File mFile;
@property() FileInputStream mFileInputStream;
@property() FileOutputStream mFileOutputStream;
@property() String mFilePath;

@property() FileOpState mFileOpState;
@property() String mText;
@property() byte[] mBytes;


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

-(void) seek:(long: offset origin:(MSeekOrigin) origin
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

-(String) readText;
-(String) readText:(int) offset;
-(String) readText:(int) offset count:(int) count;
-(String) readText:(int) offset count:(int) count encode:(MEncoding) encode;
-(byte[]) readByte;
-(byte[]) readByte:(int) offset;
-(byte[]) readByte:(int) offset count:(int) count;
-(void) writeText:(String) text;
-(void) writeText:(String) text gkEncode:(GkEncode) gkEncode;
- (void) writeByte(byte[] bytes;
- (void) writeByte(byte[] bytes, (int) offset;
- (void) writeByte(byte[] bytes, (int) offset, (int) count;
-(void) writeLine:(String) text;
-(void) writeLine:(String) text gkEncode:(GkEncode) gkEncode;

@end