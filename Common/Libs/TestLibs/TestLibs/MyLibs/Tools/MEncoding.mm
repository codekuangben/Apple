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

- (NSString) GetString: (char[]) bytes
{
    return  self->GetString(bytes, 0, bytes.length);
}

- (NSString) GetString: (char[]): bytes, startIndex: (int) startIndex
{
    return self->GetString(bytes, startIndex, bytes.length - startIndex);
}

- (NSString) GetString:(char[]) bytes, startIndex: (int) startIndex, len:(int) len
{
    NSString* ret = "";
    
    try
    {
        ret = new NSString*(MArray.getSubBytes(bytes, startIndex, len), self->mEncodeStr);
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
        char[] bytes = str.getBytes(self->mEncodeStr);
        len = bytes.length;
    }
    catch(UnsupportedEncodingException e)
    {
        
    }
    
    return len;
}

- (char[]) GetBytes:(NSString) str
{
    char[] bytes = nil;
    
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