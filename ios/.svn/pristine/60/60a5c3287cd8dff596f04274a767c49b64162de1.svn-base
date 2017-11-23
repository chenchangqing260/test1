//
//  QNKeyHelper.m
//  hxz
//
//  Created by sevenplus on 15/10/20.
//  Copyright © 2015年 goodswiss. All rights reserved.
//

#import "QNKeyHelper.h"

@implementation QNKeyHelper

#pragma mark - Helpers

+ (NSString *)getQNKey:(NSString*)prefix suffix:(NSString*)suffix{
    if (!suffix) {
        suffix = @"jpg";
    }
    if (prefix != nil) {
        NSString *key = [NSString stringWithFormat:@"%@_%@_%@.%@", prefix, [self getDateTimeString], [self randomStringWithLength:8], suffix];
        
        return key;
    }else{
        NSString *key = [NSString stringWithFormat:@"%@_%@.%@", [self getDateTimeString], [self randomStringWithLength:8], suffix];
        
        return key;
    }
}

+ (NSMutableArray *)getQNKeyForArray:(NSString*)prefix suffix:(NSString*)suffix count:(NSUInteger)count{
    if (!suffix) {
        suffix = @"jpg";
    }
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<count; i++) {
        if (prefix != nil) {
            NSString *key = [NSString stringWithFormat:@"%@_%@_%@.%@", prefix, [self getDateTimeString], [self randomStringWithLength:8], suffix];
            
            [array addObject:key];
        }else{
            NSString *key = [NSString stringWithFormat:@"%@_%@.%@", [self getDateTimeString], [self randomStringWithLength:8], suffix];
            
            [array addObject:key];
        }
        
    }
    
    return array;
}

+ (NSString *)getDateTimeString
{
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    
    return dateString;
}


+ (NSString *)randomStringWithLength:(int)len
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    
    return randomString;
}


@end
