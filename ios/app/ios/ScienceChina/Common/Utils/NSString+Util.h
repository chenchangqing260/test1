//
//  NSString+Util.h
//  hxz
//
//  Created by Ellison Xu on 15/9/21.
//  Copyright (c) 2015年 sevenplus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Util)

+ (NSString *)empty;
- (NSString *) trim;
- (BOOL)isEmptyOrWhitespace;

@end
