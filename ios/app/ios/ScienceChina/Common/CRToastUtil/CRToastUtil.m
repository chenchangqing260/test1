//
//  CRToastUtil.m
//  passbook
//
//  Created by Ellison on 16/2/25.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#define durSeconds 30.0f

#import "CRToastUtil.h"
#import <CRToastManager.h>
#import <CRToastConfig.h>

static BOOL isShowing = NO;

@implementation CRToastUtil

+ (void)showAttentionMessageWithText:(NSString*)text{
    if (isShowing) {
        return;
    }
    
    isShowing = YES;
    
    if (!text || [text isEmptyOrWhitespace]) {
        text = @"网络不太顺畅，请稍后再试。";
    }
    
    NSDictionary *options = @{
                              kCRToastTextKey : text,
                              kCRToastFontKey : FONT_15,
                              kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                              kCRToastBackgroundColorKey : [UIColor colorWithHex:0xE5505E alpha:0.9],
                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeGravity),
                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeGravity),
                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop),
                              kCRToastNotificationTypeKey : @(CRToastTypeNavigationBar),
                              kCRToastTimeIntervalKey : @(2.5),
                              };
    [CRToastManager showNotificationWithOptions:options
                                completionBlock:^{
                                    isShowing = NO;
                                }];
}

+(void)showPublicMessageWithText:(NSString*)text{
    if (isShowing) {
        return;
    }
    
    isShowing = YES;
    
    if (!text || [text isEmptyOrWhitespace]) {
        text = @"网络不太顺畅，请稍后再试。";
    }
    
    NSDictionary *options = @{
                              kCRToastTextKey : text,
                              kCRToastFontKey : FONT_15,
                              kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                              kCRToastBackgroundColorKey : [UIColor colorWithHex:0x33CFDA alpha:0.9],
                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeGravity),
                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeGravity),
                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop),
                              kCRToastNotificationTypeKey : @(CRToastTypeNavigationBar),
                              kCRToastTimeIntervalKey : @(2.0),
                              };
    [CRToastManager showNotificationWithOptions:options
                                completionBlock:^{
                                    isShowing = NO;
                                }];
}

@end
