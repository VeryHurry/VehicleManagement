//
//  TestViewHead.m
//  VehicleManagement
//
//  Created by mac on 2019/12/20.
//  Copyright © 2019 ZB. All rights reserved.
//

#import "TestViewHead.h"

#define LeftMargin 20
#define TopMargin 5

@interface TestViewHead ()
{
    CGFloat introHeight;
}

@property (weak, nonatomic) IBOutlet UILabel *typeLbl;
@property (weak, nonatomic) IBOutlet YYLabel *titleLbl;


@end

@implementation TestViewHead

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TestViewHead class]) owner:self options:nil] firstObject];
    }
    
    return self;
}

- (void)loadData:(AnswerDetailModel *)model num:(NSString *)num
{
    if (model.type == 1) {
        self.typeLbl.text = [NSString stringWithFormat:@"%@   单选题",num];
    }
    else
    {
        self.typeLbl.text = [NSString stringWithFormat:@"%@   多选题",num];
    }
    [self getLableHeight:model.title yyLabel:self.titleLbl];
    [self updateFrame];
    
}

- (CGFloat)getLableHeight:(NSString *)message yyLabel:(YYLabel *)lable{
    
    NSMutableAttributedString  *introText = [[NSMutableAttributedString  alloc] initWithString:message];
    introText.lineSpacing = 6;
    introText.minimumLineHeight = 15.0f;
    introText.font = kFont_Bold(14);
    introText.color = kGray;
    lable.attributedText = introText;
    CGSize introSize = CGSizeMake(kScreen_W-30 - LeftMargin*2, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:introSize text:introText];
    lable.textLayout = layout;
    introHeight = layout.textBoundingSize.height;
    return introHeight;
}

- (void)updateFrame {
    self.titleLbl.frame = CGRectMake(self.titleLbl.xx_x, self.titleLbl.xx_y, kScreen_W-30 - LeftMargin*2, introHeight);
    self.headerHeight = introHeight + 39;
}

@end
