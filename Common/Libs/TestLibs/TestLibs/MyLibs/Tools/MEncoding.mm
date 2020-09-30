#import "MyLibs/Tools/MEncoding.h"

@implementation MEncoding

- (id) init: (NSString) encodeStr
{
    if(self = [super init])
    {
        self->mTypeId = @"MEncoding";
        self->mEncodeStr = encodeStr;
    }
    
    return self;
}

- (NSString) GetString: (byte[]) bytes
{
    return  self->GetString(bytes, 0, bytes.length);
}

- (NSString) GetString: (byte[]): bytes, startIndex: (int) startIndex
{
    return self->GetString(bytes, startIndex, bytes.length - startIndex);
}

- (NSString) GetString:(byte[]) bytes, startIndex: (int) startIndex, len:(int) len
{
    String ret = "";
    
    try
    {
        ret = new String(MArray.getSubBytes(bytes, startIndex, len), self->mEncodeStr);
    }
    catch(UnsupportedEncodingException e)
    {
        
    }
    
    return ret;
}

- (int) GetByteCount: (NSString) str
{
    (int) len = 0;
    
    try
    {
        byte[] bytes = str.getBytes(self->mEncodeStr);
        len = bytes.length;
    }
    catch(UnsupportedEncodingException e)
    {
        
    }
    
    return len;
}

- (byte[]) GetBytes:(NSString) str
{
    byte[] bytes = nil;
    
    try
    {
        bytes = str.getBytes(self->mEncodeStr);
    }
    catch(UnsupportedEncodingException e)
    {
        
    }
    
    return bytes;
}

@end