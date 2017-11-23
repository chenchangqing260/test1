//
//  CustomDownloadManager.m
//  ScienceChina
//
//  Created by Ellison on 16/7/11.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "CustomDownloadManager.h"
#import "TransferModelToData.h"
#import "DownloadInfo.h"
//#import "QINetReachabilityManager.h"

#import "FGGDownloadManager.h"
#import "CoreStatus.h"

@implementation CustomDownloadManager

// 下载视频
+ (void)downloadVideoWithDownloadInfo:(DownloadInfo*)downloadInfo doDownload:(BOOL)isDownload byWIFI:(BOOL)wifi{
    if(![CustomDownloadManager isDownloadInfoWithInId:downloadInfo.in_id]){
        if ([TransferModelToData saveDownloadInfo:downloadInfo]) {
            if (isDownload) {
                // 判断是否在Wifi，是的话，直接缓存，不是的话就不缓存
                if (wifi) {
                    // 判断网络状态
                    if([CoreStatus currentNetWorkStatus] == CoreNetWorkStatusNone){
                        MMPopupItemHandler block = ^(NSInteger index){
                        };
                        // 提示
                        NSArray *items =
                        @[MMItemMake(@"知道了", MMItemTypeHighlight, block)];
                        [[[MMAlertView alloc] initWithTitle:@"提示"
                                                     detail:@"找啊找！找不到网络，请检查！"
                                                      items:items]
                         showWithBlock:nil];
                        
                    }else if ([CoreStatus currentNetWorkStatus] == CoreNetWorkStatusWifi){
                        // 注册播放器
                        [[FGGDownloadManager shredManager] downloadWithUrlString:downloadInfo.in_movie_url toPath:downloadInfo.destinationPath process:^(float progress, NSString *sizeString, NSString *speedString) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_VIDEO_DOWNLOAD object:nil userInfo:@{@"in_id":downloadInfo.in_id}];
                            });
                        } completion:^{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_VIDEO_COMPLETE object:nil userInfo:@{@"in_id":downloadInfo.in_id}];
                            });
                        } failure:^(NSError *error) {
                            
                        }];
                    }else if ([CoreStatus currentNetWorkStatus] == CoreNetWorkStatusWWAN){
                        MMPopupItemHandler block = ^(NSInteger index){
                            if (index == 0) {
                            }
                            
                            if (index == 1) {
                                [[FGGDownloadManager shredManager] downloadWithUrlString:downloadInfo.in_movie_url toPath:downloadInfo.destinationPath process:^(float progress, NSString *sizeString, NSString *speedString) {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_VIDEO_DOWNLOAD object:nil userInfo:@{@"in_id":downloadInfo.in_id}];
                                    });
                                } completion:^{
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_VIDEO_COMPLETE object:nil userInfo:@{@"in_id":downloadInfo.in_id}];
                                    });
                                } failure:^(NSError *error) {
                                    
                                }];
                            }
                        };
                        // 提示
                        NSArray *items =
                        @[MMItemMake(@"去找WIFI", MMItemTypeNormal, block),
                          MMItemMake(@"土豪继续", MMItemTypeHighlight, block)];
                        [[[MMAlertView alloc] initWithTitle:@"提示"
                                                     detail:@"网络处于3/4G环境下!"
                                                      items:items]
                         showWithBlock:nil];
                    }
                }else{
                    // 不需要判断，直接操作
                    [[FGGDownloadManager shredManager] downloadWithUrlString:downloadInfo.in_movie_url toPath:downloadInfo.destinationPath process:^(float progress, NSString *sizeString, NSString *speedString) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_VIDEO_DOWNLOAD object:nil userInfo:@{@"in_id":downloadInfo.in_id}];
                        });
                    } completion:^{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_VIDEO_COMPLETE object:nil userInfo:@{@"in_id":downloadInfo.in_id}];
                        });
                    } failure:^(NSError *error) {
                        
                    }];
                }
            }
        }
    }
}

