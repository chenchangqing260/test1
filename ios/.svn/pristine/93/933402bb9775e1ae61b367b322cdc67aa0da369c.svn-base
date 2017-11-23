//
//  QNCustomUploadHelper.m
//  passbook
//
//  Created by Ellison on 16/3/29.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "QNCustomUploadHelper.h"

@implementation QNCustomUploadHelper

+ (instancetype)sharedInstance
{
    static QNCustomUploadHelper *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[QNCustomUploadHelper alloc] init];
    });
    return _sharedInstance;
}

@end
