//
//  PrizesInfoModel.h
//  ScienceChina
//
//  Created by xuanyj on 2016/12/23.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrizesInfoModel : NSObject
@property (nonatomic,strong) NSString *achieveScore;//达到积分/月
@property (nonatomic,strong) NSString *isGet;//本月是否领取过该奖品,0：领取过1;未领取过
@property (nonatomic,strong) NSString *member_type;//奖品对应的用户类型,0：科普员1：未认证科普员
@property (nonatomic,strong) NSString *prizeName;//奖品名称
@property (nonatomic,strong) NSString *prize_id;//奖品ID
@property (nonatomic,strong) NSString *father_prize_id;
@property (nonatomic,strong) NSMutableArray *list;

@property (nonatomic,assign) BOOL isReceived;//本月是否领取过该奖品,0：领取过1;未领取过
@end
