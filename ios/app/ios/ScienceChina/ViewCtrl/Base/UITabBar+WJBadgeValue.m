//
//  UITabBar+WJBadgeValue.m
//  UITabBar_Test
//
//  Created by 曾维俊 on 16/4/5.
//  Copyright © 2016年 曾维俊. All rights reserved.
//

#import "UITabBar+WJBadgeValue.h"

#define BADGE_VIEW_TAG 1314

@implementation UITabBar (WJBadgeValue)

//显示小红点
- (void)showBadgeOnItemIndex:(int)index {
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    CGFloat badgeViewWH = 8;
    CGRect  badgeViewFrame = CGRectMake(0, 0, badgeViewWH, badgeViewWH);
    UIView *badgeView = [[UIView alloc] initWithFrame:badgeViewFrame];
    badgeView.tag = BADGE_VIEW_TAG + index;
    badgeView.layer.cornerRadius = badgeViewFrame.size.width / 2; //圆形
    badgeView.backgroundColor = [UIColor redColor];//颜色：红色
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float percentX = (index + 0.6) / self.items.count;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeViewFrame.origin = CGPointMake(x, y);
    badgeView.frame = badgeViewFrame;
    [self addSubview:badgeView];
}

//隐藏小红点
- (void)hideBadgeOnItemIndex:(int)index {
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}

//移除小红点
- (void)removeBadgeOnItemIndex:(int)index {
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == BADGE_VIEW_TAG + index) {
            [subView removeFromSuperview];
        }
    }
}

- (void)showAnimated:(BOOL)animated {
    if (!self.isHidden) return;
    self.hidden = NO; // previous show
    if (animated) {
        CGRect frame = self.frame;
        frame.origin.y -= 50;
        [UIView animateWithDuration:UINavigationControllerHideShowBarDuration
                         animations:^{
            self.frame = frame;
        }];
    }
}

- (void)hideAnimated:(BOOL)animated {
    if (self.isHidden) return;
    if (animated) {
        CGRect frame = self.frame;
        frame.origin.y += 50;
        [UIView animateWithDuration:UINavigationControllerHideShowBarDuration
                         animations:^{
            self.frame = frame;
        } completion:^(BOOL finished) {
            self.hidden = YES;
        }];
    } else {
        self.hidden = YES;
    }
}


@end
