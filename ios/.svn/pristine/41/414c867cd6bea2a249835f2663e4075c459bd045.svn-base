//
//  ChannelModel.m
//  ScienceChina
//
//  Created by xuanyj on 16/11/21.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "ChannelModel.h"

@implementation ChannelModel
- (Class)classInArrayForKey:(NSString *)key
{
    if ([key isEqualToString:@"atCollectList"]) {
        return [ChannelModel class];
    }
    return NULL;
}

-(id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.at_id      = dic[@"at_id"];
        self.at_name_ch = dic[@"at_name_ch"];
        self.at_name_en = dic[@"at_name_en"];
    }
    return self;
}

@end
