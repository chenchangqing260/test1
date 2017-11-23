//
//  FeedBackViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/5/12.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "FeedBackViewController.h"
#import "BRPlaceholderTextView.h"

@interface FeedBackViewController ()

@property (weak, nonatomic) IBOutlet BRPlaceholderTextView *uiTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *uiScrollWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *uiScrollHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge_scroll;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingEdge_scroll;
@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"意见反馈";
    
    self.leadingEdge_scroll.constant = self.trailingEdge_scroll.constant = self.leftEdge;
    
    self.uiScrollWidth.constant = self.showWidth;
    self.uiScrollHeight.constant = kSCREEN_HEIGHT - kNAV_HEIGHT;
    
    self.uiTextView.placeholder=@"您的宝贵意见是我们珍贵的财富";
    [self.uiTextView addMaxTextLengthWithMaxLength:100 andEvent:^(BRPlaceholderTextView *text) {
        [self.view endEditing:YES];
    }];
    
    [self.uiTextView setPlaceholderColor:[UIColor colorWithHex:0xD0D0D0]];
}


- (IBAction)clickSubmitData:(id)sender {
    [self.view endEditing:YES];
    if ([self checkInput]) {
        [SVProgressHUDUtil showWithStatus:@"正在提交..."];
        [[WebAccessManager sharedInstance]feedBackWithMemberID:[[MemberManager sharedInstance]memberId] content:_uiTextView.text completion:^(WebResponse *response, NSError *error) {
            //[SVProgressHUDUtil dismiss];
            if (response.success) {
                // 返回成功
                [SVProgressHUDUtil showSuccessWithStatus:@"提交成功，感谢您的反馈"];
                
                dispatch_main_after(1.5,^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }else{
                // 请求返回失败
                [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
            }
        }];
    }
}

-(BOOL)checkInput{
    if ([_uiTextView.text isEmptyOrWhitespace]) {
        [CRToastUtil showAttentionMessageWithText:@"请输入反馈内容!"];
        return NO;
    }
    return YES;
}

#pragma mark - TextView Delegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]){
        // 判断输入的字是否是回车，即按下return
        [self.view endEditing:YES];
        
        return NO;
    }else{
        if (range.location>=500)
        {
            return  NO;
        }
        else
        {
            return YES;
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
@end
