//
//  AboutNewViewController.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/25.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "AboutNewViewController.h"

@interface AboutNewViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *UIImage;
@property (weak, nonatomic) IBOutlet UILabel *uiVersionLab;

@end

@implementation AboutNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于";
    self.uiVersionLab.text = kAppCurVersion;
    [self.UIImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[WebAccessManager sharedInstance] webWithOutServiceUrl], @"images/orCode.png"]] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    
    // 通过网络数据调用分享
    [[WebAccessManager sharedInstance]getAppShareModelWithCompletion:^(WebResponse *response, NSError *error) {
        if (response.success) {
            self.shareModel = response.data.shareModel;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
