//
//  CustomPopView.h
//  CustomPopView
//
//  Created by gavin on 2016/11/28.
//  Copyright © 2016年 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CustomPopViewCallBack)(id obj);

@interface CustomPopView : UIView

@property (nonatomic , assign)float makeScale;
@property (nonatomic , assign)float durationTimer;



/**
 *  init frame with show view
 */
- (instancetype)initWithFrame:(CGRect)frame withShowView:(UIView *)viewParam;


/**
 *  show pop view 
 */
- (void)showAnimationPopView;

/**
 *  dissmiss
 */
- (void)disssmissAnimationPopView;


/**
 * set call back
 */
-(void)setCustomPopViewCallBack:(CustomPopViewCallBack)popViewCallBack;

@end
