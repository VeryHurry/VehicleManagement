//
//  TestViewHead.h
//  VehicleManagement
//
//  Created by mac on 2019/12/20.
//  Copyright © 2019 ZB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnswerDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestViewHead : UIView

- (instancetype)initWithFrame:(CGRect)frame;

- (void)loadData:(AnswerDetailModel *)model num:(NSString *)num;

@property (nonatomic, assign) CGFloat headerHeight;

@end

NS_ASSUME_NONNULL_END
