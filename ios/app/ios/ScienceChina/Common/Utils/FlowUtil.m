//
//  FlowUtil.m
//  hxz
//
//  Created by Ellison Xu on 15/9/17.
//  Copyright (c) 2015年 sevenplus. All rights reserved.
//

#import "FlowUtil.h"
#import "PicTextInfoDetailViewController.h"
#import "VideoInfoDetailViewController.h"
#import "VideoDetailViewController.h"
#import "CommentListViewController.h"
#import "PicturesDetailViewController.h"
#import "LoginAndRegisterViewController.h"
#import "ForgetPasswordViewController.h"
#import "ChangePasswordViewController.h"
#import "FeedBackViewController.h"
#import "SettingViewController.h"
#import "AboutViewController.h"
#import "RecordViewController.h"
#import "ShareToFriendViewController.h"
#import "MemberInfoViewController.h"
#import "MyCommentViewController.h"
#import "MyCollectViewController.h"
#import "MonthIntegralViewController.h"
#import "IntegrationSummaryViewController.h"
#import "MyBaseStationViewController.h"
#import "GetRewardsViewController.h"
#import "HomeShareViewController.h"
#import "EStationListViewController.h"
#import "EStationTypeViewController.h"
#import "EStationPeronalViewController.h"
#import "EStationRankViewController.h"
#import "EStationSearchViewController.h"
#import "QuesMainViewController.h"
#import "MainSearchViewController.h"
#import "DownloadVideoViewController.h"
#import "TopicListViewController.h"
#import "TopicSubjectListViewController.h"
#import "AskQuesViewController.h"
#import "MyQuesViewController.h"
#import "MyAnswerViewController.h"
#import "QuesDetailViewController.h"
#import "AppDelegate.h"
#import "AddChannelViewController.h"
#import "EStationCertificationViewController.h"
#import "EStationPeronalViewController.h"
#import "ChooseCompanyViewController.h"
#import "SummaryViewController.h"
#import "SummaryDetailViewController.h"
#import "ChuanBoListViewController.h"
#import "RegisterListViewController.h"
#import "LatestActivityViewController.h"
#import "SpecialActivityViewController.h"
#import "SpecialDetailListActivityViewController.h"
#import "ScienceActivity.h"
#import "SpecialInfoViewController.h"
#import "AboutNewViewController.h"
#import "SpecialActivityNewViewController.h"
#import "SummaryPersonDetailViewController.h"
#import "InteractionAndLocalActivityViewController.h"
#import "SpecialDetailsNewViewController.h"
#import "EStationCategoryViewController.h"
#import "VolunteerApproveViewController.h"
#import "MusicDetialViewController.h"

@implementation FlowUtil


+ (void)startToSpecialDetailNewVCNav:(UINavigationController *)vc homeModel:(HomeModel*)homeModel completion:(void(^)())completion{
    SpecialDetailsNewViewController* specialInfoDetailVC = [SpecialDetailsNewViewController new];
    specialInfoDetailVC.hm = homeModel;
    [vc pushViewController:specialInfoDetailVC animated:YES];
}

+ (void)startToSpecialInfoDetailVCNav:(UINavigationController *)vc homeModel:(HomeModel*)homeModel completion:(void(^)())completion{
    SpecialInfoViewController* specialInfoDetailVC = [SpecialInfoViewController new];
    specialInfoDetailVC.hm = homeModel;
    [vc pushViewController:specialInfoDetailVC animated:YES];
}

+ (void)startToPicTextInfoDetailVCNav:(UINavigationController *)vc in_id:(NSString*)in_id completion:(void(^)())completion{
    PicTextInfoDetailViewController* picTextInfoDetailVC = [PicTextInfoDetailViewController new];
    picTextInfoDetailVC.in_id = in_id;
    [vc pushViewController:picTextInfoDetailVC animated:YES];
}

