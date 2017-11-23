//
//  CustomDownloadManager.h
//  ScienceChina
//
//  Created by Ellison on 16/7/11.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadInfo.h"

@interface CustomDownloadManager : NSObject

// 下载视频
+ (void)downloadVideoWithDownloadInfo:(DownloadInfo*)downloadInfo doDownload:(BOOL)isDownload byWIFI:(BOOL)wifi;

// 判断资源是否下载
+ (BOOL)isDownloadInfoWithInId:(NSString*)inId;

// 判断是否下载完成
+ (BOOL)isDownloadCompleteWithInId:(NSString*)inId;

// 删除下载的资源
+ (BOOL)deleteDownloadVideoWithInId:(NSString*)inId;

// 删除所有下载的资源
+ (BOOL)deleteAllDownloadVideo;

@end
