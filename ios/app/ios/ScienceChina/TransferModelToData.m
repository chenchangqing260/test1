//
//  TransferModelToData.m
//  ScienceChina
//
//  Created by Ellison on 16/7/4.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "TransferModelToData.h"

@implementation TransferModelToData

+ (BOOL)saveDownloadInfo:(DownloadInfo*)downloadInfo{
    // 1、取得保存的数据
    NSData* data  = [[NSUserDefaults standardUserDefaults] objectForKey:@"DOWNLOADINFOARRAY"];
    NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    // 2、判断此数据是否已经存在
    NSMutableArray* array = [[NSMutableArray alloc] init];
    if (oldSavedArray && oldSavedArray.count > 0) {
        for(int i=0; i<oldSavedArray.count; i++){
            DownloadInfo* info = [oldSavedArray objectAtIndex:i];
            if ([info.in_id isEqualToString:downloadInfo.in_id]) {
                // 已经存在
                return false;
            }
            [array addObject:info];
        }
    }
    
    // 3、不存在这条记录，则将数据保存
    [array insertObject:downloadInfo atIndex:0];
    
    // 4、保存到沙盒中
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:array] forKey:@"DOWNLOADINFOARRAY"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return true;
}

+ (DownloadInfo*)getDownloadInfoWithInId:(NSString*)in_id{
    NSData* data  = [[NSUserDefaults standardUserDefaults] objectForKey:@"DOWNLOADINFOARRAY"];
    NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    DownloadInfo* downInfo = nil;
    for (int i=0; i<oldSavedArray.count; i++) {
        DownloadInfo *info = [oldSavedArray objectAtIndex:i];
        if ([info.in_id isEqualToString:in_id]) {
            downInfo = info;
        }
    }
    
    return downInfo;
}

+ (NSMutableArray*)getDownloadInfoArray{
    NSData* data  = [[NSUserDefaults standardUserDefaults] objectForKey:@"DOWNLOADINFOARRAY"];
    NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return [oldSavedArray mutableCopy];
}

+ (BOOL)delDownloadInfoWithInId:(NSString*)in_id{
    // 1、取得保存的数据
    NSData* data  = [[NSUserDefaults standardUserDefaults] objectForKey:@"DOWNLOADINFOARRAY"];
    NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    // 2、判断传入的idx是否符合要求
    int isDelIdx = -1;
    if (oldSavedArray && oldSavedArray.count > 0) {
        NSMutableArray* newArray = [oldSavedArray mutableCopy];
        for (int i=0; i<newArray.count; i++) {
            DownloadInfo *info = [newArray objectAtIndex:i];
            if ([info.in_id isEqualToString:in_id]) {
                // 删除
                isDelIdx = i;
                break;
            }
        }
        
        if (isDelIdx != -1) {
            [newArray removeObjectAtIndex:isDelIdx];
        }
        
        // 4、保存到沙盒中
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:newArray] forKey:@"DOWNLOADINFOARRAY"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        return true;
    }
    
    return false;
}

+ (void)delAllDownloadInfo{
    // 1、取得保存的数据
    NSData* data  = [[NSUserDefaults standardUserDefaults] objectForKey:@"DOWNLOADINFOARRAY"];
    NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    // 2、判断传入的idx是否符合要求
    if (oldSavedArray && oldSavedArray.count > 0) {
        {
            NSMutableArray* newArray = [oldSavedArray mutableCopy];
            [newArray removeAllObjects];
            // 4、保存到沙盒中
            [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:newArray] forKey:@"DOWNLOADINFOARRAY"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:[NSMutableArray new]] forKey:@"DOWNLOADINFOARRAY"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
