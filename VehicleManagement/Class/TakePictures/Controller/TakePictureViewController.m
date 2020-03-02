//
//  TakePictureViewController.m
//  VehicleManagement
//
//  Created by mac on 2020/1/16.
//  Copyright © 2020 ZB. All rights reserved.
//

#import "TakePictureViewController.h"
#import "XG_AssetPickerController.h"
#import "SQMapViewController.h"
#import "MyTakePictureViewController.h"

#import "LawTypeListModel.h"

#import "SQChooseView.h"
#import "SelectedAssetCell.h"
#import "CustomText.h"

#define kCollectionViewSectionInsetLeftRight 15
#define kItemCountAtEachRow 3
#define kMinimumInteritemSpacing 8
#define kMinimumLineSpacing 8

@interface TakePictureViewController ()<UITextViewDelegate,XG_AssetPickerControllerDelegate,UIAlertViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;

@property (weak, nonatomic) IBOutlet UITextField *noLbl;
@property (weak, nonatomic) IBOutlet UITextView *content;
@property (weak, nonatomic) IBOutlet UILabel *typeLbl;
@property (weak, nonatomic) IBOutlet CustomText *addressLbl;
@property (weak, nonatomic) IBOutlet UIView *imagesView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray<XG_AssetModel *> *assets;
@property (nonatomic, strong) NSMutableArray *photoArr;
@property (nonatomic, strong) XG_AssetModel *placeholderModel;

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) SQChooseView *chooseView;

@property (nonatomic, strong) NSArray *dataArr, *selectArr;

@end

@implementation TakePictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getLawList];
    self.nav.title = @"随手拍";
    self.nav.btnleft.xx_img = kImage(@"");
    self.nav.btnRigth.frame = kFrame(self.nav.width-72-15, self.nav.btnRigth.xx_y, 72, self.nav.btnRigth.height);
    self.nav.btnRigth.xx_title = @"我的随手拍";
    self.nav.btnRigth.xx_titleColor = kBlack;
    self.nav.btnRigth.titleLabel.font = kFont_Medium(14);
    
    [self createUI];
}

- (void)rightBarBtnClicked
{
    MyTakePictureViewController *vc = [MyTakePictureViewController new];
    [self xx_pushVC:vc];
}

