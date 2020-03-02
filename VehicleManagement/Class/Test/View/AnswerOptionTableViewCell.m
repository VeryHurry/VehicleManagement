//
//  AnswerOptionTableViewCell.m
//  XiamenProject
//
//  Created by MacStudent on 2019/5/13.
//  Copyright © 2019 MacStudent. All rights reserved.
//

#import "AnswerOptionTableViewCell.h"
#import "ColorMacro.h"

@interface AnswerOptionTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *optionLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation AnswerOptionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.optionLabel.layer.cornerRadius = CGRectGetHeight(self.optionLabel.frame)/2;
//    self.optionLabel.layer.borderWidth = 0.5;
//    self.optionLabel.layer.borderColor = kBlue.CGColor;
//    self.optionLabel.layer.borderWidth = 0.5;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setModel:(optionsList *)model
{
    _model = model;
    if (model.checked) {
        self.contentLabel.textColor = kWhite;
        self.optionLabel.textColor = kWhite;
        self.bgView.backgroundColor = HomeColor;
    }
    else
    {
        self.contentLabel.textColor = kGray;
        self.optionLabel.textColor = kGray;
        self.bgView.backgroundColor = kBtnGray;
    }
    
    self.optionLabel.text = [NSString stringWithFormat:@"%@ . ",model.answerNo];
    self.contentLabel.text = [NSString stringWithFormat:@"%@",model.answer];
}



@end
