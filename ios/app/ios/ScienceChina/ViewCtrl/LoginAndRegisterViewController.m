//
//  LoginAndRegisterViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/5/10.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "LoginAndRegisterViewController.h"
#import "DeformationButton.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WXUtil.h"
#import "AppDelegate.h"
#import "JSONUtil.h"
#import "WeixinAccessTokenResponse.h"
#import "WeixinUserInfo.h"
#import "MyAlertViewController.h"

@interface LoginAndRegisterViewController ()<TencentSessionDelegate,WXApiDelegate,WeiboSDKDelegate,WBHttpRequestDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *uiLoginArrowImgView;
@property (weak, nonatomic) IBOutlet UIImageView *uiRegisterArrowImgView;
@property (weak, nonatomic) IBOutlet UIView *uiLoginBtnView;
@property (weak, nonatomic) IBOutlet UIView *uiRegisterBtnView;
@property (weak, nonatomic) IBOutlet UIScrollView *uiScrollView;
@property (weak, nonatomic) IBOutlet UITextField *uiLoginTelephoneTF;
@property (weak, nonatomic) IBOutlet UITextField *uiLoginPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *uiRegTelephoneTF;
@property (weak, nonatomic) IBOutlet UITextField *uiRegCodeTF;
@property (weak, nonatomic) IBOutlet UILabel *uiRegCodeLab;
@property (weak, nonatomic) IBOutlet UITextField *uiRegPasswordTF;
@property (weak, nonatomic) IBOutlet UIButton *uiRegCodeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *uiQQImgView;
@property (weak, nonatomic) IBOutlet UIImageView *uiWeiboImgView;
@property (weak, nonatomic) IBOutlet UIImageView *uiWeixinImgView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conScrollViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conScrollViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conLoginViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conRegisterViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conLoginViewTopSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conLoginBtnViewLeftSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conRegisterBtnViewLeftSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conThirdLoginViewLeftSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conWeiXinRightSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conQQLeftSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conWeiboLeftSpace;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge_loginView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge_registerView;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge_scroll;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingEdge_scroll;

@property (nonatomic, strong)DeformationButton *loginBtn;
@property (nonatomic, strong)DeformationButton *registerBtn;

@property (strong,nonatomic) NSTimer *timer;

@property (nonatomic,strong)TencentOAuth *tencentOAuth;
@property (nonatomic,strong)NSString* weiboUserId;

@end

@implementation LoginAndRegisterViewController
{
    int validateFlag;
}
@synthesize timer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1、初始化约束
    self.leadingEdge_loginView.constant = self.leftEdge;
    self.leadingEdge_registerView.constant = self.leadingEdge_loginView.constant + self.leftEdge;
    self.conScrollViewWidth.constant = kSCREEN_WIDTH * 2;
    self.conScrollViewHeight.constant = kSCREEN_HEIGHT - kSCREEN_WIDTH * 170 / 375;
    self.conLoginViewWidth.constant = self.conRegisterViewWidth.constant = self.showWidth;
    if (kSCREEN_WIDTH < kWIDTH_375) {
        self.conLoginViewTopSpace.constant = 25;
    }else{
        self.conLoginViewTopSpace.constant = 50;
    }
    
    // 2、登录注册按钮
    [self initLoginAndRegisterBtn];
    
    // 3、界面元素初始化
    self.uiRegisterArrowImgView.hidden = YES;
    self.uiLoginArrowImgView.hidden = NO;
    
    // 4、设置代理
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.wxDelegate = self;
    appDelegate.weiboDelegate = self;
    
    // 5、根据是否按照APP判断是否显示
    if (kSCREEN_WIDTH < kWIDTH_375) {
        self.conThirdLoginViewLeftSpace.constant = 15;
    }else{
        self.conThirdLoginViewLeftSpace.constant = 30;
    }
    
    CGFloat thirdLoginViewHeight = kSCREEN_WIDTH - self.conThirdLoginViewLeftSpace.constant * 2;
    if([WXApi isWXAppInstalled] && ![QQApiInterface isQQInstalled])
    {
        // 安装了微信未安装QQ
        self.conWeiboLeftSpace.constant = 60;
        self.conWeiXinRightSpace.constant = 60;
        self.uiQQImgView.hidden = YES;
    } else if(![WXApi isWXAppInstalled] && [QQApiInterface isQQInstalled]) {
        // 安装了QQ未安装微信
        self.conQQLeftSpace.constant = 60;
        self.conWeiboLeftSpace.constant = thirdLoginViewHeight - 60 - 60;
        self.uiWeixinImgView.hidden = YES;
    }else if(![WXApi isWXAppInstalled] && ![QQApiInterface isQQInstalled]){
        // QQ和微信都未安装
        self.uiQQImgView.hidden =  YES;
        self.uiWeixinImgView.hidden = YES;
        // 将微博居中60为微博图片宽度
        self.conWeiboLeftSpace.constant = (thirdLoginViewHeight - 60) / 2;
    }else{
        // 全部安装
        self.conWeiboLeftSpace.constant = (thirdLoginViewHeight - 60) / 2;
        self.conQQLeftSpace.constant = 30;
        self.conWeiXinRightSpace.constant = 30;
    }
    
    if (_toRegister) {
        [self clickToRegisterViewBtnAction:nil];
    }
}

