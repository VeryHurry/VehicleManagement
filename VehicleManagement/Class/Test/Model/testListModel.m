//
//Created by ESJsonFormatForMac on 19/12/20.
//

#import "testListModel.h"
@implementation testListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"subjectList" : [Subjectlist class]};
}


@end

@implementation TestModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


@implementation Subjectlist


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


