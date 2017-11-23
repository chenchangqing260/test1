//
//  ChangePasswordViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/5/10.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge_old;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingEdge_old;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge_new;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingEdge_new;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge_again;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingEdge_again;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge_btn;




@property (weak, nonatomic) IBOutlet UITextField *uiOrgPwdTF;
@property (weak, nonatomic) IBOutlet UITextField *uiNewPwdTF;
@property (weak, nonatomic) IBOutlet UITextField *uiConfirmPwdTF;
@property (weak, nonatomic) IBOutlet UIButton *uiChangeBtn;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = LStr(@"ChangePassword");
    self.uiChangeBtn.layer.cornerRadius = 3;
    
    self.leadingEdge_old.constant = self.trailingEdge_old.constant = self.leftEdge;
    self.leadingEdge_new.constant = self.trailingEdge_new.constant = self.leftEdge;
    self.leadingEdge_again.constant = self.trailingEdge_again.constant = self.leftEdge;
    self.leadingEdge_btn.constant = self.leftEdge+40;
}

#pragma mark - 按钮事件
- (IBAction)clickChangePwdBtn:(id)sender {
    [self.view endEditing:YES];
    if ([self checkInput]) {
        [SVProgressHUDUtil showWithStatus:@"正在修改..."];
        [[WebAccessManager sharedInstance]changePasswordWithMemberID:[[MemberManager sharedInstance]memberId] oldPwd:_uiOrgPwdTF.text newPaw:_uiNewPwdTF.text completion:^(WebResponse *response, NSError *error) {
            [SVProgressHUDUtil dismiss];
            if (response.success) {
                // 返回成功
                [SVProgressHUDUtil showSuccessWithStatus:@"修改成功" completion:^{
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }else{
                // 请求返回失败
                [CRToastUtil showAttentionMessageWithText:[error.userInfo objectForKey:@"errorMessage"]];
            }
        }];
    }

}

// 检查登录输入
-(BOOL)checkInput{
    if ([_uiOrgPwdTF.text isEmptyOrWhitespace]) {
        [CRToastUtil showAttentionMessageWithText:@"请输入当前密码!"];
        return NO;
    }
    if ([_uiNewPwdTF.text isEmptyOrWhitespace]) {
        [CRToastUtil showAttentionMessageWithText:@"请输入新密码!"];
        return NO;
    }
    if ([_uiConfirmPwdTF.text isEmptyOrWhitespace]) {
        [CRToastUtil showAttentionMessageWithText:@"请输入再次输入新密码!"];
        return NO;
    }
    if (![_uiConfirmPwdTF.text isEqualToString:_uiNewPwdTF.text]) {
        [CRToastUtil showAttentionMessageWithText:@"输入新密码必须一致!"];
        return NO;
    }
    return YES;
}

#pragma mark - TextField Delegate
// 点击return按钮隐藏键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
@end
