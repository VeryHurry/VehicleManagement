//
//  AnswerQuestionsViewController.m
//  VehicleManagement
//
//  Created by mac on 2019/12/19.
//  Copyright © 2019 ZB. All rights reserved.
//

#import "AnswerQuestionsViewController.h"
#import "TestResultViewController.h"

#import "testListModel.h"
#import "AnswerDetailModel.h"
#import "AnswerSubmitModel.h"

#import "TestView.h"
#import "AnswerSheetView.h"

@interface AnswerQuestionsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *menuBtn1;
@property (weak, nonatomic) IBOutlet UIButton *menuBtn2;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@property (weak, nonatomic) IBOutlet UIButton *btn3;

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) TestView *testView;
@property (nonatomic,strong) AnswerSheetView *sheetView;

@property (nonatomic,strong) testListModel *model;
@property (nonatomic, strong) NSArray *sortAnswerArr, *sortArr;
@property (nonatomic, strong) NSMutableArray *submitArr;

@property (nonatomic,assign) NSInteger index;

@end

@implementation AnswerQuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nav.title = self.examinationName;
    [self getMessage];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.index = 0;
    [self setUI];
    [self getMessage];
}

- (void)setUI
{
    [self setViewShadowView:_bgView backgroundColor:kWhite cornerRadius:8];
    [self setViewShadowView:_menuBtn1 backgroundColor:kWhite cornerRadius:5];
    [self setViewShadowView:_menuBtn2 backgroundColor:kWhite cornerRadius:5];
    [self setmenuBtnStyle:0];
    
    [self.bgView addSubview:self.testView];
    [self.bgView addSubview:self.sheetView];
    
    [_menuBtn1 xx_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self setmenuBtnStyle:0];
        self.testView.hidden = NO;
        self.sheetView.hidden = YES;
    }];
    
    [_menuBtn2 xx_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
    
        [self setmenuBtnStyle:1];
        self.testView.hidden = YES;
        self.sheetView.hidden = NO;
        
        [self.sheetView reload:[self judgeAnswer]];
    }];
    
    [self setBtnHiddenOrShow];
    
    [_btn1 xx_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if (!kIsEmptyArr(self.sortAnswerArr)) {
            self.index--;
            [self.testView setModel:self.sortAnswerArr[self.index] num:[NSString stringWithFormat:@"%ld/%lu",self.index+1,(unsigned long)self.sortAnswerArr.count]];
            [self setBtnHiddenOrShow];
        }
    }];
    
    [_btn2 xx_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if (!kIsEmptyArr(self.sortAnswerArr)) {
            self.index++;
            [self.testView setModel:self.sortAnswerArr[self.index] num:[NSString stringWithFormat:@"%ld/%lu",self.index+1,(unsigned long)self.sortAnswerArr.count]];
            [self setBtnHiddenOrShow];
        }
    }];
    
    [_btn3 xx_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if(self.index < self.sortArr.count -1 && !kIsEmptyArr(self.sortAnswerArr))
        {
            self.index++;
            [self.testView setModel:self.sortAnswerArr[self.index] num:[NSString stringWithFormat:@"%d/%lu",self.index+1,(unsigned long)self.sortAnswerArr.count]];
        }
        else
        {
            if (self.submitArr.count < self.model.subjectList.count) {
                [MBProgressHUD showMessag:@"请先完成试卷" toView:kWindow andShowTime:1];
            }
            else
            {
                NSDictionary *dic = [self submitData:[self sortSubmitArray:self.submitArr]] ;
                [self submitByData:dic];
            }
        }
        [self setBtnHiddenOrShow];
    }];
    
}

- (void)setmenuBtnStyle:(NSInteger)num
{
    if (num == 0) {
        self.menuBtn1.backgroundColor = kWhite;
        self.menuBtn1.xx_titleColor = Home_Text_Color;
        self.menuBtn2.backgroundColor =  ColorWithHex(0xEDEDED);
        self.menuBtn2.xx_titleColor =  ColorWithHex(0x808080);
    }
    else
    {
        self.menuBtn2.backgroundColor = kWhite;
        self.menuBtn2.xx_titleColor = Home_Text_Color;
        self.menuBtn1.backgroundColor =  ColorWithHex(0xEDEDED);
        self.menuBtn1.xx_titleColor =  ColorWithHex(0x808080);
    }
}