#pragma mark - 重写父类方法属性
// 若需要隐藏NavBar，则重写此方法，返回NO即可
- (BOOL)showNavBar{
    return NO;
}

// 是否允许当前页面手势返回
- (BOOL)PopGestureEnabled{
    return NO;
}

#pragma mark - 点击按钮手势事件
- (IBAction)clickCloseBtn:(id)sender {
    [self.view endEditing:YES];
    if (self.loginBtn.isLoading || self.registerBtn.isLoading) {
        // 在进行登录或者注册事件，则不允许操作
        return;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if(self.isShowAlertYinDao){
        NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
        
        NSString* isShowTabbarRed = [settings objectForKey:kUserDefaultKeyIsShowTabbarRed];
        //已注册，第一次为点击科普员补充资料，弹出指引页面
        if([isShowTabbarRed isEqualToString:@"1"]){
            JTNavigationController *navigationController = [[JTNavigationController alloc] initWithRootViewController:[MyAlertViewController new]];
            navigationController.modalPresentationStyle = UIModalPresentationCustom;
            UIViewController *vc = [[UIApplication sharedApplication].delegate window].rootViewController;
            [vc presentViewController:navigationController animated:YES
                           completion:nil];
            
            [AppDelegate appdelegate].badgeview1.hidden = YES;
            
            
            [settings setObject:@"2" forKey:kUserDefaultKeyIsShowTabbarRed];
        }
    }
    
    
}

- (IBAction)clickQQBtn:(id)sender {
    [self.view endEditing:YES];
    NSArray*  permissions = [NSArray arrayWithObjects: kOPEN_PERMISSION_GET_USER_INFO, kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, nil];
    //    NSArray*  permissions =  [NSArray arrayWithObjects:@"get_user_info", nil];
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:kQQApiKey andDelegate:self];
    [_tencentOAuth authorize:permissions inSafari:YES];
}

