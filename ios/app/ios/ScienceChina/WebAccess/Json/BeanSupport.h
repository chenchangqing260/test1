//
//  BeanSupport.h
//
//  Created by Ellison Xu on 15/9/20.
//  Copyright (c) 2015年 sevenplus. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BeanSupport <NSObject>

@optional
- (Class)classInArrayForKey:(NSString *)key;

@end
