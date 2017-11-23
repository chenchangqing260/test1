//
//  ChannelModel.h
//  ScienceChina
//
//  Created by xuanyj on 16/11/21.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChannelModel : NSObject <BeanSupport>

@property (nonatomic,strong) NSString *at_id;//频道唯一标识
@property (nonatomic,strong) NSString *at_name_ch;//频道中文名
@property (nonatomic,strong) NSString *at_name_en;//频道英文名

-(id)initWithDic:(NSDictionary *)dic;
@end
