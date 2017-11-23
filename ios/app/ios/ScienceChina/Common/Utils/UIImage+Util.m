//
//  UIImage+Util.m
//  hxz
//
//  Created by sevenplus on 15/8/29.
//  Copyright (c) 2015年 sevenplus. All rights reserved.
//

#import "UIImage+Util.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImage (util)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size

{
    @autoreleasepool {
        
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        UIGraphicsBeginImageContext(rect.size);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context,
                                       
                                       color.CGColor);
        
        CGContextFillRect(context, rect);
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        return img;
        
    }
}


//此方法能够画出圆角，但是圆角模糊
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size radius:(CGFloat)radius{
    
    @autoreleasepool {
        CGFloat width = size.width;
        CGFloat height = size.height;
        
        CGFloat R, G, B, A;
        
        long numComponents = CGColorGetNumberOfComponents(color.CGColor);
        
        if (numComponents == 4)
        {
            const CGFloat *components = CGColorGetComponents(color.CGColor);
            R = components[0];
            G = components[1];
            B = components[2];
            A = components[3];
        }
        
        CGRect rect = CGRectMake(0, 0, width, height);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context,color.CGColor);
        CGContextSetRGBStrokeColor(context,R,G,B,A);//画笔线的颜色
        
        CGContextMoveToPoint(context, width, height - radius);  // 移动到右下角圆弧起始点
        CGContextAddArcToPoint(context, width, height, width - radius, height, radius);//画右下角圆弧
        CGContextAddLineToPoint(context, radius, height);//画底部直线
        CGContextAddArcToPoint(context, 0, height, 0, height - radius, radius);//画左下角圆弧
        CGContextAddLineToPoint(context, 0, radius);//画左侧直线
        CGContextAddArcToPoint(context, 0, 0, radius, 0, radius);//画左上角圆弧
        CGContextAddLineToPoint(context, width - radius, 0);//画顶部直线
        CGContextAddArcToPoint(context, width, 0, width, radius, radius);//画右上角圆弧
        
        CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        return img;
    }
}

+ (CGSize)getSizeForAavatarWithSourceImage:(UIImage *)image
{
    // compress the source image with the original ratio to request avatar size;
    int avatarWidth = 66;
    int avatarHeight = 66;
    if (image.size.width > image.size.height) {
        avatarHeight =  image.size.height / image.size.width * avatarWidth;
    } else {
        avatarWidth = image.size.width / image.size.height * avatarHeight;
    }
    
    return CGSizeMake(avatarWidth, avatarHeight);
}

@end
