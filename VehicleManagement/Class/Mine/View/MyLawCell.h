//
//  MyLawCell.h
//  VehicleManagement
//
//  Created by mac on 2020/4/1.
//  Copyright © 2020 ZB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LawListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyLawCell : UITableViewCell

- (void)setData:(LawModel *)model;

@end

NS_ASSUME_NONNULL_END
