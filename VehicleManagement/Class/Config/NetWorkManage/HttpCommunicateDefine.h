
#ifndef HttpCommunicateDefine_h
#define HttpCommunicateDefine_h

/*
 IS_DEBUG  1 开发布环境
           2 生产环境
          
 */

#define IS_DEBUG  1

#if IS_DEBUG==1

#define URL_BASE          @"http://59.56.111.74:18084"
#define CARURL_BASE          @"http://59.56.111.74:18080"

#elif IS_DEBUG==2

//#define URL_BASE          @"http://192.168.1.137:8084"
//#define CARURL_BASE          @"http://192.168.1.137:8080"

#endif



// 接口
//登录
// 获取验证码
static NSString * const api_sendSms = @"/shop/sms/sendSms";
// 注册
static NSString * const api_register = @"/shop/account/add.do";
//登录
static NSString * const api_login = @"/xm/loginApp";
//退出登录
static NSString * const api_logOut = @"/shop/logOut.do";
//修改登录密码
static NSString * const api_updatePsd = @"/shop/account/updatePsd.do";
//修改支付密码
static NSString * const api_updatePayPsd = @"/shop/account/updatePayPsd.do";
//忘记密码，发送短信接口
static NSString * const api_forgetPws1 = @"/shop/account/forgetPws1.do";
//忘记密码，修改密码接口
static NSString * const api_forgetPws2 = @"/shop/account/forgetPws2.do";
//个人中心
static NSString * const api_accountInfo = @"/shop/account/accountInfo.do";
//头像上传接口
static NSString * const api_addHeadImg = @"/shop/account/addHeadImg.do";
//用户分享注册二维码
static NSString * const api_shareQrCode = @"/shop/account/shareQrCode.do";
//我的成员
static NSString * const api_myTeam = @"/shop/account/myTeam.do";
//我的钱包
static NSString * const api_myWallet = @"/shop/account/myWallet.do";
//资金明细
static NSString * const api_myBalanceRcord = @"/shop/account/myBalanceRcord.do";
//仓单明细
static NSString * const api_myPlacesRecord = @"/shop/account/myPlacesRecord.do";
//积分明细
static NSString * const api_myIntegralRecord = @"/shop/account/myIntegralRecord.do";

//考核
//考核列表
static NSString * const api_examinationList = @"/xm/examine/userExaminationList";//试卷列表
static NSString * const api_testWeb = @"/tourist/training";//测试封面H5地址
static NSString * const api_getExamination = @"/xm/examine/getExamination";//试卷详情
static NSString * const api_submitTest = @"/xm/examine/examinationRecode";//提交测试

//随手拍
static NSString * const api_lawTypeList = @"/xm/law/list";//违法类型列表
static NSString * const api_addLaw = @"/tocs-member-app/letu/gps/addLaw";//提交违法记录
static NSString * const api_myLawList = @"/xm/breakTheLaw/convenientlyPhotoApp";//我的随手拍

static NSString * const api_userInfo = @"/xm/userInfo";//骑手信息
static NSString * const api_lawList = @"/xm/breakTheLaw/lawListApp";//违法记录查询

#endif
