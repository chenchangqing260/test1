//
//  MyAlertViewController.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/9/30.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@protocol MyAlertViewControllerDelegate <NSObject>

- (void)clickNbvBtn;

@end

@interface MyAlertViewController : BaseViewController
@property (nonatomic, weak)id<MyAlertViewControllerDelegate> delegate;
@end
