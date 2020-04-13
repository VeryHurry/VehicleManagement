//
//  MyLawCell.m
//  VehicleManagement
//
//  Created by mac on 2020/4/1.
//  Copyright © 2020 ZB. All rights reserved.
//

#import "MyLawCell.h"

@interface MyLawCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImg;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *vehicleNo;
@property (weak, nonatomic) IBOutlet UILabel *orderNo;
@property (weak, nonatomic) IBOutlet UILabel *law;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *status;

@end

@implementation MyLawCell

- (void)awakeFromNib {
    [super awakeFromNib];
     _bgImg.frame = kFrame(_bgImg.xx_x, _bgImg.xx_y, kScreen_W-15*2, _bgImg.xx_max_y);
       UIImage *initialImage = [UIImage imageNamed:@"box"];
       UIImage *rightStretchImage = [initialImage resizableImageWithCapInsets:UIEdgeInsetsMake(120, 0, 40, 0) resizingMode:UIImageResizingModeStretch];
       _bgImg.image = rightStretchImage;
       
       _bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;//阴影颜色
       _bgView.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
       _bgView.layer.shadowOpacity = 0.5;//不透明度
       _bgView.layer.shadowRadius = 5.0;//半径
}

- (void)setData:(LawModel *)model
{
    _orderNo.text = [NSString stringWithFormat:@"订单：%@",model.orderNo];
    _vehicleNo.text = [NSString stringWithFormat:@"车牌号：%@",model.vehicleNo];
    _law.text = [NSString stringWithFormat:@"违章：%@",model.law];
    _createTime.text = [NSString stringWithFormat:@"时间：%@",model.createTime];
    _address.text = [NSString stringWithFormat:@"地址：%@",model.lawAddress];
    NSString *state = model.status == 0 || model.status == 1 ? @"未处理" : @"已处理";
    _status.text = [NSString stringWithFormat:@"状态：%@",state];
    _status.textColor = model.status == 0 || model.status == 1 ? kRed : kBlue;
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
