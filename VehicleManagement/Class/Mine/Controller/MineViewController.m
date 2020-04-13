//
//  MineViewController.m
//  VehicleManagement
//
//  Created by mac on 2020/2/26.
//  Copyright © 2020 ZB. All rights reserved.
//

#import "MineViewController.h"
#import "MyLawViewController.h"
#import "UserInfoModel.h"
#import "MineCell.h"

@interface MineViewController ()

@property (nonatomic, strong) UserInfoModel *model;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *telNo;
@property (weak, nonatomic) IBOutlet UILabel *parentName;
@property (weak, nonatomic) IBOutlet UILabel *integral;
//@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *head;

@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getUserInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nav.title = @"个人中心";
    self.nav.lblTitel.textColor = kWhite;
    self.nav.bgView.alpha = 0;
    self.nav.bgImg.image = kImage(@"bg_1");
    self.nav.btnleft.frame = kFrame(self.nav.btnleft.xx_x+5, self.nav.btnleft.xx_y, self.nav.btnleft.xx_width, self.nav.btnleft.xx_height);
    self.nav.btnRigth.frame = kFrame(self.nav.xx_width-20-22, self.nav.btnleft.xx_y, 22, 22);
    self.nav.btnleft.xx_img = kImage(@"shezhi");
    self.nav.btnRigth.xx_img = kImage(@"erweima");
    [self.nav sendSubviewToBack:self.nav.bgImg];
    self.tableView.frame = kFrame( 0, kNav_H + kScreen_W/375*115, kScreen_W, kScreen_H-kTab_H- kNav_H - kScreen_W/375*115);
    [self.tableView registerNib:[UINib nibWithNibName:@"MineCell" bundle:nil] forCellReuseIdentifier:@"mine_cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

- (void)setUI
{
    [_head sd_setImageWithURL:kUrl(self.model.headImg) placeholderImage:kImage(@"")];
    _name.text = _model.name;
    _telNo.text = _model.telNo;
    _integral.text = [NSString stringWithFormat:@"积分：%ld分",(long)_model.integral];
    _parentName.text = _model.parentName;
}

- (void)leftBarBtnClicked
{
    
}

- (void)rightBarBtnClicked
{
    
}

#pragma mark - Network
- (void)getUserInfo
{
    NSDictionary *dic = @{@"mobile":kMobile};
    [[XXNetWorkMangerBase sharedNetWorkManger] postWithUrl:api_userInfo andData:dic andSuccessBlock:^(id success) {
        if (!kIsEmptyObj(success)) {
            self.model = [UserInfoModel modelWithJSON:success[@"result"]];
            [self setUI];
        }
    } andFailureBlock:^(id failure) {
        
    }];
}

#pragma mark - tableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *titleArr = @[@"我的随手拍",@"我的违章",@"我的行程",@"我的消息",@"我的车辆",@"我的积分",@"绑定车辆"];
    NSArray *iconArr = @[@"我的随手拍",@"我的违章",@"我的行程",@"我的消息",@"我的车辆",@"我的积分",@"绑定车辆"];
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mine_cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setData:titleArr[indexPath.row] icon:iconArr[indexPath.row]];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 1:
        {
            MyLawViewController *vc = [MyLawViewController new];
            [self xx_pushVC:vc];
            break;
        }
            
        default:
            break;
    }
//    SQViolationsDetailViewController *vc = [SQViolationsDetailViewController new];
//    vc.model = _dataArr[indexPath.row];
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
