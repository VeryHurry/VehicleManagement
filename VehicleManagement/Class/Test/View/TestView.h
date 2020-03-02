//
//  TestView.h
//  VehicleManagement
//
//  Created by mac on 2019/12/20.
//  Copyright © 2019 ZB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnswerDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestView : UIView

@property (nonatomic,strong) AnswerDetailModel *model;

- (void)setModel:(AnswerDetailModel *)model num:(NSString *)num;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)selectAnswerBlock:(XXObjBlock)block;

@end

NS_ASSUME_NONNULL_END
