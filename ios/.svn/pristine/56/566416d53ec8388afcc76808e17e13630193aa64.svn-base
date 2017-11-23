//
//  MyAlertViewController.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/9/30.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "MyAlertViewController.h"
#import "RDVTabBarController.h"

@interface MyAlertViewController ()
@property (weak, nonatomic) IBOutlet UILabel *UiBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UIImageTopconstrant;

@end

@implementation MyAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.UiBtn.layer setBorderWidth:2.0];
    [self.UiBtn.layer  setBorderColor: RGBCOLOR(255.0, 255.0, 255.0).CGColor];
    
//    NSLog(@"%f---iphoneheight---",[UIScreen mainScreen].bounds.size.height);
    if([UIScreen mainScreen].bounds.size.height==kHEIGHT_667){
        self.UIImageTopconstrant.constant = 305;
    }else if([UIScreen mainScreen].bounds.size.height==kHEIGHT_568){
        self.UIImageTopconstrant.constant = 290;
    }else{
 
    }
    
    // Do any additional setup after loading the view from its nib.
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ClickBtn:(id)sender {
    [self.delegate clickNbvBtn];
    [self dismissViewControllerAnimated:YES completion:nil];
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
