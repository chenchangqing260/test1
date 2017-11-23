//
//  ResponseModel.m
//  passbook
//
//  Created by Ellison on 16/2/25.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "ResponseModel.h"
#import "HomeModel.h"
#import "InfoCategory.h"
#import "Comment.h"
#import "EStationCategory.h"
#import "EStation.h"
#import "EStationRank.h"
#import "Question.h"
#import "QuestionCategory.h"
#import "ReplyQuestion.h"
#import "ChannelModel.h"
#import "ScoreModel.h"
#import "PrizesInfoModel.h"
#import "OneYearIntegralModel.h"
#import "OneMonthIntegralModel.h"
#import "ChannelListModel.h"
#import "OrganizationTypeListModel.h"
#import "OrgYun.h"
#import "SciencerTypes.h"
#import "SciencerCompany.h"
#import "SummaryData.h"
#import "SummaryDetail.h"
#import "ScienceActivity.h"
#import "Area.h"

@implementation ResponseModel

- (Class)classInArrayForKey:(NSString *)key
{
    // 首页普通资讯列表 or 微信公众号资讯列表
    if ([key isEqualToString:@"list"]|| [key isEqualToString:@"activityList"] ) {
        return [HomeModel class];
    }
    if ([key isEqualToString:@"infoRrecList"]) {
        //首页轮播图资讯列表
        return [HomeModel class];
    }
    // 分类资讯列表
    if ([key isEqualToString:@"informationTypeList"]) {
        return [InfoCategory class];
    }
    
    // 二级资讯分类列表
    if ([key isEqualToString:@"pullDowninforTypeList"]) {
        return [InfoCategory class];
    }
    
    if ([key isEqualToString:@"recommendList"]) {
        return [InfoObj class];
    }
    
    if ([key isEqualToString:@"reviewList"]) {
        return [Comment class];
    }
    
    if ([key isEqualToString:@"atCollectList"]) {
        return [InfoCategory class];
    }
    
    if ([key isEqualToString:@"dailyRecommendList"]) {
        return [HomeModel class];
    }
    
    if ([key isEqualToString:@"browsingHistorytList"]) {
        return [HomeModel class];
    }
    
    if ([key isEqualToString:@"stationRankList"]) {
        return [EStationRank class];
    }
    
    if ([key isEqualToString:@"stationTypeList"]) {
        return [EStationCategory class];
    }
    
    if ([key isEqualToString:@"stationList"]) {
        return [EStation class];
    }
    
    if ([key isEqualToString:@"infomationList"]) {
        return [InfoObj class];
    }
    
    if ([key isEqualToString:@"recList"]) {
        return [RecList class];
    }
    
    if ([key isEqualToString:@"region_list"]) {
        return [Area class];
    }
    
    if ([key isEqualToString:@"questionsList"]) {
        return [Question class];
    }
    
    if ([key isEqualToString:@"searchList"]) {
        return [HomeModel class];
    }
    
    if ([key isEqualToString:@"specialInforMationList"]) {
        return [HomeModel class];
    }
    
    if ([key isEqualToString:@"territoryList"]) {
        return [QuestionCategory class];
    }
    
    if ([key isEqualToString:@"questionReplyList"]) {
        return [ReplyQuestion class];
    }
    if ([key isEqualToString:@"atCollectList"]) {
        //首页频道资讯列表
        return [HomeModel class];
    }
    if ([key isEqualToString:@"scoreLog"]) {
        //我的积分列表
        return [ScoreModel class];
    }
    //    if ([key isEqualToString:@"lineData"]) {
    //        //某年12个月的积分变化折线图数据
    //        return [OneYearIntegralModel class];
    //    }
    if ([key isEqualToString:@"pieData"]) {
        //某月积分分类饼图数据
        return [OneMonthIntegralModel class];
    }
    if ([key isEqualToString:@"prizes"]) {
        //领奖界面 奖品信息列表
        return [PrizesInfoModel class];
    }
    if ([key isEqualToString:@"prizesAnother"]) {
        //领奖界面 奖品信息列表
        return [PrizesInfoModel class];
    }
    if ([key isEqualToString:@"channelList"]) {
        //频道
        return [ChannelListModel class];
    }
    
    if ([key isEqualToString:@"organizationTypeList"]) {
        //基站分类
        return [OrganizationTypeListModel class];
    }
    
    if ([key isEqualToString:@"institutionList"]) {
        //机构用户列表
        return [OrgYun class];
    }
    
    if ([key isEqualToString:@"sciencerTypeList"]) {
        //机构用户列表
        return [SciencerTypes class];
    }
    
    if ([key isEqualToString:@"companyList"]) {
        //机构用户列表
        return [SciencerCompany class];
    }
    
    if ([key isEqualToString:@"sciencerStsList"] || [key isEqualToString:@"shareStsList"] ||
        [key isEqualToString:@"sciencer_sts"]|| [key isEqualToString:@"article_share_sts"]|| [key isEqualToString:@"org_share_sts"]) {
        //机构用户列表
        return [SummaryData class];
    }
    
    if ([key isEqualToString:@"stsDetailList"]) {
        //机构用户列表
        return [SummaryDetail class];
    }
    
    #pragma mark - 4期扩展
    if ([key isEqualToString:@"carousel_list"] || [key isEqualToString:@"recommend_list"] ||
        [key isEqualToString:@"activity_list"] || [key isEqualToString:@"special_activity_list"]) {
        //机构用户列表
        return [ScienceActivity class];
    }
    
    return NULL;
}

@end