- (IBAction)clickWeiXinBtn:(id)sender {
    [self.view endEditing:YES];
    // 构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc ] init ];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"ScienceChinaWeXinLogin" ;
    // 第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}

- (IBAction)clickWeiboBtn:(id)sender {
    [self.view endEditing:YES];
    WBAuthorizeRequest *request = [ WBAuthorizeRequest request];
    request.redirectURI = kWeiBoRedirectURL;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:345],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

- (IBAction)clickShowLoginViewGes:(id)sender {
    [self.view endEditing:YES];
    if (self.loginBtn.isLoading || self.registerBtn.isLoading) {
        // 在进行登录或者注册事件，则不允许操作
        return;
    }
    [self.uiScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    self.uiLoginArrowImgView.hidden = NO;
    self.uiRegisterArrowImgView.hidden = YES;
}

- (IBAction)clickShowRegisterViewGes:(id)sender {
    [self.view endEditing:YES];
    if (self.loginBtn.isLoading || self.registerBtn.isLoading) {
        // 在进行登录或者注册事件，则不允许操作
        return;
    }
    [self.uiScrollView setContentOffset:CGPointMake(kSCREEN_WIDTH, 0) animated:YES];
    self.uiLoginArrowImgView.hidden = YES;
    self.uiRegisterArrowImgView.hidden = NO;
}

- (IBAction)clickForgetPassword:(id)sender {
    [self.view endEditing:YES];
    [FlowUtil startToForgetPasswordVCNav:self.navigationController completion:nil];
}

// 获取验证码
- (IBAction)clickGetVerfiyCodeAction:(id)sender {
    [self.view endEditing:YES];
    // 验证是否输入手机号
    if ([_uiRegTelephoneTF.text isEmptyOrWhitespace]) {
        [CRToastUtil showAttentionMessageWithText:@"请输入手机号!"];
        return;
    }
    
    [[WebAccessManager sharedInstance]getVerifyCodeNewWithTelephone:_uiRegTelephoneTF.text type:@"0" completion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            [CRToastUtil showPublicMessageWithText:@"验证码已发送到你的手机"];
            validateFlag = 60; // 重置倒计时
            _uiRegCodeBtn.enabled = NO;
            NSTimeInterval timeInterval = 1.0;
            timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(setTitle) userInfo:nil repeats:YES];
        }else{
            //            NSString* errorMsg = [error.userInfo objectForKey:@"errorMessage"];
            [CRToastUtil showAttentionMessageWithText:response.errorMsg];
            //            if ([errorMsg isEqualToString:@"WRONG_MOBILE"]) {
            //                [CRToastUtil showAttentionMessageWithText:@"手机号输入错误!"];
            //            }else{
            //                [CRToastUtil showAttentionMessageWithText:@"获取验证码失败!"];
            //            }
        }
    }];
}

- (IBAction)clickToLoginViewBtnAction:(id)sender {
    [self.view endEditing:YES];
    if (self.loginBtn.isLoading || self.registerBtn.isLoading) {
        // 在进行登录或者注册事件，则不允许操作
        return;
    }
    [self.uiScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    self.uiLoginArrowImgView.hidden = NO;
    self.uiRegisterArrowImgView.hidden = YES;
}

- (IBAction)clickToRegisterViewBtnAction:(id)sender {
    [self.view endEditing:YES];
    if (self.loginBtn.isLoading || self.registerBtn.isLoading) {
        // 在进行登录或者注册事件，则不允许操作
        return;
    }
    [self.uiScrollView setContentOffset:CGPointMake(kSCREEN_WIDTH, 0) animated:YES];
    self.uiLoginArrowImgView.hidden = YES;
    self.uiRegisterArrowImgView.hidden = NO;
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.uiScrollView.contentOffset.x == 0) {
        // 登录
        self.uiLoginArrowImgView.hidden = NO;
        self.uiRegisterArrowImgView.hidden = YES;
    }else{
        // 注册
        self.uiLoginArrowImgView.hidden = YES;
        self.uiRegisterArrowImgView.hidden = NO;
    }
}

#pragma mark - 自定义方法和事件
// 倒计时
-(void)setTitle{
    validateFlag --;
    NSString *title = [NSString stringWithFormat:@"剩余%d秒",validateFlag];
    if (validateFlag == 0) {
        //停止定时器
        [timer invalidate];
        
        [_uiRegCodeLab setText:@"重新获取"];
        //按钮可用
        _uiRegCodeBtn.enabled = YES;
    }else{
        [_uiRegCodeLab setText:title];
        _uiRegCodeBtn.enabled = NO;
    }
}

