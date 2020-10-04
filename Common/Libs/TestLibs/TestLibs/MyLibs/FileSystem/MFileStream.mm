// #import "MyLibs/FileSystem/MFileStream.h"

// @implementation MFileStream

// -(id) init:(NSString*) filePath
// {
// 	if(self = [super init])
// 	{
// 		self->mTypeId = "MFileStream";

// 		self->mFilePath = filePath;
// 		self->mFileOpState = FileOpState.eNoOp;

// 		[self checkAndOpen];
// 	}
// }

// -(void) seek:(long) offset origin:(MSeekOrigin) origin
// {
// 	if(self->mFileOpState == FileOpState.eOpenSuccess)
// 	{
// 		if(MSeekOrigin.Begin == origin)
// 		{
// 			try
// 			{
// 				if(nil != self->mFileInputStream)
// 				{
// 					self->mFileInputStream.getChannel().position(offset);
// 				}

// 				if(nil != self->mFileOutputStream)
// 				{
// 					self->mFileOutputStream.getChannel().position(offset);
// 				}
// 			}
// 			catch (Exception e)
// 			{

// 			}
// 		}
// 		else if(MSeekOrigin.End == origin)
// 		{
// 			try
// 			{
// 				if(nil != self->mFileInputStream)
// 				{
// 					self->mFileInputStream.getChannel().position(self->mFile.length() - 1 - offset);
// 				}

// 				if(nil != self->mFileOutputStream)
// 				{
// 					self->mFileOutputStream.getChannel().position(self->mFile.length() - 1 - offset);
// 				}
// 			}
// 			catch (Exception e)
// 			{

// 			}
// 		}
// 		else
// 		{
// 			try
// 			{
// 				if(nil != self->mFileInputStream)
// 				{
// 					self->mFileInputStream.getChannel().position(self->mFileInputStream.getChannel().position() + offset);
// 				}

// 				if(nil != self->mFileOutputStream)
// 				{
// 					self->mFileOutputStream.getChannel().position(self->mFileOutputStream.getChannel().position() + offset);
// 				}
// 			}
// 			catch (Exception e)
// 			{

// 			}
// 		}
// 	}
// }

// -(void) dispose
// {
// 	[self close];
// }

// -(void) checkAndOpen
// {
// 	if(self->mFileOpState == FileOpState.eNoOp)
// 	{
// 		self->mFile = new File(self->mFilePath);
// 	}
// }

// -(void) syncOpenFileStream
// {
// 	if (self->mFileOpState == FileOpState.eNoOp)
// 	{
// 		self->mFileOpState = FileOpState.eOpening;

// 		try
// 		{
// 			self->mFile = new File(mFilePath);
// 			self->mFileOpState = FileOpState.eOpenSuccess;
// 		}
// 		catch(Exception exp)
// 		{
// 			self->mFileOpState = FileOpState.eOpenFail;
// 		}
// 	}
// }

// -(BOOL) isValid
// {
// 	return self->mFileOpState == FileOpState.eOpenSuccess;
// }

// // 获取总共长度
// -(int) getLength
// {
// 	(int) len = 0;

// 	if (self->mFileOpState == FileOpState.eOpenSuccess)
// 	{
// 		if (self->mFile != nil)
// 		{
// 			len = ((int))self->mFile.length();
// 		}
// 		/*
// 		if (mFileStream != nil && mFileStream.CanSeek)
// 		{
// 			try
// 			{
// 				len = ((int))mFileStream.Seek(0, SeekOrigin.End);     // 移动到文件结束，返回长度
// 				len = ((int))mFileStream.Position;                    // Position 移动到 Seek 位置
// 			}
// 			catch(Exception exp)
// 			{
// 			}
// 		}
// 		*/
// 	}

// 	return len;
// }

// -(void) close
// {
// 	if (self->mFileOpState == FileOpState.eOpenSuccess)
// 	{
// 		if (self->mFile != nil)
// 		{
// 			try
// 			{
// 				if(nil != self->mFileInputStream)
// 				{
// 					self->mFileInputStream.close();
// 					self->mFileInputStream = nil;
// 				}

// 				if(nil != self->mFileInputStream)
// 				{
// 					self->mFileOutputStream.flush();

