//
//  FlowUtil.h
//  hxz
//
//  Created by Ellison Xu on 15/9/17.
//  Copyright (c) 2015年 sevenplus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareModel.h" 
#import "EStationCategoryViewController.h"
#import "EStation.h"
#import "EStationRank.h"
#import "Question.h"
#import "VolunteerApproveViewController.h"
#import "Sciencer.h"
#import "ScienceActivity.h"
#import "HomeModel.h"

@interface FlowUtil : NSObject

+ (void)startToMusicInfoDetailVCNav:(UINavigationController *)vc in_id:(NSString*)in_id completion:(void(^)())completion;

+ (void)startToSpecialDetailNewVCNav:(UINavigationController *)vc homeModel:(HomeModel*)homeModel completion:(void(^)())completion;

+ (void)startToSpecialInfoDetailVCNav:(UINavigationController *)vc homeModel:(HomeModel*)homeModel completion:(void(^)())completion;

+ (void)startToPicTextInfoDetailVCNav:(UINavigationController *)vc in_id:(NSString*)in_id completion:(void(^)())completion;

+ (void)startToPicDetailInfoDetailVCNav:(UINavigationController *)vc in_id:(NSString*)in_id completion:(void(^)())completion;

+ (void)startToVideoInfoDetailVCNav:(UINavigationController *)vc in_id:(NSString*)in_id completion:(void(^)())completion;

+ (void)startToCommentListVCNav:(UINavigationController *)vc in_id:(NSString*)in_id completion:(void(^)())completion;

+ (void)presentToLoginAndRegisterVCWithNav:(UIViewController *)vc toRegister:(BOOL)toRegister  isShowAlertYinDao:(BOOL)isShowAlertYinDao completion:(void(^)())completion;

+ (void)startToForgetPasswordVCNav:(UINavigationController *)vc completion:(void(^)())completion;

+ (void)startToChangePasswordVCNav:(UINavigationController *)vc completion:(void(^)())completion;

+ (void)startToSettingVCNav:(UINavigationController *)vc completion:(void(^)())completion;

+ (void)startToFeedBackVCNav:(UINavigationController *)vc completion:(void(^)())completion;

+ (void)startToAboutVCNav:(UINavigationController *)vc completion:(void(^)())completion;

+ (void)startToRecordVCNav:(UINavigationController *)vc completion:(void(^)())completion;

+ (void)startToShareToFriendVCNav:(UINavigationController *)vc completion:(void(^)())completion;

+ (void)startToAboutNewToFriendVCNav:(UINavigationController *)vc completion:(void(^)())completion;

+ (void)startToMemberInfoVCNav:(UINavigationController *)vc completion:(void(^)())completion;

+ (void)startToMyCommentInfoVCNav:(UINavigationController *)vc completion:(void(^)())completion;

+ (void)startToMyCollectInfoVCNav:(UINavigationController *)vc completion:(void(^)())completion;

/*本月积分*/
+ (void)startToMonthIntegralVCNav:(UINavigationController *)vc completion:(void(^)())completion;
/*积分汇总*/
+ (void)startToIntegrationSummaryVCNav:(UINavigationController *)vc completion:(void(^)())completion;
/*我的基站*/
+ (void)startToMyBaseStationVCNav:(UINavigationController *)vc completion:(void(^)())completion;
/*获取奖励*/
+ (void)startToGetRewardsVCNav:(UINavigationController *)vc completion:(void(^)())completion;

+ (void)presentToHomeShareWithNav:(UIViewController *)vc shareModel:(ShareModel*)shareModel completion:(void(^)())completion;

+ (void)startToEStationListVCNav:(UINavigationController *)vc;

+ (void)startToEStationCategoryVCNav:(UINavigationController *)vc;

+ (void)startToEStationTypeVCNav:(UINavigationController *)vc navTitle:(NSString*)title type:(NSString*)type;

+(void)startToSummaryPersonDetailVCNav:(UINavigationController *)vc withSciencer:(NSString*)town_code  Region_name:(NSString*)Region_name ;

+ (void)startToEStationPersonalVCNav:(UINavigationController *)vc si_id:(NSString*)si_id;

+ (void)startToEStationRankVCNav:(UINavigationController *)vc rank:(EStationRank*)rank;

+ (void)startToEStationSearchVCNav:(UINavigationController *)vc;

+ (void)startToQuestionHomeVCNav:(UINavigationController *)vc;

+ (void)startToAskQuestionVCNav:(UINavigationController *)vc;

+ (void)startToMyQuestionVCNav:(UINavigationController *)vc;

+ (void)startToMyAnswerVCNav:(UINavigationController *)vc;

+ (void)startToQuesDetailVCNav:(UINavigationController *)vc question:(Question*)question;

+ (void)startToMainSearchVCNav:(UINavigationController *)vc;

+ (void)startToDownloadVideoVCNav:(UINavigationController *)vc;

+ (void)startToTopicListVCNav:(UINavigationController *)vc at_id:(NSString*)at_id;

+ (void)startToTopicSubListVCNav:(UINavigationController *)vc in_id:(NSString*)in_id;

+ (void)startToVolunteerApproveVCNav:(UINavigationController *)vc;

+ (void)startToAddChannelVCNav:(UINavigationController *)vc withHadSelectedArr:(NSMutableArray *)hadSelectArr andAllChannel:(NSMutableArray *)allChannel;

+ (void)startEstationCertificationVCNav:(UINavigationController *)vc;

+(void)startToEStationPersonalVCNav:(UINavigationController *)vc si_id:(NSString*)si_id isShowEditBtn:(NSString *)isshow;

+(void)startToSummaryVCNav:(UINavigationController *)vc withSciencer:(Sciencer*)sciencer;

+(void)startToSummaryDetailVCNav:(UINavigationController *)vc withSciencer:(Sciencer*)sciencer;

+(void)startToChuanboDetailVCNav:(UINavigationController *)vc withSciencer:(Sciencer*)sciencer sectionTitle:(NSString*)sectionTitle;

+(void)startToRegisterDetailVCNav:(UINavigationController *)vc withSciencer:(Sciencer*)sciencer sectionTitle:(NSString*)sectionTitle;

#pragma mark - 4期科普改版
+(void)startToInteractionAndLocalActivityVCNav:(UINavigationController *)vc;

+(void)startToFourActivityLatestAndHotVCNav:(UINavigationController *)vc withIsHot:(BOOL)isHot;

+(void)startToFourActivityNewSpecialVCNav:(UINavigationController *)vc;

+(void)startToFourActivitySpecialVCNav:(UINavigationController *)vc;

+(void)startToFourActivitySpecialDetailListVCNav:(UINavigationController *)vc WithSpsa:(ScienceActivity*)spsa;

@end