//
//  AnswerDetailModel.m
//  XiamenProject
//
//  Created by MacStudent on 2019/5/15.
//  Copyright © 2019 MacStudent. All rights reserved.
//

#import "AnswerDetailModel.h"

@implementation AnswerDetailModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"optionsList" : [optionsList class]};
}



@end

@implementation optionsList

@end


