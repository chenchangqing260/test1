//
//  MyScoreModel.h
//  ScienceChina
//
//  Created by xuanyj on 2016/12/23.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyScoreModel : NSObject

@property (nonatomic,strong) NSString *currentMonthScore;//本月积分
@property (nonatomic,strong) NSString *fromScore;//当前等级的最小积分
@property (nonatomic,strong) NSString *toScore;//当前等级的最大积分
@property (nonatomic,strong) NSString *totalScore;//当前用户的总积分
@property (nonatomic,strong) NSString *dayScore;//每日总积分数
@property (nonatomic,strong) NSString *grade;//当前用户等级
@property (nonatomic,strong) NSString *gradeName;//当前用户等级
@end