- (void)setBtnHiddenOrShow
{
    if (self.index == 0) {
        _btn1.hidden = YES;
        _btn3.hidden = YES;
        _btn2.hidden = NO;
    }
    else if(self.index > 0 && self.index < self.sortArr.count -1 && !kIsEmptyArr(self.sortArr))
    {
        _btn1.hidden = NO;
        _btn3.hidden = NO;
        _btn2.hidden = YES;
        _btn3.xx_title = @"下一题";
    }
    else if(self.index >= self.sortArr.count -1 && !kIsEmptyArr(self.sortArr))
    {
        _btn1.hidden = NO;
        _btn3.hidden = NO;
        _btn2.hidden = YES;
        _btn3.xx_title = @"提交";
    }
}



#pragma mark - Network
- (void)getMessage
{
    NSDictionary *dic = @{@"examinationNo":_examinationNo};
    [[XXNetWorkMangerBase sharedNetWorkManger] postWithUrl:api_getExamination andData:dic andSuccessBlock:^(id success) {
        if (!kIsEmptyObj(success)) {
            
            self.model = [testListModel modelWithJSON:success];
            self.sortAnswerArr = [self sortSubjectListArray:self.model.subjectList];
            self.sortArr = [self.model.result.titleNo componentsSeparatedByString:@","];
            //            [self.tableView reloadData];
            [self.testView setModel:self.sortAnswerArr[self.index] num:[NSString stringWithFormat:@"%ld/%lu",self.index+1,(unsigned long)self.sortAnswerArr.count]];
            [self.testView selectAnswerBlock:^(id obj) {
                AnswerSubmitModel *model = obj;
                [self addModel:model];
               
            }];
            [self.sheetView reload:[self judgeAnswer]];
        }
        
    } andFailureBlock:^(id failure) {
        
    }];
}

- (void)submitByData:(NSDictionary *)dic
{
    [[XXNetWorkMangerBase sharedNetWorkManger] postWithUrl:api_submitTest andData:dic andSuccessBlock:^(id success) {
        if (!kIsEmptyObj(success)) {
            TestResultViewController *vc = [TestResultViewController new];
            vc.resultDic = success;
            vc.examinationName = self.examinationName;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    } andFailureBlock:^(id failure) {
        
    }];
}


#pragma mark - other
- (void)setViewShadowView:(UIView *)view backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius
{
    view.backgroundColor = backgroundColor;
    view.layer.cornerRadius = cornerRadius;
    view.layer.shadowOffset = CGSizeMake(0.0, 3.0);
    view.layer.shadowColor = kLightGray.CGColor;
    view.layer.shadowOpacity = 0.8;
}

#pragma mark - data
- (void)addModel:(AnswerSubmitModel *)aModel
{
    __block BOOL isExist = NO;
    [self.submitArr enumerateObjectsUsingBlock:^(AnswerSubmitModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.titleNo == aModel.titleNo) {
            [self.submitArr replaceObjectAtIndex:idx withObject:aModel];
            *stop = YES;
            isExist = YES;
        }
    }];
    if (!isExist) {//如果不存在就添加进去
        [self.submitArr addObject:aModel];
    }
    //    NSLog(@"---------%@",self.submitArr);
}

- (NSDictionary *)submitData:(NSArray *)arr
{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    NSString *titleNo = @"";
    NSString *answerNo = @"";
    NSString *scoreNo = @"";
    for (int i = 0; i < arr.count; i ++) {
        AnswerSubmitModel *model = arr[i];
        if (i == 0) {
            titleNo = kStrNum(model.titleNo);
            answerNo = model.answerNo;
            scoreNo = kStrNum(model.scoreNo);
        }
        else
        {
            
            titleNo = [NSString stringWithFormat:@"%@,%ld",titleNo,(long)model.titleNo];
            answerNo = [NSString stringWithFormat:@"%@,%@",answerNo,model.answerNo];
            scoreNo = [NSString stringWithFormat:@"%@,%ld",scoreNo,(long)model.scoreNo];
        }
    }
//    [dic setObject:@"53,54,55,56,57,58,59,60,61,62,63,69,70,71,72,73,74,75,76,77,78,79,80,81,82,64,65,66,67,68" forKey:@"titleNo"];
    [dic setObject:titleNo forKey:@"titleNo"];
//    [dic setObject:@"A,A,A,B,B,A,A,B,B,A,C,B,C,D,B,D,C,C,B,C,B,D,C,C,D,ABC,ACD,ABCD,AB,ABCD" forKey:@"answerNo"];
    [dic setObject:answerNo forKey:@"answerNo"];
//    [dic setObject:@"2,2,2,2,2,2,2,2,2,2,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4" forKey:@"scoreNo"];
    [dic setObject:scoreNo forKey:@"scoreNo"];
    [dic setObject:_model.result.examinationNo forKey:@"examinationNo"];
    [dic setObject:kMobile forKey:@"mobile"];
    
    return dic;
}

