
//
//  SQMyTakePictureCell.m
//  VehicleManagement
//
//  Created by mac on 2020/2/19.
//  Copyright © 2020 ZB. All rights reserved.
//

#import "SQMyTakePictureCell.h"

@interface SQMyTakePictureCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *userId;
@property (weak, nonatomic) IBOutlet UILabel *orderNo;
@property (weak, nonatomic) IBOutlet UILabel *law;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (nonatomic, assign) CGFloat hight;

@end

@implementation SQMyTakePictureCell

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

- (void)setData:(ViolationsModel *)model
{
    _orderNo.text = [NSString stringWithFormat:@"订单：%@",model.orderNo];
    _userId.text = [NSString stringWithFormat:@"骑手编号：%@",model.userId];
    _law.text = [NSString stringWithFormat:@"违法类型：%@",model.law];
    _createTime.text = [NSString stringWithFormat:@"提交时间：%@",model.createTime];
    NSString *state = model.status == 0 || model.status == 1 ? @"未处理" : @"已处理";
    _status.text = [NSString stringWithFormat:@"处理状态：%@",state];
    _status.textColor = model.status == 0 || model.status == 1 ? kRed : kBlue;
    
//    [self setTextHightByLaw:model.law];
}

- (void)setTextHightByLaw:(NSString *)law
{
//    CGSize size = [XXTollClass calStrSize:law andMaxSize:CGSizeMake(kScreen_W-18*2-15*2, 300) andFontSize:14];
//    _hight = size.height - 17;
    
    
    

}

// 获取固定尺寸的图片

- (UIImage *)captureView:(UIView *)view{
    
    UIGraphicsBeginImageContext(view.frame.size);
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:context];
    
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

- (IBAction)look:(id)sender
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
