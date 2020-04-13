//
//Created by ESJsonFormatForMac on 20/04/09.
//

#import "LawListModel.h"
@implementation LawListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"result" : [LawModel class]};
}


@end

@implementation LawModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


