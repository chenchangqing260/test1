//
//  ResponseModel.h
//  passbook
//
//  Created by Ellison on 16/2/25.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BeanSupport.h"
#import "Member.h"
#import "InfoObj.h"
#import "ShareModel.h"
#import "EStation.h"
#import "RecList.h"
#import "Question.h"
#import "MyScoreModel.h"
#import "Score.h"
#import "Sciencer.h"
#import "version.h"

@interface ResponseModel : NSObject<BeanSupport>

@property (nonatomic,strong)NSString* token; // 七牛Token
@property (nonatomic,strong)NSString* img_url;// 用户URL
@property (nonatomic,strong)NSString* zone; // 验证码

@property (nonatomic,strong)Score *score;//登录接口中的积分信息
@property (nonatomic,strong)Member *member;
@property (nonatomic,assign)NSInteger count; // 新闻数量
@property (nonatomic,strong)InfoObj* information; // 图文、文字、视频详情
@property (nonatomic,strong)InfoObj* informationImgsInfo; // 图片详情

@property (nonatomic,strong)NSString* usePage; // 已经使用页数
@property (nonatomic,strong)NSMutableArray* informationTypeList; // 资讯分类列表
@property (nonatomic,strong)NSMutableArray* pullDowninforTypeList; // 二级资讯分类列表
@property (nonatomic,strong)NSMutableArray* recommendList; // 推荐资讯分类列表
@property (nonatomic,strong)NSMutableArray* reviewList; // 评论列表
@property (nonatomic,strong)NSMutableArray* atCollectList; // 定制的分类
@property (nonatomic,strong)NSMutableArray* dailyRecommendList; // 每日推荐数据
@property (nonatomic,strong)NSMutableArray* browsingHistorytList; // 浏览记录
@property (nonatomic,strong)ShareModel* shareModel;
@property (nonatomic,strong)NSMutableArray* stationRankList;// E站首页的分类
@property (nonatomic,strong)NSMutableArray* stationTypeList;// E站分类
@property (nonatomic,strong)NSMutableArray* stationList;// E站列表
@property (nonatomic,strong)NSMutableArray* searchList;// 搜索资讯列表
@property (nonatomic,strong)NSMutableArray* infomationList;// E站资讯列表
@property (nonatomic,strong)NSString* hotSearchList; // 热门搜索，用,分割
@property (nonatomic,strong)EStation* station;

// =======================首页==========================
@property (nonatomic,strong)NSMutableArray *infoRrecList;//轮播图数据
@property (nonatomic,strong)NSMutableArray *list;//首页普通资讯列表

//首页新增活动数据
@property (nonatomic,strong)NSMutableArray *activityList;//首页活动数据

// =======================首页-微信公众号列表，文章详情网页地址==========================
@property (nonatomic,strong)NSString *html;
// =======================Question对象===========================

@property (nonatomic,strong)NSMutableArray* recList;//提问轮播图
@property (nonatomic,strong)NSMutableArray* questionsList;//提问列表
@property (nonatomic,strong)Question* questions;//提问详情
@property (nonatomic,strong)NSMutableArray* territoryList; // 问题类型列表
@property (nonatomic,strong)NSMutableArray* questionReplyList; // 提问回复列表

// =======================专题============================
@property (nonatomic,strong)NSMutableArray* specialInforMationList;
@property (nonatomic,strong)NSString* specialRreImgs; // , 分割

// =======================频道============================
@property (nonatomic,strong)NSMutableArray* myChannelList;
@property (nonatomic,strong)NSMutableArray* allChannelList;


//=======================是否是科普员=================
@property (nonatomic,strong)NSString* m_questionCount; // 提问数量
@property (nonatomic,strong)NSString* m_reviewCount;   // 资讯评论数量
@property (nonatomic,strong)NSString* m_collectCount;  // 资讯收藏数量
@property (nonatomic,strong)NSString *is_sciencer;     //是否是科普员：0-是科普员、1-非科普员
@property (nonatomic, strong) NSString *is_org;        //(0-是基站用户、1-不是基站用户)

