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

    self.mPrefix = prefix;
}

- (NSString*) genNewStrId
{
    self.mRetId = String.format("{0}_{1}", self.mPrefix, self.genNewId());
    return self.mRetId;
}

public String getCurStrId()
{
    return self.mRetId;
}

public String genStrIdById(int id)
{
    self.mRetId = String.format("{0}_{1}", mPrefix, id);
    return self.mRetId;
}

@end
