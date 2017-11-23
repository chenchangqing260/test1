//
//  UITabBar+WJBadgeValue.h
//  UITabBar_Test
//
//  Created by 曾维俊 on 16/4/5.
//  Copyright © 2016年 曾维俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (WJBadgeValue)

- (void)showBadgeOnItemIndex:(int)index;   //显示小红点
- (void)hideBadgeOnItemIndex:(int)index;   //隐藏小红点

- (void)showAnimated:(BOOL)animated;
- (void)hideAnimated:(BOOL)animated;

@end
