//
//  LoginViewController.m
//  VehicleManagement
//
//  Created by mac on 2019/12/16.
//  Copyright © 2019 ZB. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *user_txt;
@property (weak, nonatomic) IBOutlet UIButton *detele_btn;
@property (weak, nonatomic) IBOutlet UILabel *user_lbl;
@property (weak, nonatomic) IBOutlet UITextField *password_txt;
@property (weak, nonatomic) IBOutlet UIButton *password_btn;
@property (weak, nonatomic) IBOutlet UILabel *password_lbl;

@property (weak, nonatomic) IBOutlet UIButton *remember_btn;
@property (weak, nonatomic) IBOutlet UILabel *forget_btn;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setUI
{
    _detele_btn.xx_touchAreaInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    _password_btn.xx_touchAreaInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    _remember_btn.xx_touchAreaInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    [_forget_btn xx_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
    }];
    
    
}

#pragma mark - networking
//登录
- (void)userLogin
{
//    NSDictionary *dic = @{@"accountNo":_user_txt.text,@"password":_password_txt.text};
    NSDictionary *dic = @{@"mobile":@"15259203981",@"password":@"123456"};
    [[XXNetWorkMangerBase sharedNetWorkManger] postWithUrl:api_login andData:dic andSuccessBlock:^(id success) {
//        UserModel *model = [UserModel modelWithJSON:success[@"rows"]];
//        [kUserDefaults setObject:success[@"rows"] forKey:def_userModel];
//        [kUserDefaults setObject:model.accountNo forKey:def_phone];
//        [kUserDefaults setObject:model.ID forKey:def_id];
//        if (self.remember_btn.selected) {
//            [kUserDefaults setObject:self.password_txt.text forKey:def_password];
//        }
//        else
//        {
//            [kUserDefaults removeObjectForKey:def_password];
//        }
//        [kUserDefaults synchronize];
//
        [self dismissViewControllerAnimated:YES completion:nil];
        [MBProgressHUD showSuccess:txt_login toView:kWindow];
    } andFailureBlock:^(id failure) {

    }];
}


- (IBAction)login_action:(id)sender
{
//    if (kIsEmptyStr(_user_txt.text))
//    {
//        [MBProgressHUD showError:txt_emptyPhone];
//    }
//    else if (![XXTollClass isTelphoneNum:_user_txt.text])
//    {
//        [MBProgressHUD showError:txt_phoneError];
//    }
//    else if (kIsEmptyStr(_password_txt.text))
//    {
//        [MBProgressHUD showError:txt_emptyPassword1];
//    }
//    else
//    {
        [self.view endEditing:YES];
        [self userLogin];
//    }
}

- (IBAction)remember_action:(id)sender
{
    _remember_btn.selected = !_remember_btn.selected;
    _remember_btn.xx_img = _remember_btn.selected?kImage(@"xuanzhong"):kImage(@"weixuanzhong");
}

- (IBAction)password_action:(id)sender
{
    _password_txt.secureTextEntry = _password_btn.selected;
    _password_btn.selected = !_password_btn.selected;
    _password_btn.xx_img = _password_btn.selected?kImage(@"yanjing"):kImage(@"guanbi-yanjing");
}

- (IBAction)detele_action:(id)sender
{
    _user_lbl.hidden = YES;
    _user_txt.text = @"";
    if (!_user_txt.isFirstResponder) {
        [_user_txt becomeFirstResponder];
    }
    
}

//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    if (textField == _user_txt) {
//        _user_lbl.hidden = YES;
//    }
//    else if (textField == _password_txt)
//    {
//        _password_lbl.hidden = YES;
//    }
//}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _user_txt) {
        _user_lbl.hidden = YES;
    }
    else if (textField == _password_txt)
    {
        _password_lbl.hidden = YES;
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField == _user_txt) {
        if (textField.text.length == 0) {
            _user_lbl.hidden = NO;
        }
        
    }
    else if (textField == _password_txt)
    {
        if (textField.text.length == 0) {
            _password_lbl.hidden = NO;
        }
    }
    return YES;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if (textField == _user_txt) {
//        if (textField.text.length != 0) {
//            _user_lbl.hidden = YES;
//        }
//        else
//        {
//            _user_lbl.hidden = NO;
//        }
//    }
//    if (textField == _password_txt) {
//        if (textField.text.length != 0) {
//            _password_lbl.hidden = YES;
//        }
//        else
//        {
//            _password_lbl.hidden = NO;
//        }
//    }
//
//    return YES;
//}

@end
