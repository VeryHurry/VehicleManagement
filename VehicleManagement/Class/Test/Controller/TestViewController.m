//
//  TestViewController.m
//  VehicleManagement
//
//  Created by mac on 2019/12/16.
//  Copyright © 2019 ZB. All rights reserved.
//

#import "TestViewController.h"
#import "SQTestHeadViewController.h"
#import "ExaminationListModel.h"
#import "SQTestListCell.h"

@interface TestViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *testArr;

@property (nonatomic, strong) ExaminationListModel *model;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nav.title = @"培训考核";
    
    self.tableView.frame = kFrame(0, kNav_H, kScreen_W, kScreen_H-kNav_H-kSafeAreaBottomHeight);
    [self.tableView registerNib:[UINib nibWithNibName:@"SQTestListCell" bundle:nil] forCellReuseIdentifier:@"testList_cell"];
    
    [self getMessage];
    
}

#pragma mark - Network
- (void)getMessage
{
    NSDictionary *dic = @{@"mobile":kMobile};
    [[XXNetWorkMangerBase sharedNetWorkManger] postWithUrl:api_examinationList andData:dic andSuccessBlock:^(id success) {
        if (!kIsEmptyObj(success)) {
            
            self.model = [ExaminationListModel modelWithJSON:success];
            self.testArr = self.model.result;
            [self.tableView reloadData];
        }
        
    } andFailureBlock:^(id failure) {
        
    }];
}

#pragma mark - tableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SQTestListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"testList_cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ExaminationModel *model = self.testArr[indexPath.row];
    [cell setData:model];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.testArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SQTestHeadViewController *vc = [[SQTestHeadViewController alloc]init];
    ExaminationModel *model = _testArr[indexPath.row];
    vc.examinationNo = model.examinationNo;
    vc.examinationName = model.examinationName;
    [self xx_pushVC:vc];
}


#pragma mark - 懒加载

-(NSArray *)testArr
{
    if (!_testArr) {
        _testArr = [NSArray new];
    }
    return _testArr;
}


@end