//+ (void)downloadVideoWithDownloadInfo:(DownloadInfo*)downloadInfo doDownload:(BOOL)isDownload byWIFI:(BOOL)wifi{
//    if(![CustomDownloadManager isDownloadInfoWithInId:downloadInfo.in_id]){
//        if ([TransferModelToData saveDownloadInfo:downloadInfo]) {
//            if (isDownload) {
//                // 判断是否在Wifi，是的话，直接缓存，不是的话就不缓存
//                if (wifi) {
//                    // 判断网络状态
//                    QINetReachabilityStatus status = [CustomDownloadManager netWorkingStatus];
//                    if(status == QINetReachabilityStatusNotReachable){
//                        MMPopupItemHandler block = ^(NSInteger index){
//                        };
//                        // 提示
//                        NSArray *items =
//                        @[MMItemMake(@"知道了", MMItemTypeHighlight, block)];
//                        [[[MMAlertView alloc] initWithTitle:@"提示"
//                                                     detail:@"找啊找！找不到网络，请检查！"
//                                                      items:items]
//                         showWithBlock:nil];
//
//                    }else if (status == QINetReachabilityStatusWIFI){
//                        // 注册播放器
//                        [[FGGDownloadManager shredManager] downloadWithUrlString:downloadInfo.in_movie_url toPath:downloadInfo.destinationPath process:^(float progress, NSString *sizeString, NSString *speedString) {
//                            dispatch_async(dispatch_get_main_queue(), ^{
//                                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_VIDEO_DOWNLOAD object:nil userInfo:@{@"in_id":downloadInfo.in_id}];
//                            });
//                        } completion:^{
//                            dispatch_async(dispatch_get_main_queue(), ^{
//                                [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_VIDEO_COMPLETE object:nil userInfo:@{@"in_id":downloadInfo.in_id}];
//                            });
//                        } failure:^(NSError *error) {
//
//                        }];
//                    }else if (status == QINetReachabilityStatusWWAN){
//                        MMPopupItemHandler block = ^(NSInteger index){
//                            if (index == 0) {
//                            }
//
//                            if (index == 1) {
//                                [[FGGDownloadManager shredManager] downloadWithUrlString:downloadInfo.in_movie_url toPath:downloadInfo.destinationPath process:^(float progress, NSString *sizeString, NSString *speedString) {
//                                    dispatch_async(dispatch_get_main_queue(), ^{
//                                        [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_VIDEO_DOWNLOAD object:nil userInfo:@{@"in_id":downloadInfo.in_id}];
//                                    });
//                                } completion:^{
//                                    dispatch_async(dispatch_get_main_queue(), ^{
//                                        [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_VIDEO_COMPLETE object:nil userInfo:@{@"in_id":downloadInfo.in_id}];
//                                    });
//                                } failure:^(NSError *error) {
//
//                                }];
//                            }
//                        };
//                        // 提示
//                        NSArray *items =
//                        @[MMItemMake(@"去找WIFI", MMItemTypeNormal, block),
//                          MMItemMake(@"土豪继续", MMItemTypeHighlight, block)];
//                        [[[MMAlertView alloc] initWithTitle:@"提示"
//                                                     detail:@"网络处于3/4G环境下!"
//                                                      items:items]
//                         showWithBlock:nil];
//                    }
//                }else{
//                    // 不需要判断，直接操作
//                    [[FGGDownloadManager shredManager] downloadWithUrlString:downloadInfo.in_movie_url toPath:downloadInfo.destinationPath process:^(float progress, NSString *sizeString, NSString *speedString) {
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_VIDEO_DOWNLOAD object:nil userInfo:@{@"in_id":downloadInfo.in_id}];
//                        });
//                    } completion:^{
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [[NSNotificationCenter defaultCenter]postNotificationName:kNOTOICE_VIDEO_COMPLETE object:nil userInfo:@{@"in_id":downloadInfo.in_id}];
//                        });
//                    } failure:^(NSError *error) {
//
//                    }];
//                }
//            }
//        }
//    }
//}

// 判断资源是否下载
+ (BOOL)isDownloadInfoWithInId:(NSString*)inId{
    DownloadInfo* downloadInfo = [TransferModelToData getDownloadInfoWithInId:inId];
    if (downloadInfo) {
        return true;
    }else{
        return false;
    }
    
}

// 判断是否下载完成
+ (BOOL)isDownloadCompleteWithInId:(NSString*)inId{
    // 1、获取下载的资源
    DownloadInfo* downloadInfo = [TransferModelToData getDownloadInfoWithInId:inId];
    if (downloadInfo) {
        BOOL exist=[[NSFileManager defaultManager] fileExistsAtPath:downloadInfo.destinationPath];
        if(exist)
        {
            //获取原来的下载进度
            float progress =[[FGGDownloadManager shredManager] lastProgress:downloadInfo.in_movie_url];
            
            if (progress == 1) {
                return true;
            }else{
                return false;
            }
        }
        return false;
    }else{
        return false;
    }
}

// 删除下载的资源
+ (BOOL)deleteDownloadVideoWithInId:(NSString*)inId{
    DownloadInfo* downloadInfo = [TransferModelToData getDownloadInfoWithInId:inId];
    // 1、删除资源
    [[FGGDownloadManager shredManager] removeForUrl:downloadInfo.in_movie_url file:downloadInfo.destinationPath];
    
    // 2、删除沙盒数据
    return [TransferModelToData delDownloadInfoWithInId:inId];
    
    return true;
}

// 删除所有下载的资源
+ (BOOL)deleteAllDownloadVideo{
    NSMutableArray *downloadInfoArray = [TransferModelToData getDownloadInfoArray];
    if (downloadInfoArray) {
        for (DownloadInfo* downloadInfo in downloadInfoArray) {
            [CustomDownloadManager deleteDownloadVideoWithInId:downloadInfo.in_id];
        }
    }
    return true;
}

//+ (QINetReachabilityStatus)netWorkingStatus{
//    QINetReachabilityManager *manager = [QINetReachabilityManager sharedInstance];
//
//    QINetReachabilityStatus status = (QINetReachabilityStatus)[manager currentNetReachabilityStatus];
//
//    return status;
//}

@end
