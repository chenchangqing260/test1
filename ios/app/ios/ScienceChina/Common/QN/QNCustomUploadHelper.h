//
//  QNCustomUploadHelper.h
//  passbook
//
//  Created by Ellison on 16/3/29.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QNCustomUploadHelper : NSObject

@property (copy, nonatomic) void (^singleSuccessBlock)(NSString *);
@property (copy, nonatomic)  void (^singleFailureBlock)();

+ (instancetype)sharedInstance;

@end
