//
//  BindCellPhoneViewController.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/11/1.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "BindCellPhoneViewController.h"
#import "DeformationButton.h"
#import "IndexViewController.h"
#import "ActivityNewViewController.h"

@interface BindCellPhoneViewController ()

@property (weak, nonatomic) IBOutlet UIView *uiBtnView;

@property (nonatomic, strong)DeformationButton *updateBtn;
@property (weak, nonatomic) IBOutlet UITextField *uiTelephoneTF;
@property (weak, nonatomic) IBOutlet UITextField *uiCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *uiPasswordTF;
@property (weak, nonatomic) IBOutlet UIButton *uiCodeBtn;
@property (weak, nonatomic) IBOutlet UILabel *uiCodeLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conBtnViewLeftSpace;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge_view;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingEdge_view;

@property (strong,nonatomic) NSTimer *timer;

@end

@implementation BindCellPhoneViewController
{
    int validateFlag;
}
@synthesize timer;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = LStr(@"BindCellPhone");
    [self initResetBtn];
    
    [self setupView];
    
    self.leadingEdge_view.constant = self.trailingEdge_view.constant = self.leftEdge;
}

#pragma mark - 重写父类方法属性
// 若需要隐藏NavBar，则重写此方法，返回NO即可
- (BOOL)showNavBar{
    return YES;
}

// 是否允许当前页面手势返回
- (BOOL)PopGestureEnabled{
    return NO;
}

