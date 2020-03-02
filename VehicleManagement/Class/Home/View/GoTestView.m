//
//  GoTestView.m
//  VehicleManagement
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 ZB. All rights reserved.
//

#import "GoTestView.h"

@implementation GoTestView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = kWhite;
}

+ (void)alertWithBlock:(XXVoidBlock)block
{
    
    GoTestView * alertView = [[NSBundle mainBundle] loadNibNamed:@"GoTestView" owner:nil options:nil].firstObject;
    
    alertView.frame = CGRectMake(0, 0, 265, 332);
    
    alertView.block = block;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.2;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [alertView.layer addAnimation:animation forKey:nil];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    alertView.center = keyWindow.center;
    [keyWindow addSubview:alertView];
    
}

- (IBAction)gotoTest:(id)sender {
    if (self.block) {
        self.block();
    }
    [self removeFromSuperview];
    
}

@end
