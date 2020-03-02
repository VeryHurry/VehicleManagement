//
//Created by ESJsonFormatForMac on 19/12/19.
//

#import "ExaminationListModel.h"
@implementation ExaminationListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"result" : [ExaminationModel class]};
}


@end

@implementation ExaminationModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