// 					self->mFileOutputStream.close();
// 					self->mFileOutputStream = nil;
// 				}
// 			}
// 			catch(Exception e)
// 			{

// 			}
// 		}

// 		self->mFileOpState = FileOpState.eOpenClose;
// 		self->mFileOpState = FileOpState.eNoOp;
// 	}
// }

// -(NSString*) readText
// {
// 	return self->readText(0, 0, nil);
// }

// -(NSString*) readText:(int) offset
// {
// 	return self->readText(offset, 0, nil);
// }

// -(NSString*) readText:(int) offset count:(int) count
// {
// 	return self->readText(offset, count, nil);
// }

// -(NSString*) readText:(int) offset count:(int) count encode:(MEncoding) encode
// {
// 	self->checkAndOpen();

// 	NSString* retStr = "";
// 	char[] bytes = nil;

// 	if (encode == nil)
// 	{
// 		encode = MEncoding.UTF8;
// 	}

// 	if (count == 0)
// 	{
// 		count = getLength();
// 	}

// 	if (self->mFileOpState == FileOpState.eOpenSuccess)
// 	{
// 		if (self->mFile.canRead())
// 		{
// 			try
// 			{
// 				bytes = new char[count];
// 				self->mFileInputStream.read(bytes, 0, count);

// 				retStr = encode.GetString(bytes);
// 			}
// 			catch (Exception err)
// 			{

// 			}
// 		}
// 	}

// 	return retStr;
// }

// -(char[]) readByte
// {
// 	return self->readByte(0, 0);
// }

// -(char[]) readByte:(int) offset
// {
// 	return self->readByte(offset, 0);
// }

// -(char[]) readByte:(int) offset count:(int) count
// {
// 	self->checkAndOpen();

// 	if (count == 0)
// 	{
// 		count = getLength();
// 	}

// 	char[] bytes = nil;

// 	if (self->mFile.canRead())
// 	{
// 		try
// 		{
// 			bytes = new char[count];
// 			self->mFileInputStream.read(bytes, 0, count);
// 		}
// 		catch (Exception err)
// 		{

// 		}
// 	}

// 	return bytes;
// }

// -(void) writeText:(NSString*) text
// {
// 	self->writeText(text, MEncode.eUTF8);
// }

// -(void) writeText:(NSString*) text gkEncode:(MEncode) gkEncode
// {
// 	MEncoding encode = UtilSysLibsWrap.convGkEncode2EncodingEncoding(gkEncode);

// 	self->checkAndOpen();

// 	if (self->mFile.canWrite())
// 	{
// 		//if (encode == nil)
// 		//{
// 		//    encode = MEncode.UTF8;
// 		//}

// 		char[] bytes = encode.GetBytes(text);

// 		if (bytes != nil)
// 		{
// 			try
// 			{
// 				self->mFileOutputStream.write(bytes, 0, bytes.length);
// 			}
// 			catch (Exception err)
// 			{

// 			}
// 		}
// 	}
// }

// -(void) writeByte:(char[]) bytes
// {
// 	self->writeByte(bytes, 0, 0);
// }

// -(void) writeByte:(char[]) bytes offset:(int) offset
// {
// 	self->writeByte(bytes, offset, 0);
// }

// -(void) writeByte:(char[]) bytes offset:(int) offset count:(int) count
// {
// 	self->checkAndOpen();

// 	if (self->mFile.canWrite())
// 	{
// 		if (bytes != nil)
// 		{
// 			if (count == 0)
// 			{
// 				count = bytes.length;
// 			}

// 			if (count != 0)
// 			{
// 				try
// 				{
// 					self->mFileOutputStream.write(bytes, offset, count);
// 				}
// 				catch (Exception err)
// 				{

// 				}
// 			}
// 		}
// 	}
// }

// -(void) writeLine:(NSString*) text
// {
// 	self->writeLine(text, MEncode.eUTF8);
// }

// -(void) writeLine:(NSString*) text gkEncode:(MEncode) gkEncode
// {
// 	text = text + UtilSysLibsWrap.CR_LF;
// 	writeText(text, gkEncode);
// }

// @end