- (NSArray *)getOptionsList:(NSString *)string {
    
    NSArray *arr = [string componentsSeparatedByString:@"|"];
    NSMutableArray *tempArr = [NSMutableArray new];
    for (NSString *str in arr) {
        NSArray *temp = [str componentsSeparatedByString:@":"];
        optionsList *model = [optionsList new];
        model.checked = NO;
        model.answerNo = temp[0];
        model.answer = temp[1];
        [tempArr addObject:model];
    }
    return tempArr;
}


- (NSArray *)sortSubjectListArray:(NSArray *)arr
{
    NSMutableArray *temp = [NSMutableArray new];
    for (Subjectlist *aModel in arr) {
        AnswerDetailModel *model = [AnswerDetailModel new];
        model.titleNo = aModel.ID;
        model.score = aModel.score;
        model.type = aModel.type;
        model.title = aModel.title;
        model.answer = aModel.answer;
        model.optionsList = [self getOptionsList:aModel.options];
        [temp addObject:model];
    }
    
    //排序（7-22不用排序）
    //    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"titleNo" ascending:YES];
    //    NSArray *tempArr = [temp sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    return temp;
}

- (NSArray *)sortSubmitArray:(NSArray *)arr
{
    //    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"titleNo" ascending:YES];
    //    NSArray *tempArr = [arr sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    NSMutableArray *tempArr = [NSMutableArray new];
    
    NSLog(@"sortArr==%@",self.sortArr);
    
    for (int i = 0; i < self.sortArr.count; i ++) {
        for (int j = 0; j < arr.count; j++) {
            AnswerSubmitModel *model = arr[j];
            if ([self.sortArr[i] integerValue] == model.titleNo) {
                [tempArr addObject:model];
            }
        }
    }
    
    
    return tempArr;
}

- (NSArray *)judgeAnswer
{
    NSMutableArray *temp = [NSMutableArray new];
    for (int i = 0; i < _sortAnswerArr.count; i ++) {
        AnswerDetailModel *model = _sortAnswerArr[i];
        //        for (int j = 0; j < _submitArr.count; j ++) {
        //            AnswerSubmitModel *subModel = _sortAnswerArr[j];
        //            if (model.titleNo == subModel.titleNo) {
        //
        //            }
        //        }
        
        __block BOOL isExist = NO;
        [self.submitArr enumerateObjectsUsingBlock:^(AnswerSubmitModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.titleNo == model.titleNo) {
                [temp addObject:@"1"];
                *stop = YES;
                isExist = YES;
            }
        }];
        if (!isExist) {//如果不存在就添加进去
            [temp addObject:@"0"];
        }
        
        
    }
    return temp;
}

#pragma mark - get
- (NSMutableArray *)submitArr
{
    if (!_submitArr) {
        _submitArr = [NSMutableArray new];
    }
    return _submitArr;
}

- (TestView *)testView
{
    if (!_testView) {
        _testView = [[TestView alloc]initWithFrame:kFrame(0, 10, self.bgView.xx_width, 450)];
    }
    return _testView;
}

- (AnswerSheetView *)sheetView
{
    if (!_sheetView) {
        
        CGFloat width = kScale_W(32) ;
        CGFloat spacing_v = kScale_W(20);
        CGFloat height = spacing_v*5 +width*6+50;
        _sheetView = [[AnswerSheetView alloc]initWithFrame:kFrame(0, 10, self.bgView.xx_width, height) type:0 block:^(NSInteger num) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

                self.index = num;
                [self setmenuBtnStyle:0];
                [self setBtnHiddenOrShow];
                [self gotoCurrentIndex];
                
            });
        }];
        _sheetView.hidden = YES;
    }
    return _sheetView;
}


- (void)gotoCurrentIndex
{
    [self.testView setModel:self.sortAnswerArr[self.index] num:[NSString stringWithFormat:@"%ld/%lu",self.index+1,(unsigned long)self.sortAnswerArr.count]];
    self.sheetView.hidden = YES;
    self.testView.hidden = NO;
}

@end

