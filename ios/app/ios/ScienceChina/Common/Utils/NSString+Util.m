//
//  NSString+Util.m
//  hxz
//
//  Created by Ellison Xu on 15/9/21.
//  Copyright (c) 2015年 sevenplus. All rights reserved.
//

#import "NSString+Util.h"

@implementation NSString(Util)

- (NSString *) trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (NSString *)empty
{
    return @"";
}

- (BOOL)isEmptyOrWhitespace
{
    return [self trim].length == 0;
}

@end
