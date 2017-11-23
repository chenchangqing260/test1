//
//  Country.h
//  AddressTest
//
//  Created by Ellison on 2017/5/18.
//  Copyright © 2017年 航磊_. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Country : NSObject

@property (nonatomic, strong) NSString *code; //编码
@property (nonatomic, strong) NSString *name; //名字
@property (nonatomic, strong) NSMutableArray* townArray; //县市区列表

@end
