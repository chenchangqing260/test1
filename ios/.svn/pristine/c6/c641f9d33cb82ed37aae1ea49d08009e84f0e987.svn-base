//
//  PicDetialView.h
//  ScienceChina
//
//  Created by Ellison on 16/5/13.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicDetialView : UIView

@property (nonatomic, strong) UIScrollView  *scrollView;    //容器
@property (nonatomic, strong) UIImageView   *imageView;     //执行动画的图片视图
@property (nonatomic, assign, setter=enableDoubleTap:) BOOL isDoubleTapEnabled; //是否允许双击放大
@property (nonatomic, strong) void (^singleTapBlock)(UITapGestureRecognizer *recognizer);   //单击的回调处理

- (void) reloadData;
- (void) zoomImgView;

@end
