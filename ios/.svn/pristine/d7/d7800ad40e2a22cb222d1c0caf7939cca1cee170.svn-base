//
//  YJShowAreaoverController.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/10/10.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJ_const.h"

@interface YJShowAreaoverController : UIViewController
/**
 *
 *  @param contentViewController 内容视图
 *  @param popoverContentSize    内容视图大小
 *
 */
- (instancetype)initWithContentViewController:(UIViewController *)contentViewController popoverContentSize:(CGSize)popoverContentSize;

/**
 *
 *  @param fromRect                以此rect来决定弹出框位置
 *  @param inView                  fromRect参数是以此view为参考
 *  @param permitterArrowDirection 箭头方向
 *  @param animated                是否有动画
 */
- (void)presentPopoverFromRect:(CGRect)fromRect inView:(UIView *)inView permitterArrowDirections:(YJPopoverArrowDirection)permitterArrowDirection animated:(BOOL)animated;
- (void)presentPopoverFromBarButtonItem:(UIBarButtonItem *)item permittedArrowDirections:(YJPopoverArrowDirection)arrowDirections animated:(BOOL)animated;

- (void) closeAllView;
@end
