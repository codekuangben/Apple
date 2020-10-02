#import "MyLibs/Tools/MEncoding.h"

static NSString* UTF8_STR  = @"UTF-8";
static NSString* GB2312_STR  = @"GB2312";
static NSString* Unicode_STR  = @"Unicode";
static NSString* Default_STR  = @"UTF-8";

static MEncoding* UTF8  = [[MEncoding alloc] init:UTF8_STR];
static MEncoding* GB2312  = [[MEncoding alloc] init:GB2312_STR];
static MEncoding* Unicode  = [[MEncoding alloc] init:Unicode_STR];
static MEncoding* Default  = [[MEncoding alloc] init:Default_STR];

@implementation MEncoding

- (id) init: (NSString*) encodeStr
{
    if(self = [super init])
    {
        self->mTypeId = @"MEncoding";
        self->mEncodeStr = encodeStr;
    }
    
    return self;
}

- (NSString*) GetString: (char[]) bytes
{
    //return  self->GetString(bytes, 0, bytes.length);
    return nil;
}

- (NSString*) GetString: (char[]) bytes startIndex: (int) startIndex
{
    //return self->GetString(bytes, startIndex, bytes.length - startIndex);
    return nil;
}

- (NSString*) GetString:(char[]) bytes startIndex: (int) startIndex len:(int) len
{
    NSString* ret = @"";
    
    /*
    try
    {
        ret = new NSString*(MArray.getSubBytes(bytes, startIndex, len), self->mEncodeStr);
    }
    catch(UnsupportedEncodingException e)
    {
        
    }
     */
    
    return ret;
}

- (int) GetByteCount: (NSString*) str
{
    int len = 0;
    
    /*
    try
    {
        char[] bytes = str.getBytes(self->mEncodeStr);
        len = bytes.length;
    }
    catch(UnsupportedEncodingException e)
    {
        
    }
     */
    
    return len;
}

- (char*) GetBytes:(NSString*) str
{
    char* bytes = nil;
    
    /*
    try
    {
        bytes = str.getBytes(self->mEncodeStr);
    }
    catch(UnsupportedEncodingException e)
    {
        
    }
     */
    
    return bytes;
}

@end
