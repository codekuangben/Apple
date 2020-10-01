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
	NSString* mFilePath;
    FileOpState mFileOpState;

    NSString* mText;
    char[] mBytes;
}

@property() File mFile;
@property() FileInputStream mFileInputStream;
@property() FileOutputStream mFileOutputStream;
@property() NSString* mFilePath;

@property() FileOpState mFileOpState;
@property() NSString* mText;
@property() char[] mBytes;


-(id) init:(NSString*) filePath
{
	if(self = [super init])
	{
		self->mTypeId = "MFileStream";

		self->mFilePath = filePath;
		self->mFileOpState = FileOpState.eNoOp;

		[self checkAndOpen];
	}
}

-(void) seek:(long: offset origin:(MSeekOrigin) origin
{
	if(self->mFileOpState == FileOpState.eOpenSuccess)
	{
		if(MSeekOrigin.Begin == origin)
		{
			try
			{
				if(nil != self->mFileInputStream)
				{
					self->mFileInputStream.getChannel().position(offset);
				}

				if(nil != self->mFileOutputStream)
				{
					self->mFileOutputStream.getChannel().position(offset);
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
				if(nil != self->mFileInputStream)
				{
					self->mFileInputStream.getChannel().position(self->mFile.length() - 1 - offset);
				}

				if(nil != self->mFileOutputStream)
				{
					self->mFileOutputStream.getChannel().position(self->mFile.length() - 1 - offset);
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
				if(nil != self->mFileInputStream)
				{
					self->mFileInputStream.getChannel().position(self->mFileInputStream.getChannel().position() + offset);
				}

				if(nil != self->mFileOutputStream)
				{
					self->mFileOutputStream.getChannel().position(self->mFileOutputStream.getChannel().position() + offset);
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
	if(self->mFileOpState == FileOpState.eNoOp)
	{
		self->mFile = new File(self->mFilePath);
	}
}

-(void) syncOpenFileStream
{
	if (self->mFileOpState == FileOpState.eNoOp)
	{
		self->mFileOpState = FileOpState.eOpening;

		try
		{
			self->mFile = new File(mFilePath);
			self->mFileOpState = FileOpState.eOpenSuccess;
		}
		catch(Exception exp)
		{
			self->mFileOpState = FileOpState.eOpenFail;
		}
	}
}

-(BOOL) isValid
{
	return self->mFileOpState == FileOpState.eOpenSuccess;
}

// 获取总共长度
-(int) getLength
{
	(int) len = 0;

	if (self->mFileOpState == FileOpState.eOpenSuccess)
	{
		if (self->mFile != nil)
		{
			len = ((int))self->mFile.length();
		}
		/*
		if (mFileStream != nil && mFileStream.CanSeek)
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
	if (self->mFileOpState == FileOpState.eOpenSuccess)
	{
		if (self->mFile != nil)
		{
			try
			{
				if(nil != self->mFileInputStream)
				{
					self->mFileInputStream.close();
					self->mFileInputStream = nil;
				}

				if(nil != self->mFileInputStream)
				{
					self->mFileOutputStream.flush();

					self->mFileOutputStream.close();
					self->mFileOutputStream = nil;
				}
			}
			catch(Exception e)
			{

			}
		}

		self->mFileOpState = FileOpState.eOpenClose;
		self->mFileOpState = FileOpState.eNoOp;
	}
}

-(NSString*) readText;
-(NSString*) readText:(int) offset;
-(NSString*) readText:(int) offset count:(int) count;
-(NSString*) readText:(int) offset count:(int) count encode:(MEncoding) encode;
-(char[]) readByte;
-(char[]) readByte:(int) offset;
-(char[]) readByte:(int) offset count:(int) count;
-(void) writeText:(NSString*) text;
-(void) writeText:(NSString*) text gkEncode:(GkEncode) gkEncode;
- (void) writeByte(char[] bytes;
- (void) writeByte(char[] bytes, (int) offset;
- (void) writeByte(char[] bytes, (int) offset, (int) count;
-(void) writeLine:(NSString*) text;
-(void) writeLine:(NSString*) text gkEncode:(GkEncode) gkEncode;

@end