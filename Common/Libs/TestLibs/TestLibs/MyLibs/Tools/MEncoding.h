@interface MEncoding
{
@public
    static final NSString UTF8_STR  = "UTF-8";
    static final NSString GB2312_STR  = "GB2312";
    static final NSString Unicode_STR  = "Unicode";
    static final NSString Default_STR  = "UTF-8";

    static final MEncoding UTF8  = new MEncoding(MEncoding.UTF8_STR);
    static final MEncoding GB2312  = new MEncoding(MEncoding.GB2312_STR);
    static final MEncoding Unicode  = new MEncoding(MEncoding.Unicode_STR);
    static final MEncoding Default  = new MEncoding(MEncoding.Default_STR);

@protected
    NSString mEncodeStr;
}

@property() NSString mEncodeStr;

- (id) init: (NSString) encodeStr;
- (NSString) GetString: (byte[]) bytes;
- (NSString) GetString: (byte[]): bytes, startIndex: (int) startIndex;
- (NSString) GetString:(byte[]) bytes, startIndex: (int) startIndex, len:(int) len;
- (int) GetByteCount: (NSString) str;
- (byte[]) GetBytes:(NSString) str;

@end