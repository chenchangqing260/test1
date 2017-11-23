//
//  ChannelUnitModel.h
//  V1_Circle
//
//  Created by 刘瑞龙 on 15/11/10.
//  Copyright © 2015年 com.Dmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChannelUnitModel : NSObject

@property (nonatomic, copy) NSString *cid;
@property (nonatomic, copy) NSString *at_id;

@property (nonatomic, copy) NSString *at_name_ch;
@property (nonatomic, copy) NSString *at_name_en;

@property (nonatomic, assign) BOOL isTop;

@end
