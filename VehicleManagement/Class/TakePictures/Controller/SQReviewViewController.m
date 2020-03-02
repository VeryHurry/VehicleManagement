//
//  SQReviewViewController.m
//  VehicleManagement
//
//  Created by mac on 2020/2/24.
//  Copyright © 2020 ZB. All rights reserved.
//

#import "SQReviewViewController.h"
#import "XG_AssetPickerController.h"
#import "SelectedAssetCell.h"
#import "CustomText.h"

#define kCollectionViewSectionInsetLeftRight 15
#define kItemCountAtEachRow 3
#define kMinimumInteritemSpacing 8
#define kMinimumLineSpacing 8

@interface SQReviewViewController ()<UITextViewDelegate,XG_AssetPickerControllerDelegate,UIAlertViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *orderNo;
@property (weak, nonatomic) IBOutlet UILabel *userId;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *remark;

@property (weak, nonatomic) IBOutlet UIView *imagesView;
@property (weak, nonatomic) IBOutlet UITextView *content;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray<XG_AssetModel *> *assets;
@property (nonatomic, strong) NSMutableArray *photoArr;
@property (nonatomic, strong) XG_AssetModel *placeholderModel;

@end

@implementation SQReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nav.title = @"申请复核";
    [self createUI];
}

- (void)createUI
{
    _orderNo.text = _model.orderNo;
    _userId.text = _model.userId;
    _type.text = _model.law;
    _time.text = kIsEmptyStr(_model.createTime) ? @"-":_model.createTime;
    _address.text = _model.lawAddress;
    _remark.text = kIsEmptyStr(_model.remark) ? @"-":_model.remark;
    
    // _placeholderLabel
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @" 请输入您要提交的复核理由";
    placeHolderLabel.textColor = kLightGray;
    [placeHolderLabel sizeToFit];
    [_content addSubview:placeHolderLabel];
    placeHolderLabel.font = kFont_Medium(14);
    [_content setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kScale_W(98), kScale_W(98));
    layout.minimumInteritemSpacing = kMinimumInteritemSpacing;
    layout.minimumLineSpacing = kMinimumLineSpacing;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView.collectionViewLayout = layout;
    [self.collectionView registerNib:[UINib nibWithNibName:@"SelectedAssetCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SelectedAssetCell class])];
    self.collectionView.scrollEnabled = NO;
}

#pragma mark - image delegatte
-(NSMutableArray<XG_AssetModel *> *)assets{
    if (!_assets) {
        _assets = @[self.placeholderModel].mutableCopy;
    }
    return _assets;
}

-(XG_AssetModel *)placeholderModel{
    if (!_placeholderModel) {
        _placeholderModel = [[XG_AssetModel alloc]init];
        _placeholderModel.isPlaceholder = YES;
    }
    return _placeholderModel;
}


- (void)openAlbum{
    __weak typeof (self) weakSelf = self;
    [[XG_AssetPickerManager manager] handleAuthorizationWithCompletion:^(XG_AuthorizationStatus aStatus) {
        if (aStatus == XG_AuthorizationStatusAuthorized) {
            [weakSelf showAssetPickerController];
        }else{
            [weakSelf showAlert];
        }
    }];
}

- (void)showAssetPickerController{
    XG_AssetPickerOptions *options = [[XG_AssetPickerOptions alloc]init];
    options.maxAssetsCount = 3;
    options.videoPickable = YES;
    NSMutableArray<XG_AssetModel *> *array = [self.assets mutableCopy];
    [array removeLastObject];//去除占位model
    options.pickedAssetModels = array;
    XG_AssetPickerController *photoPickerVc = [[XG_AssetPickerController alloc] initWithOptions:options delegate:self];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:photoPickerVc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)showAlert{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"未开启相册权限，是否去设置中开启？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
    [alert show];
}

- (void)onDeleteBtnClick:(UIButton *)sender{
    /*
     performBatchUpdates并不会调用代理方法collectionView: cellForItemAtIndexPath，
     如果用删除按钮的tag来标识则tag不会更新,所以此处没有用tag
     */
    SelectedAssetCell *cell = (SelectedAssetCell *)sender.superview.superview;
    NSIndexPath *indexpath = [self.collectionView indexPathForCell:cell];
    [self.collectionView performBatchUpdates:^{
        [self.collectionView deleteItemsAtIndexPaths:@[indexpath]];
        [self.assets removeObjectAtIndex:indexpath.item];
        [self.photoArr removeObjectAtIndex:indexpath.item];
        if (self.assets.count == 2 && ![self.assets containsObject:self.placeholderModel]) {
            [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:2 inSection:0]]];
            [self.assets addObject:self.placeholderModel];
        }
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        //取消
    }else{
        //去设置
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.assets.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SelectedAssetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SelectedAssetCell class]) forIndexPath:indexPath];
    cell.model = self.assets[indexPath.item];
    [cell.deleteBtn addTarget:self action:@selector(onDeleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    XG_AssetModel *model = self.assets[indexPath.item];
    if (model.isPlaceholder) {
        [self openAlbum];
    }
}

#pragma mark - XG_AssetPickerControllerDelegate

- (void)assetPickerController:(XG_AssetPickerController *)picker didFinishPickingAssets:(NSArray<XG_AssetModel *> *)assets{
    NSMutableArray *newAssets = assets.mutableCopy;
    if (newAssets.count < 3 ) {
        [newAssets addObject:self.placeholderModel];
    }
    self.assets = newAssets;
    
    [self.photoArr removeAllObjects];
    for (int i = 0; i < assets.count; i ++) {
        XG_AssetModel *model = assets[i];
        [[XG_AssetPickerManager manager] getPhotoWithAsset:model.asset photoWidth:kScreen_W completion:^(UIImage *photo, NSDictionary *info) {
            
            [self.photoArr addObject:photo];
        }];
    }
    [self.collectionView reloadData];
}

#pragma mark - 懒加载
- (NSMutableArray *)photoArr
{
    if (!_photoArr) {
        _photoArr = [NSMutableArray new];
    }
    return _photoArr;
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