+ (void)startToMusicInfoDetailVCNav:(UINavigationController *)vc in_id:(NSString*)in_id completion:(void(^)())completion{
    MusicDetialViewController* musicInfoDetailVC = [MusicDetialViewController new];
    musicInfoDetailVC.in_id = in_id;
    [vc pushViewController:musicInfoDetailVC animated:YES];
}

+ (void)startToPicDetailInfoDetailVCNav:(UINavigationController *)vc in_id:(NSString*)in_id completion:(void(^)())completion{
    PicturesDetailViewController* picTextInfoDetailVC = [PicturesDetailViewController new];
    picTextInfoDetailVC.in_id = in_id;
    [vc pushViewController:picTextInfoDetailVC animated:YES];
}

+(void)startToSummaryPersonDetailVCNav:(UINavigationController *)vc withSciencer:(NSString*)town_code  Region_name:(NSString*)Region_name {
    SummaryPersonDetailViewController* sdVC = [SummaryPersonDetailViewController new];
    sdVC.town_code = town_code;
    sdVC.Region_name = Region_name;
    [vc pushViewController:sdVC animated:YES];
}


+ (void)startToVideoInfoDetailVCNav:(UINavigationController *)vc in_id:(NSString*)in_id completion:(void(^)())completion{
    // 根据视频不同的模式，显示不同的界面
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSString* videoShow = [settings objectForKey:kUserDefaultKeyVideoShow];
    if (videoShow && [videoShow isEqualToString:@"YES"]) {
        VideoDetailViewController* videoDetailVC = [VideoDetailViewController new];
        videoDetailVC.in_id = in_id;
        [vc pushViewController:videoDetailVC animated:YES];
    }else{
        VideoInfoDetailViewController* voideInfoVC = [VideoInfoDetailViewController new];
        voideInfoVC.in_id = in_id;
        [vc pushViewController:voideInfoVC animated:YES];
    }
}

+ (void)startToCommentListVCNav:(UINavigationController *)vc in_id:(NSString*)in_id completion:(void(^)())completion{
    CommentListViewController* commentList = [CommentListViewController new];
    commentList.in_id = in_id;
    [vc pushViewController:commentList animated:YES];
}

+ (void)presentToLoginAndRegisterVCWithNav:(UIViewController *)vc toRegister:(BOOL)toRegister isShowAlertYinDao:(BOOL)isShowAlertYinDao completion:(void(^)())completion;{
    LoginAndRegisterViewController* lrVC = [LoginAndRegisterViewController new];
    lrVC.toRegister = toRegister;
    lrVC.isShowAlertYinDao = isShowAlertYinDao;
    JTNavigationController *navigationController = [[JTNavigationController alloc] initWithRootViewController:lrVC];
    navigationController.modalPresentationStyle = UIModalPresentationCustom;
    [vc presentViewController:navigationController animated:YES
                   completion:nil];
}

+ (void)startToForgetPasswordVCNav:(UINavigationController *)vc completion:(void(^)())completion{
    ForgetPasswordViewController* forgetPwdVC = [ForgetPasswordViewController new];
    [vc pushViewController:forgetPwdVC animated:YES];
}

+ (void)startToChangePasswordVCNav:(UINavigationController *)vc completion:(void(^)())completion{
    ChangePasswordViewController* changePwdVC = [ChangePasswordViewController new];
    [vc pushViewController:changePwdVC animated:YES];
}

+ (void)startToSettingVCNav:(UINavigationController *)vc completion:(void(^)())completion{
    SettingViewController* vc1 = [SettingViewController new];
    [vc pushViewController:vc1 animated:YES];
}

+ (void)startToFeedBackVCNav:(UINavigationController *)vc completion:(void(^)())completion{
    FeedBackViewController* vc1 = [FeedBackViewController new];
    [vc pushViewController:vc1 animated:YES];
    
}