- (void)initLoginAndRegisterBtn{
    // 1、登录
    self.loginBtn = [[DeformationButton alloc]initWithFrame:CGRectMake(0, 0, self.showWidth - self.conLoginBtnViewLeftSpace.constant * 2, 40) withColor:[UIColor colorWithHex:0x33CFDA]];
    [self.uiLoginBtnView addSubview:self.loginBtn];
    
    [self.loginBtn.forDisplayButton setTitle:@"登  录" forState:UIControlStateNormal];
    [self.loginBtn.forDisplayButton.titleLabel setFont:FONT_16];
    [self.loginBtn.forDisplayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn.forDisplayButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
    [self.loginBtn addTarget:self action:@selector(didLoginAction) forControlEvents:UIControlEventTouchUpInside];
    
    // 2、注册
    self.registerBtn = [[DeformationButton alloc]initWithFrame:CGRectMake(0, 0, self.showWidth - self.conRegisterBtnViewLeftSpace.constant * 2, 40) withColor:[UIColor colorWithHex:0x33CFDA]];
    [self.uiRegisterBtnView addSubview:self.registerBtn];
    
    [self.registerBtn.forDisplayButton setTitle:@"注   册" forState:UIControlStateNormal];
    [self.registerBtn.forDisplayButton.titleLabel setFont:FONT_16];
    [self.registerBtn.forDisplayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registerBtn.forDisplayButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
    
    [self.registerBtn addTarget:self action:@selector(didRegisterAction) forControlEvents:UIControlEventTouchUpInside];
}

// 登录事件
- (void)didLoginAction{
    self.loginBtn.isLoading = NO;
    [self.view endEditing:YES];
    if ([self checkLoginInput]) {
        // 1、ScrollView不允许滑动
        self.uiScrollView.scrollEnabled = NO;
        self.loginBtn.isLoading = YES;
        
        [[WebAccessManager sharedInstance]loginWithTelephone:_uiLoginTelephoneTF.text password:_uiLoginPasswordTF.text completion:^(WebResponse *response, NSError *error) {
            dispatch_main_after(1.5, ^{
                self.loginBtn.isLoading = NO;
                self.uiScrollView.scrollEnabled = YES;
                
                if (response.success) {
                    [MemberManager sharedInstance].score = response.data.score;
                    Member *member = response.data.member;
                    member.channel = @"4";
                    member.autocode = nil;
                    member.member_password = _uiLoginPasswordTF.text;
                    [[NSUserDefaults standardUserDefaults]setObject:response.data.member.member_id forKey:@"memid"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_SAVEDATAAFTERLOGIN object:nil userInfo:@{@"member":member}];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshMyStation" object:nil];
                    // 刷新首页定制分类
                    [self reloadCollectCategory];
                    
                    // 返回主页
                    [self clickCloseBtn:nil];
                    
                    //登录成功，数据统计
                    [self onaddUser];
                    
                    //判断是不是科普员
                }else{
                    // 请求返回失败
                    [CRToastUtil showAttentionMessageWithText:[error.userInfo objectForKey:@"errorMessage"]];
                }
                
            });
        }];
    }else{
        self.loginBtn.isLoading = NO;
    }
}

- (void)checkIsKePu{
    [[WebAccessManager sharedInstance]analyseMemberIsSceBycompletion:^(WebResponse *response, NSError *error) {
        if (response.success)
        {
            if ([response.data.is_sciencer isEqualToString:@"1"]) {
                [MemberManager sharedInstance].getMember.isKepu =@"0";
            }else{
                [MemberManager sharedInstance].getMember.isKepu =@"1";
            }
        }
    }];
}

// 检查登录输入
-(BOOL)checkLoginInput{
    if ([_uiLoginTelephoneTF.text isEmptyOrWhitespace]) {
        [CRToastUtil showAttentionMessageWithText:@"请输入手机号!"];
        return NO;
    }
    if ([_uiLoginPasswordTF.text isEmptyOrWhitespace]) {
        [CRToastUtil showAttentionMessageWithText:@"请输入登录密码!"];
        return NO;
    }
    return YES;
}

// 注册事件
- (void)didRegisterAction{
    //    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    //    [settings setObject:@"1" forKey:kUserDefaultKeyIsShowTabbarRed];
    //
    //    [AppDelegate appdelegate].badgeview1.hidden = NO;
    
    
    self.registerBtn.isLoading = NO;
    [self.view endEditing:YES];
    if ([self checkRegisterInput]) {
        // 1、ScrollView不允许滑动
        self.uiScrollView.scrollEnabled = NO;
        self.registerBtn.isLoading = YES;
        
        
        // 2、提交注册信息
        [[WebAccessManager sharedInstance]registerWithTelephone:_uiRegTelephoneTF.text password:_uiRegPasswordTF.text code:_uiRegCodeTF.text completion:^(WebResponse *response, NSError *error) {
            dispatch_main_after(1.5, ^{
                self.registerBtn.isLoading = NO;
                self.uiScrollView.scrollEnabled = YES;
                
                if (response.success) {
                    [MemberManager sharedInstance].score = response.data.score;
                    Member *member = response.data.member;
                    member.channel = @"4";
                    member.autocode = nil;
                    
                    [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_SAVEDATAAFTERLOGIN object:nil userInfo:@{@"member":member}];
                    
                    // 返回主页
                    [self clickCloseBtn:nil];
                    
                    //注册成功，开启科普补充页面引导提示
                    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
                    [settings setObject:@"1" forKey:kUserDefaultKeyIsShowTabbarRed];
                    
                    [AppDelegate appdelegate].badgeview1.hidden = NO;
                    
                    //登录成功，数据统计
                    [self onaddUser];
                    
                }else{
                    // 请求返回失败
                    [CRToastUtil showAttentionMessageWithText:[error.userInfo objectForKey:@"errorMessage"]];
                }
                
            });
        }];
    }else{
        self.registerBtn.isLoading = NO;
    }
}

// 检查登录输入
-(BOOL)checkRegisterInput{
    if ([_uiRegTelephoneTF.text isEmptyOrWhitespace]) {
        [CRToastUtil showAttentionMessageWithText:@"请输入手机号!"];
        return NO;
    }
    if ([_uiRegCodeTF.text isEmptyOrWhitespace]) {
        [CRToastUtil showAttentionMessageWithText:@"请输入验证码!"];
        return NO;
    }
    if ([_uiRegPasswordTF.text isEmptyOrWhitespace]) {
        [CRToastUtil showAttentionMessageWithText:@"请输入登录密码!"];
        return NO;
    }
    return YES;
}

// 刷新首页数据
-(void)reloadCollectCategory{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaultKeyCollectCategory];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaultKeyCollectCategoryForUser([MemberManager sharedInstance].memberId)];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshCollectionData" object:nil];
}

