//
//  ScienceActivity.m
//  ScienceChina
//
//  Created by Ellison on 2017/7/13.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "ScienceActivity.h"

@implementation ScienceActivity

- (Class)classInArrayForKey:(NSString *)key
{
    // 首页资讯列表
    if ([key isEqualToString:@"activity_list"]) {
        return [ScienceActivity class];
    }
    
    return NULL;
}


@end