+ (void)startToAboutVCNav:(UINavigationController *)vc completion:(void(^)())completion{
    AboutViewController* aboutVC = [AboutViewController new];
    [vc pushViewController:aboutVC animated:YES];
}

+ (void)startToRecordVCNav:(UINavigationController *)vc completion:(void(^)())completion{
    RecordViewController* aboutVC = [RecordViewController new];
    [vc pushViewController:aboutVC animated:YES];
}

+ (void)startToAboutToFriendVCNav:(UINavigationController *)vc completion:(void(^)())completion{
    ShareToFriendViewController* sfVC = [ShareToFriendViewController new];
    [vc pushViewController:sfVC animated:YES];
}

+ (void)startToShareToFriendVCNav:(UINavigationController *)vc completion:(void(^)())completion{
    ShareToFriendViewController* sfVC = [ShareToFriendViewController new];
    [vc pushViewController:sfVC animated:YES];
}

+ (void)startToAboutNewToFriendVCNav:(UINavigationController *)vc completion:(void(^)())completion{
    AboutNewViewController* sfVC = [AboutNewViewController new];
    [vc pushViewController:sfVC animated:YES];
}

+ (void)startToMemberInfoVCNav:(UINavigationController *)vc completion:(void(^)())completion{
    MemberInfoViewController* memberVC = [MemberInfoViewController new];
    [vc pushViewController:memberVC animated:YES];
}

+ (void)startToMyCommentInfoVCNav:(UINavigationController *)vc completion:(void(^)())completion{
    MyCommentViewController* myVC = [MyCommentViewController new];
    [vc pushViewController:myVC animated:YES];
}

+ (void)startToMyCollectInfoVCNav:(UINavigationController *)vc completion:(void(^)())completion{
    MyCollectViewController* myVC = [MyCollectViewController new];
    [vc pushViewController:myVC animated:YES];
}

//本月积分
+ (void)startToMonthIntegralVCNav:(UINavigationController *)vc completion:(void(^)())completion{
    MonthIntegralViewController* myVC = [MonthIntegralViewController new];
    [vc pushViewController:myVC animated:YES];
}
//积分汇总
+ (void)startToIntegrationSummaryVCNav:(UINavigationController *)vc completion:(void(^)())completion{
    IntegrationSummaryViewController* myVC = [IntegrationSummaryViewController new];
    [vc pushViewController:myVC animated:YES];
}
//我的基站
+ (void)startToMyBaseStationVCNav:(UINavigationController *)vc completion:(void(^)())completion{
    MyBaseStationViewController* myVC = [MyBaseStationViewController new];
    [vc pushViewController:myVC animated:YES];
}
//获取奖励
+ (void)startToGetRewardsVCNav:(UINavigationController *)vc completion:(void(^)())completion{
    GetRewardsViewController* myVC = [GetRewardsViewController new];
    [vc pushViewController:myVC animated:YES];
}
+ (void)presentToHomeShareWithNav:(UIViewController *)vc shareModel:(ShareModel*)shareModel completion:(void(^)())completion{
    HomeShareViewController* homeShare = [HomeShareViewController new];
    homeShare.shareModel = shareModel;
    JTNavigationController *navigationController = [[JTNavigationController alloc] initWithRootViewController:homeShare];
    navigationController.modalPresentationStyle = UIModalPresentationCustom;
    [vc presentViewController:navigationController animated:YES
                   completion:completion];
}

+ (void)startToEStationListVCNav:(UINavigationController *)vc{
    EStationListViewController* eStationListVC = [EStationListViewController new];
    [vc pushViewController:eStationListVC animated:YES];
}

+ (void)startToEStationCategoryVCNav:(UINavigationController *)vc{
    EStationCategoryViewController* eStationListVC = [EStationCategoryViewController new];
    [vc pushViewController:eStationListVC animated:YES];
}

