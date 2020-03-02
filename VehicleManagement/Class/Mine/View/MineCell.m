//
//  MineCell.m
//  VehicleManagement
//
//  Created by mac on 2020/2/27.
//  Copyright © 2020 ZB. All rights reserved.
//

#import "MineCell.h"

@interface MineCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIImageView *icon;


@end

@implementation MineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(NSString *)title icon:(NSString *)icon
{
    _titleLbl.text = title;
    _icon.image = kImage(icon);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
