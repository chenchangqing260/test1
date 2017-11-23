//
//  UIImage+UIImageExtras.h
//  ScienceChina
//
//  Created by Ellison on 16/5/21.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageExtras)

- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

- (UIImage *)imageBy2xImage;

@end
