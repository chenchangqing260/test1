//
//  UIImage+Util.h
//  hxz
//
//  Created by sevenplus on 15/8/29.
//  Copyright (c) 2015年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (util)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size radius:(CGFloat)radius;

+ (CGSize)getSizeForAavatarWithSourceImage:(UIImage *)image;

@end
