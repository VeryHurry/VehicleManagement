//
//  ResultScoreView.m
//  VehicleManagement
//
//  Created by mac on 2020/1/9.
//  Copyright © 2020 ZB. All rights reserved.
//

#import "ResultScoreView.h"

@implementation ResultScoreView

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)data
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = kWhite;
        [self createUIByData:data];
    }
    return self;
}

- (void)createUIByData:(NSArray *)data
{
    for (int i = 0; i < data.count; i++) {
        NSInteger x = i %6;
        NSInteger y = i/6;
        CGFloat width = kScale_W(32) ;
        CGFloat spacing_h = (self.width - (width*6))/7;
        CGFloat spacing_v = 16;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.userInteractionEnabled = NO;
        btn.frame = kFrame((x+1)*spacing_h+ x*width, y*(spacing_v+width), width, width);
        [btn setTitle:kStrNum(i+1) forState:UIControlStateNormal];
        NSInteger a = [data[i] integerValue];
        if (a == 0) {
            [btn setBackgroundImage:kImage(@"wrong") forState:UIControlStateNormal];
            btn.xx_titleColor = ColorWithHex(0xFF8575);
        }
        else
        {
            [btn setBackgroundImage:kImage(@"right") forState:UIControlStateNormal];
            btn.xx_titleColor = ColorWithHex(0x64BE50);
        }
        btn.titleLabel.font = kFont_Medium(16);
        [self addSubview:btn];
    }
}

@end
