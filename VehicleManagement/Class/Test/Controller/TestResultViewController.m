//
//  TestResultViewController.m
//  VehicleManagement
//
//  Created by mac on 2020/1/3.
//  Copyright © 2020 ZB. All rights reserved.
//

#import "TestResultViewController.h"
#import "ResultScoreView.h"

@interface TestResultViewController ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIImageView *tipImage;
@property (weak, nonatomic) IBOutlet UILabel *scoreLbl;
@property (weak, nonatomic) IBOutlet UILabel *tipLbl;
@property (weak, nonatomic) IBOutlet UIView *scoreView;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;

@property (nonatomic,strong) ResultScoreView *resultView;

@end

@implementation TestResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhite;
    self.nav.title = @"测试结果";
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setUI];
}

- (void)setUI
{
    _titleLbl.text = self.examinationName;
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = 8;
    _bgView.layer.shadowOffset = CGSizeMake(0.0, 5.0);
    _bgView.layer.shadowColor = kLightGray.CGColor;
    _bgView.layer.shadowOpacity = 0.8;
    if (!kIsEmptyDic(_resultDic)) {
        if ([_resultDic[@"msg"] rangeOfString:@"未通过"].length != 0) {
            _tipImage.image = kImage(@"未通过");
            _scoreLbl.text = [NSString stringWithFormat:@"%@",_resultDic[@"result"]];
            _tipLbl.text = @"很遗憾，未通过考核";
            _btn1.hidden = NO;
            _btn2.hidden = YES;
            _btn3.hidden = NO;
        }
        else
        {
            _tipImage.image = kImage(@"通过");
            _scoreLbl.text = [NSString stringWithFormat:@"%@",_resultDic[@"result"]];
            _tipLbl.text = @"恭喜您，通过考核";
            _btn1.hidden = YES;
            _btn2.hidden = NO;
            _btn3.hidden = YES;
        }
        
        
        CGFloat width = kScale_W(32) ;
        CGFloat spacing_v = 16;
        CGFloat height = spacing_v*4 +width*5;
        self.resultView = [[ResultScoreView alloc]initWithFrame:kFrame(0, 0, self.scoreView.xx_width, height) data:_resultDic[@"rights"]];
        
        [self.scoreView addSubview:self.resultView];
        self.scoreView.frame = kFrame(self.scoreView.xx_x, self.scoreView.xx_y, self.scoreView.xx_width, height);
        
        self.btn1.frame = kFrame(self.btn1.xx_x, self.scoreView.xx_max_y+30, self.btn1.xx_width, self.btn1.xx_height);
        self.btn2.frame = kFrame(self.btn2.xx_x, self.scoreView.xx_max_y+30, self.btn2.xx_width, self.btn2.xx_height);
        self.btn3.frame = kFrame(self.btn3.xx_x, self.scoreView.xx_max_y+30, self.btn3.xx_width, self.btn3.xx_height);
        
    }
    
    [self.btn1 xx_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self xx_pop];
    }];
    [self.btn2 xx_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [self.btn3 xx_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
