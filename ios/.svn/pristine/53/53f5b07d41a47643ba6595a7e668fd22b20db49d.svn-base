//
//  QNCustomUploadManager.m
//  passbook
//
//  Created by Ellison on 16/3/29.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "QNCustomUploadManager.h"
#import "QNCustomUploadHelper.h"
#import "QNUploadOption.h"
#import "QNUploadManager.h"
#import "UIImage+ResizeMagick.h"
#import "QNResponseInfo.h"
#import "WebAccessManager.h"
#import "QNKeyHelper.h"

@implementation QNCustomUploadManager

+ (void)qnUpLoadImg:(UIImage *)image token:(NSString*)token imgKey:(NSString*)imgKey maxSize:(CGSize)size progress:(QNUpProgressHandler)progress success:(void (^)(NSString *imageName))success failure:(void (^)())failure
{
    NSData *data = [image resizedImageWithMaximumSize:size compressionQuality:0.5];
    if (!data) {
        if (failure) {
            failure();
        }
        return;
    }
    
    QNUploadOption *opt = [[QNUploadOption alloc] initWithMime:nil progressHandler:progress params:nil checkCrc:NO cancellationSignal:nil];
    QNUploadManager *uploadManager = [[QNUploadManager alloc] init];
    [uploadManager putData:data key:imgKey token:token complete:^(QNResponseInfo *resInfo, NSString *key, NSDictionary *resp) {
        if (resInfo.statusCode == 200 && resp) {
            NSString *imageName = resp[@"key"];
            if (success) {
                success(imageName);
            }
        }
        else {
            if (failure) {
                failure();
            }
        }
    } option:opt];
}

+ (void)uploadImage:(UIImage *)image imgKey:(NSString*)imgKey maxSize:(CGSize)size success:(void (^)(NSString *imageName))success failure:(void (^)())failure
{
    [QNCustomUploadManager getQiniuUploadTokenWithCompletion:^(NSString *token) {
        [QNCustomUploadManager qnUpLoadImg:image token:token imgKey:imgKey maxSize:size progress:nil success:^(NSString *imageName) {
            success(imageName);
        } failure:^{
            failure();
        }];
    } failure:^{
        if (failure) {
            failure();
        }
    }];
}

+ (void)uploadImages:(NSArray *)imageArray
          imgKeyList:(NSMutableArray*)imgKeyList
             maxSize:(CGSize)size
            progress:(void (^)(CGFloat))progress
             success:(void (^)(NSMutableArray *))success
             failure:(void (^)())failure
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    __block float totalProgress = 0.0f;
    __block float partProgress = 1.0f / [imageArray count];
    
    [QNCustomUploadManager getQiniuUploadTokenWithCompletion:^(NSString *token) {
        QNCustomUploadHelper *uploadHelper = [QNCustomUploadHelper sharedInstance];
        __weak typeof(uploadHelper) weakHelper = uploadHelper;
        uploadHelper.singleFailureBlock = ^() {
            failure();
            return;
        };
        
        uploadHelper.singleSuccessBlock  = ^(NSString *url) {
            [array addObject:url];
            totalProgress += partProgress;
            progress(totalProgress);
            if ([array count] == [imageArray count]) {
                success([array copy]);
                return;
            }
        };
        
        for (int i=0; i<imageArray.count; i++) {
            // 开启多线程上传
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [QNCustomUploadManager qnUpLoadImg:imageArray[i] token:token imgKey:imgKeyList[i] maxSize:size progress:nil success:weakHelper.singleSuccessBlock failure:weakHelper.singleFailureBlock];
            });
        }
    } failure:^{
        
    }];
}

+(void)uploadFile:(NSData *)fileData fileKeyKey:(NSString *)fileKey progress:(QNUpProgressHandler)progress success:(void (^)(NSString *))success failure:(void (^)())failure{
    [QNCustomUploadManager getQiniuUploadTokenWithCompletion:^(NSString *token) {
        if (!fileData) {
            if (failure) {
                failure();
            }
            return;
        }
        
        QNUploadOption *opt = [[QNUploadOption alloc] initWithMime:nil progressHandler:progress params:nil checkCrc:NO cancellationSignal:nil];
        QNUploadManager *uploadManager = [[QNUploadManager alloc] init];
        
        
        [uploadManager putData:fileData key:fileKey token:token complete:^(QNResponseInfo *resInfo, NSString *key, NSDictionary *resp) {
            if (resInfo.statusCode == 200 && resp) {
                NSString *imageName = resp[@"key"];
                if (success) {
                    success(imageName);
                }
            }
            else {
                if (failure) {
                    failure();
                }
            }
        } option:opt];
        
    } failure:^{
        if (failure) {
            failure();
        }
    }];
}

+ (void)getQiniuUploadTokenWithCompletion:(void (^)(NSString *))success failure:(void (^)())failure
{
    [[WebAccessManager sharedInstance] getQiniuTokenCompletion:^(WebResponse *response, NSError *error) {
        if (response.data != nil) {
            if (success) {
                success(response.data.token);
            }
        }else{
            failure();
        }
    }];
}

@end