- (void)createUI
{
    // 通过运行时，发现UITextView有一个叫做“_placeHolderLabel”的私有变量
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UITextView class], &count);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *objcName = [NSString stringWithUTF8String:name];
        NSLog(@"%d : %@",i,objcName);
    }
    
    [_noLbl setValue:kLightGray forKeyPath:@"_placeholderLabel.textColor"];
    [_noLbl setValue:kFont_Medium(14) forKeyPath:@"_placeholderLabel.font"];
    
    _typeLbl.font = kFont_Medium(14);
    
    // _placeholderLabel
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @" 请输入您要提交的违规行为";
    placeHolderLabel.textColor = kLightGray;
    [placeHolderLabel sizeToFit];
    [_content addSubview:placeHolderLabel];
    placeHolderLabel.font = kFont_Medium(14);
    [_content setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    
    [self.view addSubview:self.maskView];
    
    
    UILabel *placeHolderLabel1 = [[UILabel alloc] init];
    placeHolderLabel1.text = @"请输入违规地址";
    placeHolderLabel1.textColor = kLightGray;
    [placeHolderLabel1 sizeToFit];
    [_addressLbl addSubview:placeHolderLabel1];
    placeHolderLabel1.font = kFont_Medium(14);
    [_addressLbl setValue:placeHolderLabel1 forKey:@"_placeholderLabel"];
//    _addressLbl.cm_placeholder =  @"请输入违规地址";
//    _addressLbl.cm_placeholderColor = kLightGray;
//    _addressLbl.cm_placeholderFont = kFont_Medium(14);
    _addressLbl.cm_maxNumberOfLines = 3;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kScale_W(98), kScale_W(98));
    layout.minimumInteritemSpacing = kMinimumInteritemSpacing;
    layout.minimumLineSpacing = kMinimumLineSpacing;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView.collectionViewLayout = layout;
    [self.collectionView registerNib:[UINib nibWithNibName:@"SelectedAssetCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SelectedAssetCell class])];
    self.collectionView.scrollEnabled = NO;
}

#pragma mark - Network
- (void)getLawList
{
    [[XXNetWorkMangerBase sharedNetWorkManger] postWithUrl:api_lawTypeList andData:@{} andSuccessBlock:^(id success) {
    
            if (!kIsEmptyObj(success)) {
                self.dataArr = [NSArray modelArrayWithClass:[LawTypeModel class] json:success[@"result"]];
                [kWindow addSubview:self.chooseView];
                
            }
        
        
    } andFailureBlock:^(id failure) {
        
    }];
}

- (void)networkingForUploadImg:(NSArray *)imgArr
{
    NSMutableDictionary *dic = [NSMutableDictionary new];
//    [dic setObject:self.noLbl.text forKey:@"staffNo"];
    [dic setObject:@"10004" forKey:@"staffNo"];
    
    [dic setObject:[self selectData][0] forKey:@"lawType"];
    
    [dic setObject:self.content.text forKey:@"law"];
    [dic setObject:self.addressLbl.text forKey:@"lawAddress"];
    //    [dic setObject:@"厦门市湖里区" forKey:@"lawAddress"];
    //    [dic setObject:@"垃圾垃圾垃圾" forKey:@"law"];
    [dic setObject:@"15259203981" forKey:@"createPerson"];
//    [dic setObject:[kUserDefaults objectForKey:@"mobile"] forKey:@"createPerson"];
    [dic setObject:@"1" forKey:@"channelType"];
    
    [[XXNetWorkMangerBase sharedNetWorkManger] postWithUrl:api_addLaw andImageArr:imgArr arameter:dic andSuccessBlock:^(id success) {
        
    } andFailureBlock:^(id failure) {
        
    }];
//    [[XXNetWorkMangerBase sharedNetWorkManger] postWithUrl:api_addLaw andData:dic andSuccessBlock:^(id success) {
//        
//        if (!kIsEmptyObj(success)) {
//            [MBProgressHUD showSuccess:success[@"msg"]];
//            
//        }
//        
//        
//    } andFailureBlock:^(id failure) {
//        
//    }];
}

#pragma mark - button action

- (IBAction)type_action:(id)sender
{
    if (!kIsEmptyArr(self.dataArr)) {
        [self.view endEditing:YES];
        
        [UIView animateWithDuration:0.2 animations:^{
            self.maskView.alpha = 0.4;
            self.chooseView.frame = kFrame(0, kScreen_H-(45+70+44*9.5), kScreen_W, 45+70+44*9.5);
        }];
    }
}

- (IBAction)address_action:(id)sender
{
    [self.view endEditing:YES];
    SQMapViewController *vc = [SQMapViewController new];
    [vc selectAddress:^(NSArray *arr) {
        self.addressLbl.text = arr[0];
    }];
    [self xx_pushVC:vc];
}

- (IBAction)submit_action:(id)sender
{
    if (kIsEmptyStr(_noLbl.text)) {
        [MBProgressHUD showError:@"请先输入员工编号"];
        return;
    }
    if (kIsEmptyStr(_typeLbl.text)||[_typeLbl.text isEqualToString:@"请选择违规类型"]) {
        [MBProgressHUD showError:@"请先选择违规类型"];
        return;
    }
    if (kIsEmptyStr(_addressLbl.text)||[_addressLbl.text isEqualToString:@"请选择违规地址"]) {
        [MBProgressHUD showError:@"请先选择违规地址"];
        return;
    }
    if (kIsEmptyStr(_content.text)||[_content.text isEqualToString:@"请输入您要提交的违规行为"]) {
        [MBProgressHUD showError:@"请输入您要提交的违规行为"];
        return;
    }
    if (kIsEmptyArr(_photoArr)) {
        [MBProgressHUD showError:@"请先选择违规图片"];
        return;
    }
    [self networkingForUploadImg:self.photoArr];
}

#pragma mark - 懒加载
- (NSMutableArray *)photoArr
{
    if (!_photoArr) {
        _photoArr = [NSMutableArray new];
    }
    return _photoArr;
}

- (SQChooseView *)chooseView
{
    if (!_chooseView) {
        _chooseView = [[SQChooseView alloc]initWithFrame:kFrame(0, kScreen_H, kScreen_W, 45+70+44*9.5) data:self.dataArr block:^(NSArray *arr) {
            if (!kIsEmptyArr(arr)) {
                self.selectArr = arr;
                self.typeLbl.text = [self selectData][1];
                self.typeLbl.textColor = kGray;
                self.typeLbl.font = kFont_Medium(16);
            }
            else
            {
                self.typeLbl.text = @" 请选择违规类型";
                self.typeLbl.textColor = kLightGray;
                self.typeLbl.font = kFont_Medium(14);
            }
            
            [UIView animateWithDuration:0.2 animations:^{
                self.maskView.alpha = 0;
                self.chooseView.frame = kFrame(0, kScreen_H, kScreen_W, 45+70+44*9.5);
            }];
            
            
        } closeBlock:^{
            [UIView animateWithDuration:0.2 animations:^{
                self.maskView.alpha = 0;
                self.chooseView.frame = kFrame(0, kScreen_H, kScreen_W, 45+70+44*9.5);
            }];
        }];
    }
    return _chooseView;
}

- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc]xx_initLineFrame:kFrame(0,0, kScreen_W, kScreen_H) color:kBlack];
        _maskView.alpha = 0;
        [_maskView xx_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [UIView animateWithDuration:0.2 animations:^{
                self.maskView.alpha = 0;
                self.chooseView.frame = kFrame(0, kScreen_H, kScreen_W, 45+70+44*9.5);
            }];
        }];
    }
    return _maskView;
}

#pragma mark - data
- (NSArray *)selectData
{
    NSArray *result = [self.selectArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSString *str1;
    NSString *str2;
    for (int i = 0; i <result.count; i ++) {
        for (int j = 0; j <self.dataArr.count; j ++) {
            LawTypeModel *model = self.dataArr[j];
            if ([result[i] integerValue] == model.ID-1) {
                if (kIsEmptyStr(str1)) {
                    str1 = kStrNum(model.ID);
                    str2 = model.content;
                }
                else
                {
                    str1 = [NSString stringWithFormat:@"%@,%@",str1,kStrNum(model.ID)];
                    str2 = [NSString stringWithFormat:@"%@;%@",str2,model.content];
                }
            }
        }
    }
    return @[str1,str2];
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


#pragma mark - text view delegate
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView == _addressLbl) {
        
    
    if ([textView.text length] > 40) {
        textView.text = [textView.text substringWithRange:NSMakeRange(0, 60)];
        [textView.undoManager removeAllActions];
        [textView becomeFirstResponder];
        return;
    }
    }
}


@end
