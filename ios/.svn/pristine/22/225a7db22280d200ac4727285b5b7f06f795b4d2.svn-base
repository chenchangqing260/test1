//
//  HomeShareViewController.m
//  passbook
//
//  Created by Ellison on 16/4/6.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "HomeShareViewController.h"
#import "A_AdvancedVibrancyView.h"
#import "ShareModel.h"
#import "ThirdShareHandler.h"

@interface HomeShareViewController ()

@property (weak, nonatomic) IBOutlet A_AdvancedVibrancyView *uiBlurView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *uiPengyouquanLeftSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *uiPengyouquanRightSpace;

@end

@implementation HomeShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_uiBlurView presentEffect]; //Dispaly Light blur style with 0.5 second animation
    [_uiBlurView presentEffectWithoutAnimation:UIBlurEffectStyleDark];
//    [_uiBlurView setBlurRadius:5];  // Set blur radius for effect view
//    [_uiBlurView setGrayscaleTintAlpha:0.1];
//    [_uiBlurView setGrayscaleTintLevel:0.5];
    
    __block HomeShareViewController *blockSelf = self;
    self.completeBlock= ^(){
        [blockSelf clickCloseViewBtnAction:nil];
    };
    
    if (kSCREEN_WIDTH < kWIDTH_375) {
        self.uiPengyouquanLeftSpace.constant = self.uiPengyouquanRightSpace.constant = 50;
    }else if(kSCREEN_WIDTH > kWIDTH_375){
        self.uiPengyouquanRightSpace.constant = self.uiPengyouquanLeftSpace.constant = 80;
    }else{
        self.uiPengyouquanLeftSpace.constant = self.uiPengyouquanRightSpace.constant = 60;
    }
}

- (BOOL)showNavBar{
    return NO;
}

- (IBAction)clickCloseViewBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
