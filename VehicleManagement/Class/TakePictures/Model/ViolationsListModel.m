//
//Created by ESJsonFormatForMac on 20/02/18.
//

#import "ViolationsListModel.h"
@implementation ViolationsListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"result" : [ViolationsModel class]};
}


@end

@implementation ViolationsModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


