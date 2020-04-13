//
//  HomeViewController.m
//  VehicleManagement
//
//  Created by mac on 2019/12/16.
//  Copyright © 2019 ZB. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "SQTabbarViewController.h"

#import "GoTestView.h"

@interface HomeViewController ()

@property (nonatomic, strong) UIView *maskView;

@end

@implementation HomeViewController

- (void)isJumpLoginVC
{
    if (![kUserDefaults boolForKey:@"isLogin"]){
       
        LoginViewController *loginVC = (LoginViewController *)[self xx_getSb:@"Login" identifier:@"login_sb"];
        loginVC.modalPresentationStyle = 0;
        [self presentViewController:loginVC animated:YES completion:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self isJumpLoginVC];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setUI];
//    [kWindow addSubview:self.maskView];
//    [GoTestView alertWithBlock:^{
//        self.tabBarController.selectedIndex = 1;
//        self.maskView.alpha = 0;
//    }];
}

- (void)setUI
{
//    UIImageView *img = [[UIImageView alloc]initWithFrame:kFrame(10, 50, 370, 231)];
//    img.image = kImage(@"box");
//    [self.view addSubview:img];
    
//    [image1 resizableImageWithCapInsets:UIEdgeInsetsMake(image1.size.height*0.9, image1.size.width*0.9, image1.size.height*0.9, image1.size.width*0.9)resizingMode:UIImageResizingModeStretch];
    
    UIImage *image =[UIImage imageNamed:@"box"];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(20,60, 370, 231)];
    
    imageView.image=image;
    
    [self.view addSubview:imageView];
    
    UIImage *image1 = [UIImage imageNamed:@"box"];
    
//        [image1 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, image1.size.height*0.9, 0)resizingMode:UIImageResizingModeStretch];
    
//    image1=[image1  stretchableImageWithLeftCapWidth:image1.size.width*0.1 topCapHeight:image1.size.height*0.1];
    
    CGFloat top = 0; // 顶端盖高度
    CGFloat bottom = 200 ; // 底端盖高度
    CGFloat left = 0; // 左端盖宽度
    CGFloat right = 0; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 指定为拉伸模式，伸缩后重新赋值
    image1 = [image1 resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(20,300,370,431)];
    
    imageView1.image=image1;
    
    [self.view addSubview:imageView1];
}

//- (UIImage *)stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight __TVOS_PROHIBITED;
//{
//    //leftCapWidth:左边不拉伸区域
//
//    //topCapHeight:上面不拉伸区域
//
//    UIImage *image =[UIImage imageNamed:@"box"];
//
//    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(20,60, image.size.width, image.size.height)];
//
//    imageView.image=image;
//
//    [self.view addSubview:imageView];
//
//    UIImage *image1 = [UIImage imageNamed:@"box"];
//
//    image1=[image1  stretchableImageWithLeftCapWidth:image1.size.width*0.3 topCapHeight:image1.size.height*0.7];
//
//    UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(20,220,200,150)];
//
//    imageView1.image=image1;
//
//    [self.view addSubview:imageView1];
//}

- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:kFrame(0, 0, kScreen_W, kScreen_H)];
        _maskView.backgroundColor = kBlack;
        _maskView.alpha = 0.6;
    }
    return _maskView;
}

@end



