//
//  InfoObj.m
//  ScienceChina
//
//  Created by Ellison on 16/5/5.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "InfoObj.h"
#import "Comment.h"
#import "BeanSupport.h"

@implementation InfoObj

- (Class)classInArrayForKey:(NSString *)key
{
    // 首页资讯列表
    if ([key isEqualToString:@"reviewList"]) {
        return [Comment class];
    }
    
    if ([key isEqualToString:@"imgList"]) {
        return [InfoObj class];
    }

    return NULL;
}

@end
