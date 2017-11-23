//
//  SVProgressHUDUtil.h
//  ScienceChina
//
//  Created by Ellison on 16/5/10.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SVPrgressCompletionBlock)(void);

@interface SVProgressHUDUtil : NSObject

+ (void)show;
+ (void)showWithStatus:(NSString*)status;
+ (void)showWithStatus:(NSString*)status completion:(SVPrgressCompletionBlock)completion;
+ (void)showWithStatus:(NSString*)status dur:(CGFloat)d completion:(SVPrgressCompletionBlock)completion;

+ (void)showProgress:(float)progress;
+ (void)showProgress:(float)progress completion:(SVPrgressCompletionBlock)completion;
+ (void)showProgress:(float)progress status:(NSString*)status;
+ (void)showProgress:(float)progress status:(NSString*)status completion:(SVPrgressCompletionBlock)completion;

+ (void)setStatus:(NSString*)status;

+ (void)showInfoWithStatus:(NSString*)status;
+ (void)showInfoWithStatus:(NSString*)status completion:(SVPrgressCompletionBlock)completion;
+ (void)showSuccessWithStatus:(NSString*)status;
+ (void)showSuccessWithStatus:(NSString*)status completion:(SVPrgressCompletionBlock)completion;
+ (void)showErrorWithStatus:(NSString*)status;
+ (void)showErrorWithStatus:(NSString*)status completion:(SVPrgressCompletionBlock)completion;

+ (void)dismiss;

@end