#pragma mark - TextField Delegate
// 点击return按钮隐藏键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.uiScrollView.scrollEnabled = NO;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.uiScrollView.scrollEnabled = YES;
}
#pragma mark - QQ 登录回调
// 登录成功后的回调
- (void)tencentDidLogin{
    [SVProgressHUDUtil showWithStatus:@"正在登录..."];
    // 获取用户信息
    [_tencentOAuth getUserInfo];
}

- (void)getUserInfoResponse:(APIResponse*) response {
    NSString *memberName = nil;
    NSString * imageURL = nil;
    if (URLREQUEST_SUCCEED == response.retCode
        && kOpenSDKErrorSuccess == response.detailRetCode) {
        memberName = [response.jsonResponse objectForKey:@"nickname"];
        imageURL = [response.jsonResponse objectForKey:@"figureurl_qq_2"];
    }
    
    
    [self getThirdPartLoginInfoWithChannel:@"0" authcode:_tencentOAuth.openId memberName:memberName imageURL:imageURL];
    
}

// 登录失败后的回调
- (void)tencentDidNotLogin:(BOOL)cancelled{
    [CRToastUtil showAttentionMessageWithText:@"QQ登录失败"];
}

// 登录时网络有问题的回调
- (void)tencentDidNotNetWork{
    [CRToastUtil showAttentionMessageWithText:@"网络异常，请检查您的网络"];
}

#pragma mark - 微博 登录回调
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    
    [settings setObject:@"1" forKey:kUserDefaultKeyIsShowBindCellPhone];
    // 微博回调成功
    if (response.statusCode == WeiboSDKResponseStatusCodeSuccess && [response isKindOfClass:[WBAuthorizeResponse class]]) {
        [SVProgressHUDUtil showWithStatus:@"正在登录..."];
        WBAuthorizeResponse *authorizeResponse = (WBAuthorizeResponse *)response;
        
        // 微博获取用户信息
        NSMutableDictionary* params = [NSMutableDictionary new];
        [params setValue:authorizeResponse.accessToken forKey:@"access_token"];
        [params setValue:authorizeResponse.userID forKey:@"uid"];
        [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/users/show.json" httpMethod:@"GET" params:params delegate:self withTag:@"getUserInfo"];
    }
    else if (response.statusCode == WeiboSDKResponseStatusCodeUserCancel && [response isKindOfClass:[WBAuthorizeResponse class]]) {
        [CRToastUtil showAttentionMessageWithText:@"取消微博登录"];
    }
    else{
        [CRToastUtil showAttentionMessageWithText:@"微博登录失败"];
    }
}

- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    [SVProgressHUDUtil dismiss];
    NSError *error;
    NSData  *data = [result dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    //    if (json == nil)
    //    {
    //        [CRToastUtil showAttentionMessageWithText:@"登录失败，无法获取微博用户信息！"];
    //        return;
    //    }
    
    NSString *userID     = [json objectForKey:@"idstr"];
    NSString *screenname = [json objectForKey:@"screen_name"];
    NSString *picture    = [json objectForKey:@"profile_image_url"];
    //    if (userID) {
    [SVProgressHUDUtil showWithStatus:@"正在登录..."];
    
    [self getThirdPartLoginInfoWithChannel:@"2" authcode:userID memberName:screenname imageURL:picture];
    
}

#pragma mark - 微信 登录回调
-(void) onResp:(BaseResp*)resp{
    [self handleWeixinLoginResponse:(SendAuthResp *)resp];
}

- (void)handleWeixinLoginResponse:(SendAuthResp *)authResp{
    if (authResp.errCode == 0) {
        // 用户授权成功
        NSString *accessCodeUrl = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",kWXApiKey,kWXSecret,authResp.code];
        NSData *accessTokenData = [WXUtil httpSend:accessCodeUrl method:@"Get" data:nil];
        if (accessTokenData) {
            WeixinAccessTokenResponse *accessTokenResponse = [JSONUtil objectFromData:accessTokenData class:[WeixinAccessTokenResponse class]];
            if (!accessTokenResponse.errcode) {
                [SVProgressHUDUtil showWithStatus:@"正在登录..."];
                // 获取用户信息
                NSString *accessUserInfoUrl = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@&lang=zh_CN",accessTokenResponse.access_token, accessTokenResponse.openid];
                NSData *accessUserData = [WXUtil httpSend:accessUserInfoUrl method:@"Get" data:nil];
                WeixinUserInfo *accessUserResponse = [JSONUtil objectFromData:accessUserData class:[WeixinUserInfo class]];
                
                [self getThirdPartLoginInfoWithChannel:@"1" authcode:accessTokenResponse.openid memberName:accessUserResponse.nickname imageURL:accessUserResponse.headimgurl];
                
            } else {
                [CRToastUtil showAttentionMessageWithText:@"微信登录失败"];
            }
        } else {
            [CRToastUtil showAttentionMessageWithText:@"微信登录失败"];
        }
    }
}

#pragma mark - 辅助方法
static void dispatch_main_after(NSTimeInterval delay, void (^block)(void))
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}

#pragma mark
-(void)onaddUser{
    Member *member = [[MemberManager sharedInstance] getMember];
    //登录成功
    [BDIDataStatistics onAddUserWithUserId:member.member_id];
}
-(void)getThirdPartLoginInfoWithChannel:(NSString *)channel  authcode:(NSString *)authcode memberName:(NSString *)memberName imageURL:(NSString *)imageURL{
    
    // 辅助字段 0-QQ、1-微信、2-微博 、3-facebook、4-账号密码登录
    [[WebAccessManager sharedInstance]loginWithThirdPartyWithChannel:channel authcode:authcode memberName:memberName imageURL:imageURL completion:^(WebResponse *response, NSError *error) {
        [SVProgressHUDUtil dismiss];
        if (response.success) {
            
            //第三方登陆后，设置提示绑定手机号
            NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
            
            [settings setObject:@"1" forKey:kUserDefaultKeyIsShowBindCellPhone];
            
            // 登录成功
            [MemberManager sharedInstance].score = nil;
            Member *member = response.data.member;
            member.channel = channel;
            member.autocode = authcode;
            
            [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_SAVEDATAAFTERLOGIN object:nil userInfo:@{@"member":member}];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshMyStation" object:nil];
            // 刷新首页定制分类
            [self reloadCollectCategory];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
            //登录成功，数据统计
            [self onaddUser];
            
        }else{
            // 请求返回失败
            [CRToastUtil showAttentionMessageWithText:[error.userInfo objectForKey:@"errorMessage"]];
        }
    }];
}

@end
