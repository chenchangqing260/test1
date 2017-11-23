//
//  LXCircleAnimationView.h
//  LXCircleAnimationView
//
//  Created by Leexin on 15/12/18.
//  Copyright © 2015年 Garden.Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXCircleAnimationView : UIView

@property (nonatomic, assign) CGFloat percent; // 百分比 0 - 100
@property (nonatomic, strong) UIImage *bgImage; // 背景图片
@property (nonatomic, strong) NSString *title; // 最上面文字
@property (nonatomic, strong) NSString *text; // 文字
@property (nonatomic, strong) UIColor *backColor; // 线条色
@property (nonatomic, strong) UIColor *progressColor; // 进度条颜色
@property (nonatomic, strong) UIColor *pointColor; // 圆点颜色

/**
 * 若颜色值为 nil,则使用默认值
 */
- (instancetype)initWithFrame:(CGRect)frame backColor:(UIColor *)backColor progressColor:(UIColor *)progressColor pointColor:(UIColor *)pointColor;

@end
