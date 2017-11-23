//
//  JSONUtil.m
//
//  Created by Ellison Xu on 15/9/20.
//  Copyright (c) 2015年 sevenplus. All rights reserved.
//

#import "JSONUtil.h"
#import "BeanEntityManager.h"

@implementation JSONUtil

+ (id)objectFromData:(NSData *)jsonData class:(Class)oClass
{
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers | NSJSONReadingAllowFragments error:nil];
    return [self objectFromJSONObject:jsonObject class:oClass];
}

+ (NSData *)dataFromObject:(id)object
{
    if ([object isKindOfClass:[NSString class]]) {
        NSString *jsonStr = [NSString stringWithFormat:@"\"%@\"",object];

        return [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    id jsonObject = [self JSONObjectFromObject:object];
    if ([NSJSONSerialization isValidJSONObject:jsonObject]) {
        return [NSJSONSerialization dataWithJSONObject:jsonObject options:0 error:nil];
    }
    
    return nil;
}


+ (id)objectFromJSONObject:(id)jsonObject class:(Class)oClass
{
    return [[BeanEntityManager defaultManager] objectWithJSONObject:jsonObject class:oClass];
}

+ (id)JSONObjectFromObject:(id)object
{
    return [[BeanEntityManager defaultManager] JSONObjectWithObject:object];
}

@end
