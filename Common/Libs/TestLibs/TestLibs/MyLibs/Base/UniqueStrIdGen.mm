#import "MyLibs/Base/UniqueStrIdGen.h"

static NSString* PlayerPrefix = @"PL";
static NSString* PlayerChildPrefix = @"PC";
static NSString* PlayerSnowBlockPrefix = @"PSM";
static NSString* RobotPrefix = @"RT";
static NSString* SnowBlockPrefix = @"SM";

@implementation UniqueStrIdGen

- (id) init: (NSString*) prefix baseUniqueId: (int) baseUniqueId
{
    if(self = [super init: baseUniqueId])
    {
        self->mPrefix = prefix;
    }

    return self;
}

- (NSString*) genNewStrId
{
    self->mRetId = [NSString stringWithFormat:@"%s_%s", self->mPrefix, self->genNewId()];
    return self->mRetId;
}

- (NSString*) getCurStrId
{
    return self->mRetId;
}

- (NSString*) genStrIdById:(int) id
{
    self->mRetId = [NSString stringWithFormat:"%s_%d", mPrefix, id];
    return self->mRetId;
}

@end
