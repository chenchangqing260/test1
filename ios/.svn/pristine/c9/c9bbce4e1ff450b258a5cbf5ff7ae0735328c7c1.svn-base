//
//  UIImage+UIImageExtras.m
//  ScienceChina
//
//  Created by Ellison on 16/5/21.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "UIImage+UIImageExtras.h"

@implementation UIImage (UIImageExtras)

- (UIImage *)imageByScalingToSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor < heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor < heightFactor) {
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor > heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    // this is actually the interesting part:
    UIGraphicsBeginImageContext(targetSize);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    return newImage ;
}

- (UIImage *)imageBy2xImage
{
    UIImage *sourceImage = self;
    CGSize size = CGSizeMake(sourceImage.size.width / 2.0f, sourceImage.size.height / 2.0f);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    if (1.0 == [[UIScreen mainScreen] scale]){
        [sourceImage drawInRect:CGRectIntegral((CGRect){0.0f, 0.0f, size})];
    }
    else
    {
        [sourceImage drawInRect:(CGRect){0.0f, 0.0f, size}];
    }
    sourceImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return sourceImage;
}

@end