+ (void)startToEStationTypeVCNav:(UINavigationController *)vc navTitle:(NSString*)title type:(NSString*)type{
    EStationTypeViewController* stationTypeVC = [EStationTypeViewController new];
    stationTypeVC.navTitlle = title;
    stationTypeVC.type = type;
    [vc pushViewController:stationTypeVC animated:YES];
}

+(void)startToEStationPersonalVCNav:(UINavigationController *)vc si_id:(NSString*)si_id{
    EStationPeronalViewController* epVC = [EStationPeronalViewController new];
    epVC.si_id = si_id;
    [vc pushViewController:epVC animated:YES];
}

+ (void)startToEStationRankVCNav:(UINavigationController *)vc rank:(EStationRank*)rank{
    EStationRankViewController* erVC = [EStationRankViewController new];
    erVC.rank = rank;
    [vc pushViewController:erVC animated:YES];
}

+ (void)startToEStationSearchVCNav:(UINavigationController *)vc{
    EStationSearchViewController* estationSearchVC = [EStationSearchViewController new];
    [vc pushViewController:estationSearchVC animated:YES];
}

+ (void)startToQuestionHomeVCNav:(UINavigationController *)vc{
    QuesMainViewController* questionHomeVC = [QuesMainViewController new];
    [vc pushViewController:questionHomeVC animated:YES];
}

+ (void)startToAskQuestionVCNav:(UINavigationController *)vc{
    AskQuesViewController* askQuesVC = [AskQuesViewController new];
    [vc pushViewController:askQuesVC animated:YES];
}

+ (void)startToMyQuestionVCNav:(UINavigationController *)vc{
    MyQuesViewController* myQuesVC = [MyQuesViewController new];
    [vc pushViewController:myQuesVC animated:YES];
}
+ (void)startToMyAnswerVCNav:(UINavigationController *)vc{
    MyAnswerViewController* myAnVC = [MyAnswerViewController new];
    [vc pushViewController:myAnVC animated:YES];
}


+ (void)startToQuesDetailVCNav:(UINavigationController *)vc question:(Question*)question{
    QuesDetailViewController* quesDetailVC = [QuesDetailViewController new];
    quesDetailVC.question = question;
    [vc pushViewController:quesDetailVC animated:YES];
}


+ (void)startToMainSearchVCNav:(UINavigationController *)vc{
    MainSearchViewController* mainSearchVC = [MainSearchViewController new];
//    mainSearchVC.hidesBottomBarWhenPushed = YES;
    //[vc pushViewController:mainSearchVC animated:YES];
    //[vc presentViewController:mainSearchVC animated:YES completion:^{}];
//    UINavigationController *menuController = (UINavigationController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
//    [menuController pushViewController:mainSearchVC animated:YES];
    
    [vc pushViewController:mainSearchVC animated:YES];
    
}

+ (void)startToDownloadVideoVCNav:(UINavigationController *)vc{
    DownloadVideoViewController* downloadVideoVC = [DownloadVideoViewController new];
    [vc pushViewController:downloadVideoVC animated:YES];
}

+ (void)startToTopicListVCNav:(UINavigationController *)vc at_id:(NSString*)at_id{
    TopicListViewController *topicListVC = [TopicListViewController new];
    topicListVC.at_id = at_id;
    [vc pushViewController:topicListVC animated:YES];
}

+ (void)startToTopicSubListVCNav:(UINavigationController *)vc in_id:(NSString*)in_id{
    TopicSubjectListViewController *topicSubListVC = [TopicSubjectListViewController new];
    topicSubListVC.in_id = in_id;
    [vc pushViewController:topicSubListVC animated:YES];
}

