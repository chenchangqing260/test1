//
//  YJShowViewManager.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/10/10.
//  Copyright © 2017年 sevenplus. All rights reserved.
//
#define kYJPopViewManager [YJShowViewManager shared]

typedef void(^YJBasicBlock)();

#import <Foundation/Foundation.h>

@interface YJShowViewManager : NSObject

+ (instancetype)shared;
- (void)showPopView:(UIView *)view disMissBlock:(YJBasicBlock)disMissBlock;
- (void)disMissView;

@end
