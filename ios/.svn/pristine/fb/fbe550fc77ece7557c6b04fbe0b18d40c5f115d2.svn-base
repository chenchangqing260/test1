//
//  ShareToFriendViewController.m
//  ScienceChina
//
//  Created by Ellison on 16/5/12.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "ShareToFriendViewController.h"

@interface ShareToFriendViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;
@end

@implementation ShareToFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"共享科普生活";
    
    [self.uiImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[WebAccessManager sharedInstance] webWithOutServiceUrl], @"images/orCode.png"]] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    
    // 通过网络数据调用分享
    [[WebAccessManager sharedInstance]getAppShareModelWithCompletion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            self.shareModel = response.data.shareModel;
        }
    }];
}


@end
