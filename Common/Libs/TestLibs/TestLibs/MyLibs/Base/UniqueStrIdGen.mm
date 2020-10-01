#import "MyLibs/Base/UniqueStrIdGen.h"

static String PlayerPrefix = @"PL";
static String PlayerChildPrefix = @"PC";
static String PlayerSnowBlockPrefix = @"PSM";
static String RobotPrefix = @"RT";
static String SnowBlockPrefix = @"SM";

@implementation UniqueStrIdGen

- (id) init: (String) prefix baseUniqueId: (int) baseUniqueId
{
    if(self = [super init: baseUniqueId])
    {
        self->mPrefix = prefix;
    }

    return self;
}

- (String) genNewStrId
{
    self->mRetId = [NSString stringWithFormat:@"%s_%s", self->mPrefix, self->genNewId()];
    return self->mRetId;
}

- (String) getCurStrId
{
    return self->mRetId;
}

- (String) genStrIdById:(int) id
{
    self->mRetId = [NSString stringWithFormat:"%s_%d", mPrefix, id);
    return self->mRetId;
}

@end
