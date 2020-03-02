//
//  SQTestListCell.m
//  XiamenProject
//
//  Created by MacStudent on 2019/5/13.
//  Copyright © 2019 MacStudent. All rights reserved.
//

#import "SQTestListCell.h"
#import "ColorMacro.h"

@interface SQTestListCell ()
@property (weak, nonatomic) IBOutlet UILabel *headLbl;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *isFinish;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation SQTestListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = 5;
    _bgView.layer.shadowOffset = CGSizeMake(0.0, 5.0);
    _bgView.layer.shadowColor = kLightGray.CGColor;
    _bgView.layer.shadowOpacity = 0.8;
}

- (void)setData:(ExaminationModel *)model
{
    _title.text = model.examinationName;
    _content.text = model.createTime;
    if ([model.isFinish isEqualToString:@"1"]) {
        _isFinish.text = @"已完成";
        _isFinish.textColor = kBlue;
    }
    else
    {
        _isFinish.text = @"未完成";
        _isFinish.textColor = kRed;
    }
    
    if (model.type == 1) {
        _headLbl.text = @"必做";
    }
    else
    {
        _isFinish.text = @"选做";
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