//=======================我的积分=================
@property (nonatomic,strong) NSString *currentMonthScore;
@property (nonatomic,strong) NSString *fromScore;
@property (nonatomic,strong) NSString *toScore;
@property (nonatomic,strong) NSString *totalScore;
@property (nonatomic,strong) NSString *dayScore;
@property (nonatomic,strong) NSString *grade;
@property (nonatomic,strong) NSString *gradeName;
@property (nonatomic,strong) NSMutableArray  *scoreLog;

//=======================本月积分=================
@property (nonatomic,strong) NSMutableArray* lineData;// 折线图
@property (nonatomic,strong) NSMutableArray* pieData;// 饼状图

//=======================领取奖励=================
@property (nonatomic,strong) NSMutableArray *prizes;//4非志愿者 奖品信息列表
@property (nonatomic,strong) NSMutableArray *prizesAnother;//志愿者 奖品信息列表
//@property (nonatomic,strong) NSString *currentMonthScore;//1本月积分
@property (nonatomic,strong) NSString *isKepu;//2科普员信息
@property (nonatomic,strong) NSString *info;//3科普员信息 "未认证用户"

//=======================我的基站=================
@property (strong, nonatomic) NSMutableArray *channelList;
@property (strong, nonatomic) NSMutableArray *organizationTypeList;
@property (nonatomic,strong) NSString *or_id;

//=======================机构====================
@property (strong, nonatomic)NSMutableArray* institutionList;//机构用户列表OrgYun

#pragma mark - 三期
@property (strong, nonatomic)NSMutableArray* sciencerTypeList; // 科普员类型
@property (strong, nonatomic)NSMutableArray* companyList;
@property (nonatomic,strong) Sciencer* sciencer;

@property (nonatomic,strong) NSString *sciencer_count;//科普员总数(头部总统计，非个人级科普员时返回此值)",
@property (nonatomic,strong) NSString *sciencer_total;//科普员统计数量(底部列表)",
@property (nonatomic,strong) NSString *share_rank;//分享统计排名(底部列表)",
@property (nonatomic,strong) NSString *article_share_count;//分享文章总数(头部总统计)",
@property (nonatomic,strong) NSString *share_total;//分享统计数量(底部列表)",
@property (nonatomic,strong) NSMutableArray* sciencerStsList;
@property (nonatomic,strong) NSString *sciencer_rank;//科普员排名(底部列表)",
@property (nonatomic,strong) NSMutableArray* shareStsList;
@property (nonatomic,strong) NSString *org_share_count;//分享基站总数(头部总统计)",
@property (nonatomic,strong) NSString *register_date;//科普员注册时间(头部总统计，只有个人级科普员时返回此值)",
@property (nonatomic,strong) NSMutableArray* sciencer_sts;
@property (nonatomic,strong) NSMutableArray* article_share_sts;
@property (nonatomic,strong) NSMutableArray* org_share_sts;


@property (nonatomic,strong) NSMutableArray* stsDetailList;


@property (strong,nonatomic) NSString *share_title;
@property (strong,nonatomic) NSString *share_image_url;
@property (strong,nonatomic) NSString *share_url;
@property (strong,nonatomic) NSString *share_desc;

#pragma mark - 4期扩展
@property (nonatomic,strong) NSMutableArray* carousel_list; // 首页轮播图
@property (nonatomic,strong) NSMutableArray* recommend_list; // 推荐的活动
@property (nonatomic,strong) NSMutableArray* activity_list; // 活动列表
@property (nonatomic,strong) NSMutableArray* special_activity_list;
@property (nonatomic,strong) NSString* av_url; // 活动详情URL", 针对问卷网(投票，问卷，活动，告示)
@property (nonatomic,strong)ShareModel* share_info;

@property (nonatomic,strong) NSString* edit_url;//编辑活动页面地址
@property (nonatomic,strong) HomeModel* specialarticle;//编辑活动页面地址
@property (nonatomic,strong) NSString* is_prompt;//是否弹出提示
@property (nonatomic,strong) version* version;//版本
@property (nonatomic,strong) NSString* image_url;//启动图片地址

@property (nonatomic,strong) NSMutableArray* region_list;//活动区域列表
@end
