//
//  MemberInfoViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/5/12.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#define MAX_STARWORDS_LENGTH 10.0f

#import "MemberInfoViewController.h"
#import "Member.h"
#import "FSMediaPicker.h"
#import "Member.h"
#import "QNCustomUploadManager.h"
#import "QNKeyHelper.h"

@interface MemberInfoViewController ()<FSMediaPickerDelegate>
{
    BOOL _gotoLeft;//是否是从左侧视图进入的此界面
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge_header;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingEdge_header;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge_nick;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingEdge_nick;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingEdge_phone;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingEdge_phone;

@property (weak, nonatomic) IBOutlet UIImageView *uiHeadImgView;
@property (weak, nonatomic) IBOutlet UITextField *uiNickNameTF;
@property (weak, nonatomic) IBOutlet UILabel *uiTelephoneLab;

@property (nonatomic, strong)Member* member;

@end

@implementation MemberInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人信息";
    
    self.leadingEdge_header.constant = self.trailingEdge_header.constant = self.leftEdge;
    self.leadingEdge_nick.constant = self.trailingEdge_nick.constant = self.leftEdge;
    self.leadingEdge_phone.constant = self.trailingEdge_phone.constant = self.leftEdge;
    
    
    self.member = [[MemberManager sharedInstance]getMember];
    // 1、初始化数据
    [self.uiHeadImgView sd_setImageWithURL:[NSURL URLWithString:self.member.img_url] placeholderImage:nil];
    [self.uiNickNameTF setText:self.member.member_name];
    [self.uiTelephoneLab setText:self.member.member_account];
    
    
    // 2、控制字数输入限制的方法
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.uiNickNameTF];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (_gotoLeft) {
        self.navigationItem.leftBarButtonItem = nil;
        UIButton *leftNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftNavBtn.frame = CGRectMake(0, 0, 35, 25);
        [leftNavBtn setImage:[UIImage imageNamed:@"showLeftViewicon"] forState:UIControlStateNormal];
        [leftNavBtn setImage:[UIImage imageNamed:@"showLeftViewicon"] forState:UIControlStateHighlighted];
        [leftNavBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
        [leftNavBtn addTarget:self action:@selector(leftNavBtn) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftNavBtn];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
}
// 左侧返回点击事件
-(void)leftNavBtnAction{
    [self.view endEditing:YES];
    if (![self.member.member_name isEqualToString:_uiNickNameTF.text]) {
        MMPopupItemHandler block = ^(NSInteger index){
            if (index == 0) {
                [self didSaveNickName];
            }
            
            if (index == 1) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            
            if (index == 2) {
                
            }
        };
        // 提示
        NSArray *items =
        @[ MMItemMake(@"保存", MMItemTypeHighlight, block),
           MMItemMake(@"退出", MMItemTypeNormal, block),
          MMItemMake(@"取消", MMItemTypeNormal, block)
          ];
        [[[MMAlertView alloc] initWithTitle:@"确认"
                                     detail:@"您修改了昵称，要保存吗?"
                                      items:items]
         showWithBlock:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

// 点左侧视图的头像进入的个人信息页-左侧导航点击事件
-(void)leftNavBtn{
    [self.view endEditing:YES];
    if (![self.member.member_name isEqualToString:_uiNickNameTF.text]) {
        MMPopupItemHandler block = ^(NSInteger index){
            if (index == 0) {
                [self didSaveNickName];
            }
            
            if (index == 1) {
                // 改版
//                DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
//                [menuController showLeftController:YES];
            }
            
            if (index == 2) {
                
            }
        };
        // 提示
        NSArray *items =
        @[ MMItemMake(@"保存", MMItemTypeHighlight, block),
           MMItemMake(@"退出", MMItemTypeNormal, block),
           MMItemMake(@"取消", MMItemTypeNormal, block)
           ];
        [[[MMAlertView alloc] initWithTitle:@"确认"
                                     detail:@"您修改了昵称，要保存吗?"
                                      items:items]
         showWithBlock:nil];
    }else{
        // 改版
//        DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
//        [menuController showLeftController:YES];
    }
}
// 点左侧视图的头像进入的个人信息页-左侧导航按钮
-(void)reSetLeftButton{
    _gotoLeft = YES;
}

#pragma mark - 按钮事件
- (IBAction)clickSelectHeaderImg:(id)sender {
    FSMediaPicker *picker = [[FSMediaPicker alloc] init];
    picker.delegate = self;
    if (isIpad) {
        [picker showFromView:self.uiHeadImgView];
    } else {
        [picker showFromView:self.view];
    }
}

- (IBAction)clickUpdateNickName:(id)sender {
}

// 保存昵称
- (void)didSaveNickName{
    if (![_uiNickNameTF.text isEqualToString:self.member.member_name]) {
        [SVProgressHUDUtil show];
        [[WebAccessManager sharedInstance]changeInformationWithMemberID:self.member.member_id memberName:_uiNickNameTF.text completion:^(WebResponse *response, NSError *error) {
            if (response.success) {
                [SVProgressHUDUtil showSuccessWithStatus:@"修改昵称成功!"];
                self.member.member_name = _uiNickNameTF.text;
                [[MemberManager sharedInstance] getMember].member_name = _uiNickNameTF.text;
                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_UPDATE_MYVIEW_INFO object:nil];
            }else{
                // 请求返回失败
                [SVProgressHUDUtil showErrorWithStatus:[error.userInfo objectForKey:@"errorMessage"]];
            }
        }];
    }
}

#pragma mark - FSMediaPickerDelegate
- (void)mediaPicker:(FSMediaPicker *)mediaPicker didFinishWithMediaInfo:(NSDictionary *)mediaInfo
{
    // 上传七牛云
    [SVProgressHUDUtil show];
    [QNCustomUploadManager uploadImage:mediaInfo.editedImage imgKey:[QNKeyHelper getQNKey:[[MemberManager sharedInstance]memberId]  suffix:nil] maxSize:CGSizeMake(1080, 1920) success:^(NSString *imageName) {
        // 保存头像名称
        [[WebAccessManager sharedInstance]changeIconWithMemberID:[[MemberManager sharedInstance]memberId] picName:imageName completion:^(WebResponse *response, NSError *error) {
            [SVProgressHUDUtil dismiss];
            if (response.success) {
                [[MemberManager sharedInstance] getMember].img_url = response.data.img_url;
                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_UPDATE_MYVIEW_INFO object:nil];
            }
        }];
        
        _uiHeadImgView.image = mediaInfo.editedImage;
    } failure:^{
        [SVProgressHUDUtil showErrorWithStatus:@"网络不太顺畅！"];
    }];
}

#pragma mark - TextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    if (![_uiNickNameTF.text isEqualToString:self.member.member_name]) {
        [self didSaveNickName];
    }
    return YES;
}

#pragma mark - Notification Method
-(void)textFiledEditChanged:(NSNotification *)obj
{
    UITextField *textField = (UITextField *)obj.object;
    NSString *toBeString = textField.text;
    NSString *lang = [textField.textInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"])// 简体中文输入
    {
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > MAX_STARWORDS_LENGTH)
            {
                textField.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
            }
        }
        
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else
    {
        if (toBeString.length > MAX_STARWORDS_LENGTH)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}
@end
