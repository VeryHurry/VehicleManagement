
//
//  MyTakePictureViewController.m
//  VehicleManagement
//
//  Created by mac on 2020/1/20.
//  Copyright © 2020 ZB. All rights reserved.
//

#import "MyTakePictureViewController.h"
#import "SQViolationsDetailViewController.h"
#import "ViolationsListModel.h"
#import "SQMyTakePictureCell.h"

@interface MyTakePictureViewController ()

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) ViolationsListModel *model;

@property (nonatomic, assign) CGFloat height;

@end

@implementation MyTakePictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nav.title = @"我的随手拍";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    
    self.tableView.frame = kFrame(0, kNav_H, kScreen_W, kScreen_H-kNav_H-kSafeAreaBottomHeight);
    [self.tableView registerNib:[UINib nibWithNibName:@"SQMyTakePictureCell" bundle:nil] forCellReuseIdentifier:@"myTakePicture_Cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.isOpenFooterRefresh = YES;
    [self getMessage];
}

#pragma mark - Network
- (void)getMessage
{
    NSDictionary *dic = @{@"mobile":@"15259203981",@"pageNum":kStrNum(self.pageNO),@"pageSize":kStrNum(self.pageSize)};
    [[XXNetWorkMangerBase sharedNetWorkManger] postWithUrl:api_myLawList andData:dic andSuccessBlock:^(id success) {
        if (!kIsEmptyObj(success)) {
            
            self.model = [ViolationsListModel modelWithJSON:success];
            self.dataArr = [NSMutableArray arrayWithArray:self.model.result];
            [self.tableView reloadData];
            
            if (self.model.total >self.pageSize*self.pageNO) {
                [self.tableView.mj_footer endRefreshing];
            }
            else
            {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        
    } andFailureBlock:^(id failure) {
        
    }];
}

- (void)footerRequestWithData
{
    self.pageNO ++;
    [self getMessage];
}

#pragma mark - tableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SQMyTakePictureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myTakePicture_Cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ViolationsModel *model = self.dataArr[indexPath.row];
    
    [cell setData:self.dataArr[indexPath.row]];
    [self setTextHightByLaw:model.law];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 190+_height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SQViolationsDetailViewController *vc = [SQViolationsDetailViewController new];
    vc.model = _dataArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 懒加载

-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

- (void)setTextHightByLaw:(NSString *)law
{
    CGSize size = [XXTollClass calStrSize:law andMaxSize:CGSizeMake(kScreen_W-18*2-15*2, 300) andFontSize:14];
    _height = size.height - 17;

    
}

@end
