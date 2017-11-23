//
//  ShareViewController.m
//  passbook
//
//  Created by Ellison on 16/4/5.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()<ThirdShareDelegate>

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [ThirdShareHandler sharedInstance].delegate = self;
}

- (void)didShareWithShareMode:(ShareThirdPart)part{
    if (part == ShareQQ) {
        if (self.shareModel) {
            [[ThirdShareHandler sharedInstance]shareTo:ShareQQ ShareModel:self.shareModel];
        }
    }else if(part == ShareWeiXin){
        if (self.shareModel) {
            [[ThirdShareHandler sharedInstance]shareTo:ShareWeiXin ShareModel:self.shareModel];
        }
    }else if(part == ShareWXPengyouquan){
        if (self.shareModel) {
            [[ThirdShareHandler sharedInstance]shareTo:ShareWXPengyouquan ShareModel:self.shareModel];
        }
    }else if(part == ShareWeibo){
        if (self.shareModel) {
            [[ThirdShareHandler sharedInstance]shareTo:ShareWeibo ShareModel:self.shareModel];
        }
    }else if(part == ShareQQZone){
        if (self.shareModel) {
            [[ThirdShareHandler sharedInstance]shareTo:ShareQQZone ShareModel:self.shareModel];
        }
    }
}

#pragma mark - 分享点击方法
- (IBAction)clickWeiXinShareAction:(id)sender {
    //DLog(@"微信分享");
    if (self.shareModel) {
        [[ThirdShareHandler sharedInstance]shareTo:ShareWeiXin ShareModel:self.shareModel];
    }
}

- (IBAction)clickPengyouquanShareAction:(id)sender {
    //DLog(@"朋友圈分享");
    if (self.shareModel) {
        [[ThirdShareHandler sharedInstance]shareTo:ShareWXPengyouquan ShareModel:self.shareModel];
    }
}

- (IBAction)clickQQShareAction:(id)sender {
    //DLog(@"QQ分享");
    if (self.shareModel) {
        [[ThirdShareHandler sharedInstance]shareTo:ShareQQ ShareModel:self.shareModel];
    }
}

- (IBAction)clickWeiBoShareAction:(id)sender {
    //DLog(@"微博分享");
    if (self.shareModel) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [[ThirdShareHandler sharedInstance]shareTo:ShareWeibo ShareModel:self.shareModel];
    }
}

- (IBAction)clickQQZoneAction:(id)sender {
    //DLog(@"qq空间分享");
    if (self.shareModel) {
        [[ThirdShareHandler sharedInstance]shareTo:ShareQQZone ShareModel:self.shareModel];
    }
}

#pragma mark - Share Delegate
- (void)didShareCompleted:(BOOL)succeed{
    if (succeed) {
        // 分享成功
        [SVProgressHUDUtil showSuccessWithStatus:@"分享成功" completion:^{
            if (self.completeBlock) {
                self.completeBlock();
            }
        }];
        
        //分享成功后 增加积分
        [[WebAccessManager sharedInstance] addScoreWithInfo:self.shareModel completion:^(WebResponse *response, NSError *error) {
            if (response.success) {
                DLog(@"add score");
            }else{
                DLog(@"%@",[error.userInfo objectForKey:@"errorMessage"]);
            }
            
        }];
        
        // 增加分享次数
        [[WebAccessManager sharedInstance] addShareCountWithInfo:self.shareModel completion:^(WebResponse *response, NSError *error) {
            if(response.success){
                DLog(@"add shareCount");
            }else{
                DLog(@"%@",[error.userInfo objectForKey:@"errorMessage"]);
            }
        }];
    }else{
        //[CRToastUtil showAttentionMessageWithText:@"分享失败"];
    }
}

@end