#pragma mark - 初始化界面和数据
-(void)setupView{
    
    UIButton *leftNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNavBtn.frame = CGRectMake(0, 0, 35, 25);
    [leftNavBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [leftNavBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [leftNavBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftNavBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //    UIButton *leftNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    leftNavBtn.frame = CGRectMake(0, 0, 35, 25);
    //    [leftNavBtn setImage:[UIImage imageNamed:@"focus"] forState:UIControlStateNormal];
    //    [leftNavBtn setImage:[UIImage imageNamed:@"focus"] forState:UIControlStateHighlighted];
    //    [leftNavBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    //    [leftNavBtn addTarget:self action:@selector(leftNavBtn) forControlEvents:UIControlEventTouchUpInside];
    //
    //    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftNavBtn];
    //    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    //    UIButton *leftNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    leftNavBtn.frame = CGRectMake(0, 0, 60, 25);
    //    [leftNavBtn setTitle:@"关注" forState:UIControlStateNormal];
    //    [leftNavBtn.titleLabel setFont:FONT_14];
    //    [leftNavBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    //    [leftNavBtn addTarget:self action:@selector(leftNavBtn) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftNavBtn];
    //    self.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark - 初始化方法
// 初始化按钮
- (void)initResetBtn{
    // 1、登录
    self.updateBtn = [[DeformationButton alloc]initWithFrame:CGRectMake(0, 0, self.showWidth - self.conBtnViewLeftSpace.constant * 2, 40) withColor:[UIColor colorWithHex:0x33CFDA]];
    [self.uiBtnView addSubview:self.updateBtn];
    
    [self.updateBtn.forDisplayButton setTitle:@"绑定手机号" forState:UIControlStateNormal];
    [self.updateBtn.forDisplayButton.titleLabel setFont:FONT_16];
    [self.updateBtn.forDisplayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.updateBtn.forDisplayButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
    [self.updateBtn addTarget:self action:@selector(didResetPwdAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 自定义方法
// 重置密码事件
- (void)didResetPwdAction{
    
    self.updateBtn.isLoading = NO;
    [self.view endEditing:YES];
    if ([self checkUpdatePasswordInput]) {
        self.updateBtn.isLoading = YES;
        // 1、提交注册信息
        [[WebAccessManager sharedInstance]forgetPasswordWithTelephone:_uiTelephoneTF.text pwd:_uiPasswordTF.text code:_uiCodeTF.text completion:^(WebResponse *response, NSError *error) {
            dispatch_main_after(1.5, ^{
                self.updateBtn.isLoading = NO;
                if (response.success) {
                    
                    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
                    
                    [settings setObject:@"2" forKey:kUserDefaultKeyIsShowBindCellPhone];
                    
                    // 返回主页
                    [SVProgressHUDUtil showSuccessWithStatus:@"重置密码成功" completion:^{
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                }else{
                    // 请求返回失败
                    [CRToastUtil showAttentionMessageWithText:[error.userInfo objectForKey:@"errorMessage"]];
                }
            });
        }];
    }else{
        self.updateBtn.isLoading = NO;
    }
    [SVProgressHUDUtil showSuccessWithStatus:@"绑定手机成功" completion:^{
        NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
        [settings setObject:@"2" forKey:kUserDefaultKeyIsShowBindCellPhone];
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.delegate clickBindCellPhoneBtn];
//         [self.navigationController popViewControllerAnimated:YES];
//        [self.navigationController pushViewController:[ActivityNewViewController new] animated:YES];
    }];
    
}

// 检查登录输入
-(BOOL)checkUpdatePasswordInput{
    if ([_uiTelephoneTF.text isEmptyOrWhitespace]) {
        [CRToastUtil showAttentionMessageWithText:@"请输入手机号!"];
        return NO;
    }
    if ([_uiCodeTF.text isEmptyOrWhitespace]) {
        [CRToastUtil showAttentionMessageWithText:@"请输入验证码!"];
        return NO;
    }
    if ([_uiPasswordTF.text isEmptyOrWhitespace]) {
        [CRToastUtil showAttentionMessageWithText:@"请输入新密码!"];
        return NO;
    }
    return YES;
}

// 倒计时
-(void)setTitle{
    validateFlag --;
    NSString *title = [NSString stringWithFormat:@"剩余%d秒",validateFlag];
    if (validateFlag == 0) {
        //停止定时器
        [timer invalidate];
        
        [_uiCodeLab setText:@"重新获取"];
        //按钮可用
        _uiCodeBtn.enabled = YES;
    }else{
        [_uiCodeLab setText:title];
        _uiCodeBtn.enabled = NO;
    }
}

#pragma mark - 点击事件
- (IBAction)clickGetVerifyCodeBtn:(id)sender {
    [self.view endEditing:YES];
    // 验证是否输入手机号
    if ([_uiTelephoneTF.text isEmptyOrWhitespace]) {
        [CRToastUtil showAttentionMessageWithText:@"请输入手机号!"];
        return;
    }
    
    [[WebAccessManager sharedInstance]getVerifyCodeNewWithTelephone:_uiTelephoneTF.text type:@"1" completion:^(WebResponse *response, NSError *error) {
        //        if (!error) {
        //            [CRToastUtil showPublicMessageWithText:@"验证码已发送到你的手机"];
        //            validateFlag = 60; // 重置倒计时
        //            _uiCodeBtn.enabled = NO;
        //            NSTimeInterval timeInterval = 1.0;
        //            timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(setTitle) userInfo:nil repeats:YES];
        //        }else{
        //            NSString* errorMsg = [error.userInfo objectForKey:@"getVerificationCode"];
        //            [CRToastUtil showAttentionMessageWithText:errorMsg];
        //        }
        
        if (response.success) {
            [CRToastUtil showPublicMessageWithText:@"验证码已发送到你的手机"];
            validateFlag = 60; // 重置倒计时
            _uiCodeBtn.enabled = NO;
            NSTimeInterval timeInterval = 1.0;
            timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(setTitle) userInfo:nil repeats:YES];
        }else{
            [CRToastUtil showAttentionMessageWithText:response.errorMsg];
        }
    }];
}

#pragma mark - TextField Delegate
// 点击return按钮隐藏键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

#pragma mark - 辅助方法
static void dispatch_main_after(NSTimeInterval delay, void (^block)(void))
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}
@end