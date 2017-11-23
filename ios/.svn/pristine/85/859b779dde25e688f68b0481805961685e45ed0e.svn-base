//
//  GroupListModel.m
//  ScienceChina
//
//  Created by xuanyj on 16/11/30.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "GroupListModel.h"

@implementation GroupListModel
-(id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setProprrtyWithDic:dic];
    }
    return self;
}
-(void)setProprrtyWithDic:(NSDictionary *)dic{
    self.title = dic[@"title"];
    
    NSMutableArray *subData = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSDictionary *detailDic in dic[@"sublist"]) {
        GroupListDetailModel *model = [[GroupListDetailModel alloc] initWithDic:detailDic];
        [subData addObject:model];
    }
    self.sublist = subData;
}
@end


@implementation GroupListDetailModel
-(id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setProprrtyWithDic:dic];
    }
    return self;
}
-(void)setProprrtyWithDic:(NSDictionary *)dic{
    self.si_id = dic[@"si_id"];
    self.title = dic[@"title"];
    self.url = dic[@"url"];
    self.image = dic[@"image"];
    self.isattention = [dic[@"isattention"] integerValue] == 0 ? NO : YES;
}

@end
