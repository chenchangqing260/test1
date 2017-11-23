//
//  YJShowViewManager.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/10/10.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "YJShowViewManager.h"
#import "YJ_const.h"

@interface YJShowViewManager ()

@property (nonatomic, strong) UIView *maskView;     //背景遮罩
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, copy) YJBasicBlock disMissBlock;

@end

@implementation YJShowViewManager

+ (instancetype)shared
{
    static YJShowViewManager *viewManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        viewManager = [[super alloc] init];
    });
    return viewManager;
}

- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:kYJCurrentWindow.bounds];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskTapGesture:)];
        [_maskView addGestureRecognizer:tapGesture];
    }
    return _maskView;
}

- (void)maskTapGesture:(UITapGestureRecognizer *)gest
{
    [self disMissView];
}

//显示弹出框
- (void)showPopView:(UIView *)view disMissBlock:(YJBasicBlock)disMissBlock
{
    self.disMissBlock = disMissBlock;
    
    self.contentView = view;
    
    UIView *superView = kYJCurrentWindow;
    [superView addSubview:self.maskView];
    
    view.alpha = 0;
    [superView addSubview:view];
    
    [UIView animateWithDuration:0.2 animations:^{
        view.alpha = 1;
        self.maskView.alpha = 0.4;
    } completion:^(BOOL finished) {
        
    }];
}

//弹出框消失
- (void)disMissView
{
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.contentView.alpha = 0;
        self.maskView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.contentView removeFromSuperview];
        [self.maskView removeFromSuperview];
        self.contentView = nil;
        self.maskView = nil;
        if (self.disMissBlock) {
            self.disMissBlock();
        }
    }];
}

@end
