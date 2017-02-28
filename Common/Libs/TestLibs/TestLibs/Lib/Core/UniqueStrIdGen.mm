@import "UniqueStrIdGen.h"

static NSString* PlayerPrefix = @"PL";
static NSString* PlayerChildPrefix = @"PC";
static NSString* PlayerSnowBlockPrefix = @"PSM";
static NSString* RobotPrefix = @"RT";
static NSString* SnowBlockPrefix = @"SM";

@implementation UniqueStrIdGen

- (id) init: (NSString*) prefix baseUniqueId: (int) baseUniqueId
{
    super(baseUniqueId);

    this.mPrefix = prefix;
}

public String genNewStrId()
{
    this.mRetId = String.format("{0}_{1}", this.mPrefix, this.genNewId());
    return this.mRetId;
}

public String getCurStrId()
{
    return this.mRetId;
}

public String genStrIdById(int id)
{
    this.mRetId = String.format("{0}_{1}", mPrefix, id);
    return this.mRetId;
}

@end
