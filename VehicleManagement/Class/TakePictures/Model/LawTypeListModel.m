//
//Created by ESJsonFormatForMac on 20/01/18.
//

#import "LawTypeListModel.h"
@implementation ESRootClass

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"LawTypeListModel" : [LawTypeModel class]};
}


@end

@implementation LawTypeModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


