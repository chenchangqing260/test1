//
//  QNCustomUploadManager.h
//  passbook
//
//  Created by Ellison on 16/3/29.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QNUploadOption.h"

@interface QNCustomUploadManager : NSObject

@property (nonatomic, strong) NSString* token;

// 单张上传
+ (void)uploadImage:(UIImage *)image imgKey:(NSString*)imgKey maxSize:(CGSize)size success:(void (^)(NSString *imageName))success failure:(void (^)())failure;

// 上传多张图片,按队列依次上传
+ (void)uploadImages:(NSArray *)imageArray
          imgKeyList:(NSMutableArray*)imgKeyList
             maxSize:(CGSize)size
            progress:(void (^)(CGFloat))progress
             success:(void (^)(NSMutableArray *))success
             failure:(void (^)())failure;

// 上传单个附件
+ (void)uploadFile:(NSData *)fileData fileKeyKey:(NSString*)fileKey progress:(QNUpProgressHandler)progress success:(void (^)(NSString *imageName))success failure:(void (^)())failure;

@end
