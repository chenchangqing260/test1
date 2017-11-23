//
//  SDCursorView.h
//  SDPagesSelector
//
//  Created by 宋东昊 on 16/7/15.
//  Copyright © 2016年 songdh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDCursorView : UIView

/**
 * @ 选中的第几个频道
 */
@property (nonatomic, assign) NSInteger selectedIndex;

/**
 * @ 选中的第几个频道
 */
@property (nonatomic, copy) void(^didSelectedIndexBlock)(NSInteger selectedIndex);

/**
 * @ 处理点击“+”按钮事件
 */
@property (nonatomic, copy) void(^tapAddChannelBlock)();

/**
 * 是否显示“+”按钮，默认显示YES
 */

@property (nonatomic,assign) BOOL showAddButton;
/**
 *  底部标识线
 */
@property (nonatomic, strong) UIView *lineView;

/**
 *  当前页面所在的controller，必须赋值
 */
@property (nonatomic, strong) UIViewController *parentViewController;
/**
 *  底部切换页面的容器高度
 */
@property (nonatomic, assign) CGFloat contentViewHeight;

/**
 *  标题和显示的页面，数量必须相等。
 */
@property (nonatomic, copy) NSMutableArray *titles;
/**
 *  所要添加的viewController的实例。绘制界面时，会将viewController的view添加在scrollView上
 */
@property (nonatomic, copy) NSMutableArray *controllers;

/**
 *  默认分别是 [UIColor redColor],[UIColor blackColor]
 */
@property (nonatomic, strong) UIColor *selectedColor; //默认redColor
@property (nonatomic, strong) UIColor *normalColor;   //默认blackColor

/**
 *  默认都是14号字体
 */
@property (nonatomic, strong) UIFont *selectedFont;
@property (nonatomic, strong) UIFont *normalFont;

/**
 *  当前选中的index。可以设置当前的index
 */
@property (nonatomic, assign) NSInteger currentIndex;
/**
 *  分割线位置调整。总是居中显示  默认(0,3,2,3)
    分割线默认高度为3， left可调整宽度，top可调整高度，bottom可调整lineView的y值
 */
@property (nonatomic, assign) UIEdgeInsets lineEdgeInsets;
/**
 *  选择区域调整。默认(0,10,0,10)
 */
@property (nonatomic, assign) UIEdgeInsets cursorEdgeInsets;
/**
 *  必须调用此方法来绘制界面
 */
-(void)reloadPages;
@end
