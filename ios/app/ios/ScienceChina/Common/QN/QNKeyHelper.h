//
//  QNKeyHelper.h
//  hxz
//
//  Created by sevenplus on 15/10/20.
//  Copyright © 2015年 goodswiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QNKeyHelper : NSObject

+ (NSString *)getQNKey:(NSString*)prefix suffix:(NSString*)suffix;

+ (NSMutableArray *)getQNKeyForArray:(NSString*)prefix suffix:(NSString*)suffix count:(NSUInteger)count;

@end
