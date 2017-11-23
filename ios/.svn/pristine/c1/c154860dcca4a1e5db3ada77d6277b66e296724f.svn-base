//
//  SVProgressHUDUtil.m
//  ScienceChina
//
//  Created by Ellison on 16/5/10.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "SVProgressHUDUtil.h"
#import "SVProgressHUD.h"

@implementation SVProgressHUDUtil

+ (void)show{
    [SVProgressHUD show];
}

+ (void)showWithStatus:(NSString*)status{
    [SVProgressHUD showWithStatus:status];
}

+ (void)showWithStatus:(NSString*)status completion:(SVPrgressCompletionBlock)completion{
    [SVProgressHUD showWithStatus:status];
    if (completion) {
        dispatch_main_after(2.7, ^{
            completion();
        });
    }
}

+ (void)showWithStatus:(NSString*)status dur:(CGFloat)d completion:(SVPrgressCompletionBlock)completion{
    [SVProgressHUD showWithStatus:status];
    if (completion) {
        dispatch_main_after(d, ^{
            completion();
        });
    }
}

+ (void)showProgress:(float)progress{
    [SVProgressHUD showProgress:progress];
}

+ (void)showProgress:(float)progress completion:(SVPrgressCompletionBlock)completion{
    [SVProgressHUD showProgress:progress];
    if (completion) {
        dispatch_main_after(2.7, ^{
            completion();
        });
    }
}

+ (void)showProgress:(float)progress status:(NSString*)status{
    [SVProgressHUD showProgress:progress status:status];
}

+ (void)showProgress:(float)progress status:(NSString*)status completion:(SVPrgressCompletionBlock)completion{
    [SVProgressHUD showProgress:progress status:status];
    if (completion) {
        dispatch_main_after(2.7, ^{
            completion();
        });
    }
}

+ (void)setStatus:(NSString*)status{
    [SVProgressHUD setStatus:status];
}

+ (void)showInfoWithStatus:(NSString*)status{
    [SVProgressHUD showInfoWithStatus:status];
}

+ (void)showInfoWithStatus:(NSString*)status completion:(SVPrgressCompletionBlock)completion{
    [SVProgressHUD showInfoWithStatus:status];
    if (completion) {
        dispatch_main_after(2.7, ^{
            completion();
        });
    }
}

+ (void)showSuccessWithStatus:(NSString*)status{
    [SVProgressHUD showSuccessWithStatus:status];
}

+ (void)showSuccessWithStatus:(NSString*)status completion:(SVPrgressCompletionBlock)completion{
    [SVProgressHUD showSuccessWithStatus:status];
    if (completion) {
        dispatch_main_after(2.7, ^{
            completion();
        });
    }
}

+ (void)showErrorWithStatus:(NSString*)status{
    [SVProgressHUD showErrorWithStatus:status];
}

+ (void)showErrorWithStatus:(NSString*)status completion:(SVPrgressCompletionBlock)completion{
    [SVProgressHUD showErrorWithStatus:status];
    if (completion) {
        dispatch_main_after(2.7, ^{
            completion();
        });
    }
}

+ (void)dismiss{
    [SVProgressHUD dismiss];
}

#pragma mark - 辅助方法
static void dispatch_main_after(NSTimeInterval delay, void (^block)(void))
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}

@end