+ (void)startToVolunteerApproveVCNav:(UINavigationController *)vc
{
    VolunteerApproveViewController *VolunteerApproveVC = [VolunteerApproveViewController new];
    [vc pushViewController:VolunteerApproveVC animated:YES];
}
+ (void)startToAddChannelVCNav:(UINavigationController *)vc withHadSelectedArr:(NSMutableArray *)hadSelectArr andAllChannel:(NSMutableArray *)allChannel
{
    AddChannelViewController *addChannelVC = [[AddChannelViewController alloc]initWithNibName:nil bundle:nil];
    addChannelVC.HadSelectChannel = hadSelectArr;
    addChannelVC.AllChannel = allChannel;
    [vc pushViewController:addChannelVC animated:1];
}
+ (void)startEstationCertificationVCNav:(UINavigationController *)vc
{
    EStationCertificationViewController *EStationCertificationVC = [[EStationCertificationViewController alloc]initWithNibName:nil bundle:nil];
    [vc pushViewController:EStationCertificationVC animated:1];
}

+(void)startToEStationPersonalVCNav:(UINavigationController *)vc si_id:(NSString*)si_id isShowEditBtn:(NSString *)isshow{
    EStationPeronalViewController* epVC = [EStationPeronalViewController new];
    epVC.si_id = si_id;
    epVC.isShowEditBtn = isshow;
    [vc pushViewController:epVC animated:YES];
}

#pragma mark - 三期跳转
+(void)startToSummaryVCNav:(UINavigationController *)vc withSciencer:(Sciencer*)sciencer{
    SummaryViewController* summaryVC = [SummaryViewController new];
    summaryVC.sciencer = sciencer;
    [vc pushViewController:summaryVC animated:YES];
}

+(void)startToSummaryDetailVCNav:(UINavigationController *)vc withSciencer:(Sciencer*)sciencer{
    SummaryDetailViewController* sdVC = [SummaryDetailViewController new];
    sdVC.sciencer = sciencer;
    [vc pushViewController:sdVC animated:YES];
}

+(void)startToChuanboDetailVCNav:(UINavigationController *)vc withSciencer:(Sciencer*)sciencer sectionTitle:(NSString*)sectionTitle{
    ChuanBoListViewController* sdVC = [ChuanBoListViewController new];
    sdVC.sciencer = sciencer;
    sdVC.sectionTitle = sectionTitle;
    [vc pushViewController:sdVC animated:YES];
}

+(void)startToRegisterDetailVCNav:(UINavigationController *)vc withSciencer:(Sciencer*)sciencer sectionTitle:(NSString*)sectionTitle{
    RegisterListViewController* sdVC = [RegisterListViewController new];
    sdVC.sciencer = sciencer;
    sdVC.sectionTitle = sectionTitle;
    [vc pushViewController:sdVC animated:YES];
}

#pragma mark - 4期科普改版
+(void)startToInteractionAndLocalActivityVCNav:(UINavigationController *)vc{
    InteractionAndLocalActivityViewController * laVC = [InteractionAndLocalActivityViewController new];
    [vc pushViewController:laVC animated:YES];
}

+(void)startToFourActivityLatestAndHotVCNav:(UINavigationController *)vc withIsHot:(BOOL)isHot{
    LatestActivityViewController* laVC = [LatestActivityViewController new];
    laVC.isHot = isHot;
    [vc pushViewController:laVC animated:YES];
}

+(void)startToFourActivityNewSpecialVCNav:(UINavigationController *)vc{
    SpecialActivityNewViewController* saVC = [SpecialActivityNewViewController new];
    [vc pushViewController:saVC animated:YES];
}

+(void)startToFourActivitySpecialVCNav:(UINavigationController *)vc{
    SpecialActivityViewController* saVC = [SpecialActivityViewController new];
    [vc pushViewController:saVC animated:YES];
}

+(void)startToFourActivitySpecialDetailListVCNav:(UINavigationController *)vc WithSpsa:(ScienceActivity*)spsa{
    SpecialDetailListActivityViewController* sdlaVC = [SpecialDetailListActivityViewController new];
    sdlaVC.spsa = spsa;
    [vc pushViewController:sdlaVC animated:YES];
}

@end
