//
//  WebAccessManager.h
//  hxz
//
//  Created by Ellison Xu on 15/9/17.
//  Copyright (c) 2015年 sevenplus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseHeader.h"
#import "RestClient.h"
#import "CommonTypes.h"

typedef void(^WebAccessCompletionBlock)(WebResponse *response, NSError *error);

@interface WebAccessManager : NSObject

@property (nonatomic, strong) RestClient *restClient;
+ (instancetype)sharedInstance;

- (NSString *)webServiceUrl;

- (NSString *)ActivityServiceUrl;

- (NSString *)webWithOutServiceUrl;

#pragma mark - 用户相关
// 获取验证码0-注册，1-找回密码
- (void)getVerifyCodeWithTelephone:(NSString*)telephone type:(NSString*)type completion:(void (^)(WebResponse*, NSError *))completion;

- (void)getVerifyCodeNewWithTelephone:(NSString*)telephone  type:(NSString*)type completion:(void (^)(WebResponse*, NSError *))completion;

// 登录
- (void)loginWithTelephone:(NSString *)telephone password:(NSString *)password completion:(void (^)(WebResponse*, NSError *))completion;

// 第三方登录 0-QQ、1-微信、2-微博
- (void)loginWithThirdPartyWithChannel:(NSString*)channel authcode:(NSString*)authcode memberName:(NSString*)memberName imageURL:(NSString*)imageURL completion:(void (^)(WebResponse*, NSError *))completion;

// 注册
-(void)registerWithTelephone:(NSString *)telephone password:(NSString *)password code:(NSString*)code completion:(void (^)(WebResponse *, NSError *))completion;

// 忘记密码
- (void)forgetPasswordWithTelephone:(NSString *)telephone pwd:(NSString *)pwd code:(NSString*)code completion:(void (^)(WebResponse*, NSError *))completion;

// 修改密码
- (void)changePasswordWithMemberID:(NSString *)MemberID oldPwd:(NSString *)oldPwd newPaw:(NSString *)newPwd completion:(void (^)(WebResponse*, NSError *))completion;

// 获得分享APP
- (void)getAppShareModelWithCompletion:(void (^)(WebResponse*, NSError *))completion;


// 意见反馈
- (void)feedBackWithMemberID:(NSString *)MemberID content:(NSString *)content completion:(void (^)(WebResponse*, NSError *))completion;

// 修改会员头像
-(void)changeIconWithMemberID:(NSString *)MemberID picName:(NSString *)picName completion:(void (^)(WebResponse*, NSError *))completion;

// 修改个人信息（如昵称等）
-(void)changeInformationWithMemberID:(NSString *)MemberID memberName:(NSString*)member_name completion:(void (^)(WebResponse*, NSError *))completion;

// 获取七牛token
-(void)getQiniuTokenCompletion:(void(^)(WebResponse *response, NSError *error))completion;

//获取启动图片地址
-(void)getLatestLauncher:(void(^)(WebResponse *response, NSError *error))completion;

#pragma mark - 版本
-(void)getLatestVersion:(void(^)(WebResponse *response, NSError *error))completion;

-(void)getNewLatestVersion:(void(^)(WebResponse *response, NSError *error))completion;

-(void)saveVersionLog:(void(^)(WebResponse *response, NSError *error))completion;

#pragma mark - 资讯
// 获取首页资讯列表
-(void)getHomeInfoListWithPage:(NSInteger)page usePage:(NSString*)usePage completion:(void(^)(WebResponse *response, NSError *error))completion;

//  每日推荐三个数据
-(void)getDailyInfoListWithCompletion:(void(^)(WebResponse *response, NSError *error))completion;

// 根据分类ID查询数据
-(void)getInfoListByCategoryId:(NSString*)at_id page:(NSInteger)page showSlide:(NSString *)showSlide completion:(void(^)(WebResponse *response, NSError *error))completion;


// 根据分类ID查询数据
-(void)getNewInfoListByCategoryId:(NSString*)at_id page:(NSInteger)page showSlide:(NSString *)showSlide  rows:(long)rows  completion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取微信公众号频道下资讯列表
-(void)getWeiChatPublicNOListWithPage:(NSInteger)page Completion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取微信公众号频道下资讯详情
-(void)getWeiChatPublicNODetailWithId:(NSString *)articleId Completion:(void(^)(WebResponse *response, NSError *error))completion;

// 定制分类
-(void)collectCategoryWithAtId:(NSString*)at_id completion:(void(^)(WebResponse *response, NSError *error))completion;

// 删除登录分类
-(void)delCollectCategoryWithAtId:(NSString*)at_id completion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取分类收藏列表
-(void)getCollectCategoryListWithcompletion:(void(^)(WebResponse *response, NSError *error))completion;


// 获取分类列表
-(void)getInfoCategoryWithCompletion:(void(^)(WebResponse *response, NSError *error))completion;

// 根据大分类获取子分类
-(void)getSubCategoryWithAtId:(NSString*)at_id completion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取图文、视频资讯详情
-(void)getPicTextAndVideoInfoDetailWithIn_id:(NSString*)in_id showRows:(BOOL)showRows completion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取更多推荐视频资讯
-(void)getVideoForRecWithInId:(NSString*)in_id page:(NSInteger)page completion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取图文资讯的HTML
-(void)loadHtmlOfPicTextWithIn_id:(NSString*)in_id font_size:(FontSize)fontSize completion:(void (^)(NSString *, NSError *))completion;

// 获取视频资讯的HTML
-(void)loadHtmlOfVideoWithIn_id:(NSString*)in_id font_size:(FontSize)fontSize completion:(void (^)(NSString *, NSError *))completion;

// 获取图集资讯详情
-(void)getPicInfoDetailWithIn_id:(NSString*)in_id completion:(void (^)(WebResponse *, NSError *))completion;

// 获取我的评论列表
-(void)getMyCommentListPage:(NSInteger)page completion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取新闻评论列表
-(void)getCommentListWithIn_id:(NSString*)in_id page:(NSInteger)page completion:(void(^)(WebResponse *response, NSError *error))completion;

// 保存或者回复评论
-(void)saveAndReplyCommentWithIn_id:(NSString*)in_id commentContent:(NSString*)commentContent parentCommentId:(NSString*)r_id completion:(void(^)(WebResponse *response, NSError *error))completion;

// 资讯点赞
-(void)saveWithR_id:(NSString*)r_id completion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取评论，收藏，提问数量
-(void)getQuantityStatisticsWithcompletion:(void(^)(WebResponse *response, NSError *error))completion;

// 收藏
-(void)saveCollectInfo:(NSString*)info_id completion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取收藏列表
-(void)getCollectInfoListWithPage:(NSInteger)page completion:(void(^)(WebResponse *response, NSError *error))completion;

// 取消成功
-(void)removeCollectInfo:(NSString*)info_id completion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取浏览记录
-(void)getSeeRecordWithPage:(NSInteger)page completion:(void(^)(WebResponse *response, NSError *error))completion;

// 清空浏览记录
-(void)cleanSeeRecordWithompletion:(void(^)(WebResponse *response, NSError *error))completion;

#pragma mark - 专题
// 获取专题子列表
-(void)getTopicSubListWithInId:(NSString*)in_id page:(NSInteger)page completion:(void(^)(WebResponse *response, NSError *error))completion;

#pragma mark - E站
// 根据ID获取E站详情
-(void)getEStationById:(NSString*) si_id Completion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取E站分类轮播图
-(void)getEStationOfRecommendListWtihCompletion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取E站列表
-(void)getEStationListWtihPage:(NSInteger)page Completion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取最热，最有趣等EStation列表
-(void)getEStationListOfType:(NSString*)type Page:(NSInteger)page Completion:(void(^)(WebResponse *response, NSError *error))completion;

// 取消关注E站
-(void)delStationWithSiId:(NSString*)si_id  Completion:(void(^)(WebResponse *response, NSError *error))completion;

// 关注E站
-(void)saveStationWithSiId:(NSString*)si_id  Completion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取我关注的E站
-(void)getMyAttentionStationListPage:(NSInteger)page Completion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取E站分类列表
-(void)getEStationCategoryWithCompletion:(void(^)(WebResponse *response, NSError *error))completion;

// 根据分类ID获取E站列表
-(void)getStationByStId:(NSString*)st_id page:(NSInteger)page Completion:(void(^)(WebResponse *response, NSError *error))completion;

// 根据分类ID获取E站排行列表
-(void)getStationRankByStId:(NSString*)st_id page:(NSInteger)page Completion:(void(^)(WebResponse *response, NSError *error))completion;

// 根据分类ID获取E站列表
-(void)getStationInfoBySiId:(NSString*)si_id page:(NSInteger)page Completion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取基站热门搜索
-(void)getHotSearchForStationWithCompletion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取资讯热门搜索
-(void)getHotSearchForInfoWithCompletion:(void(^)(WebResponse *response, NSError *error))completion;

// 根据关键字搜索资讯
-(void)searchInfoByKeywork:(NSString*)query_content page:(NSInteger)page Completion:(void(^)(WebResponse *response, NSError *error))completion;

// 根据分类ID获取E站列表
-(void)searchStationInfoBykeyWork:(NSString*)query_content page:(NSInteger)page Completion:(void(^)(WebResponse *response, NSError *error))completion;

#pragma mark - 提问

// 获取提问轮播图
-(void)getQuestionBannerWtihCompletion:(void(^)(WebResponse *response, NSError *error))completion;

//获取提问列表
-(void)getQuestionListWtihTypeid:(NSString *)te_id page:(NSInteger)page memberId:(NSString*)memberId Completion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取提问详情
-(void)getQuestionInfoWithqu_id:(NSString *)qu_id andCompletion:(void(^)(WebResponse *response, NSError *error))completion;

// 保存提问
-(void)saveQuestionsWithQu_title:(NSString*)qu_title qu_content:(NSString*)qu_content qu_img:(NSString*)qu_img te_id:(NSString*)te_id completion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取提问分类列表
-(void)getQuesCategoryListWithcompletion:(void(^)(WebResponse *response, NSError *error))completion;

// 保存问题回复
-(void)saveQuestionsReplyWithQuId:(NSString*)qu_id qr_content:(NSString*)qr_content completion:(void(^)(WebResponse *response, NSError *error))completion;

// 点赞
-(void)addQuestionsReplyPraiseCountWithqr_id:(NSString*)qr_id completion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取提问回复列表
-(void)getQuestionReplyListWithQuId:(NSString*)qu_id memberId:(NSString*)memberId  page:(NSInteger)page completion:(void(^)(WebResponse *response, NSError *error))completion;
#define 频道相关
//根据登录信息获取用户的频道信息，若用户未登录则获取系统默认频道，包括频道基本信息
-(void)getMyCategoryWithcompletion:(void(^)(WebResponse *response, NSError *error))completion;

//获取所有的频道信息
-(void)getAllChannelListWithcompletion:(void(^)(WebResponse *response, NSError *error))completion;

//删除一个我的频道
-(void)delAtCollectWithChannelId:(NSString *)at_id completion:(void(^)(WebResponse *response, NSError *error))completion;

//添加一个我的频道
-(void)saveAtCollectWithChannelId:(NSString *)at_id completion:(void(^)(WebResponse *response, NSError *error))completion;

//保存我的所有频道  atids 是频道at_id的数组
-(void)resetAtCollectNoWithChannelIdS:(NSArray *)atids completion:(void(^)(WebResponse *response, NSError *error))completion;

//提交科普员认证信息
-(void)submitSceAuthInfoWithOperator_name:(NSString *)operator_name province:(NSString *)province city:(NSString *)city area:(NSString *)area detialAddress:(NSString *)detialAddress operator_email:(NSString *)operator_email operator_tel:(NSString *)operator_tel operator_card_imag:(NSString *)operator_card_imag operator_card_imag_back:(NSString *)operator_card_imag_back referrer_tel:(NSString *)referrer_tel code:(NSString *)code completion:(void(^)(WebResponse *response, NSError *error))completion;

//提交科普员认证信息V2
-(void)submitSceAuthInfoWithOperatorV2:(NSString *)operator_name
                              province:(NSString *)province
                                  city:(NSString *)city
                                county:(NSString *)county
                                  town:(NSString *)town
                         province_code:(NSString *)province_code
                             city_code:(NSString *)city_code
                           county_code:(NSString *)county_code
                             town_code:(NSString *)town_code
                               company:(NSString *)company
                                 it_id:(NSString *)it_id
                               sc_type:(NSString *)sc_type
                        operator_email:(NSString *)operator_email
                      operator_card_no:(NSString *)operator_card_no
                    operator_telephone:(NSString *)operator_telephone
                          referrer_tel:(NSString *)referrer_tel
                                  code:(NSString *)code
                            completion:(void(^)(WebResponse *response, NSError *error))completion;


//根据会员ID分析用户是否是科普员
-(void)analyseMemberIsSceBycompletion:(void(^)(WebResponse *response, NSError *error))completion;

#define 积分相关
//获取我的积分页面数据
-(void)getMemberScoreWithcompletion:(void(^)(WebResponse *response, NSError *error))completion;
//获取某年12个月的积分变化折线图数据
-(void)getScoreByYear:(NSString *)year completion:(void(^)(NSDictionary *response, NSError *error))completion;
//获取某月积分分类饼图数据
-(void)getScoreByMonth:(NSString *)month completion:(void(^)(WebResponse *response, NSError *error))completion;
//增加积分接口
-(void)addScoreWithInfo:(ShareModel*)shareModel completion:(void(^)(WebResponse *response, NSError *error))completion;

// 增加分享次数
-(void)addShareCountWithInfo:(ShareModel*)shareModel completion:(void(^)(WebResponse *response, NSError *error))completion;

#define 领取奖励
//获取领奖页面数据
-(void)getRewardWithMonth:(NSString *)month Completion:(void(^)(WebResponse *response, NSError *error))completion;

//点击领取奖品
-(void)exchangeRewardWithMonth:(NSString *)month PrizeId:(NSString *)prizeId completion:(void(^)(WebResponse *response, NSError *error))completion;

#pragma mark 我的-我的基站- 基站认证
//获取所有频道
-(void)getallChannelsWithCompletion:(void(^)(WebResponse *response, NSError *error))completion;

//获取所有基站分类
-(void)getAllOrganizationTypesWithCompletion:(void(^)(WebResponse *response, NSError *error))completion;

//提交基站认证信息
-(void)submitOrgAuthInfoWithor_name:(NSString *)or_name or_desc:(NSString *)or_desc or_image_url:(NSString *)or_image_url ot_id:(NSString *)ot_id at_ids:(NSString *)at_ids Completion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取自己的基站id
-(void)getMyEstationWithcompletion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取基站的已选择频道
-(void)getOrgChannelsWithor_id:(NSString *)or_id completion:(void(^)(WebResponse *response, NSError *error))completion;

//修改基站频道
-(void)updateOrgChannelsWithor_id:(NSString *)or_id at_ids:(NSString *)at_ids Completion:(void(^)(WebResponse *response, NSError *error))completion;

#pragma mark - 机构信息 - 三期
-(void)getAllOrgFromYunWithCompletion:(void(^)(WebResponse* response, NSError* error)) completion;

-(void)getAllSciencerTypesWithCompletion:(void(^)(WebResponse* response, NSError* error)) completion;

-(void)getCompanyListByTownWithTownCode:(NSString *)town_code completion:(void(^)(WebResponse *response, NSError *error))completion;

-(void)getSummaryDataForSciencerByScId:(NSString*) sc_id completion:(void(^)(WebResponse *response, NSError *error))completion;

-(void)getSummaryDetailDataForSciencerByScId:(NSString*) sc_id
                                  completion:(void(^)(WebResponse *response, NSError *error))completion;

-(void)getSciencerStsListForSciencerByScId:(NSString*) sc_id page:(NSInteger)page
                                completion:(void(^)(WebResponse *response, NSError *error))completion;

-(void)getShareStsListForSciencerByScId:(NSString*) sc_id page:(NSInteger)page
                             completion:(void(^)(WebResponse *response, NSError *error))completion;

-(void)getSpecialItemListForSciencerBySpId:(NSString*) sp_id page:(NSInteger)page
                             completion:(void(^)(WebResponse *response, NSError *error))completion;

-(void)getSpecialItemDetailListForSciencerBySpId:(NSString*) sp_id page:(NSInteger)page  classify:(NSString*)classify 
                                completion:(void(^)(WebResponse *response, NSError *error))completion;

-(void)getSummaryDetailListForSciencerByScId:(NSString*) sc_id
                                        page:(NSInteger)page
                               province_code:(NSString*)province_code
                                   city_code:(NSString*)city_code
                                 county_code:(NSString*)county_code
                                   town_code:(NSString*)town_code
                                       month:(NSString*)month
                                   sort_type:(NSString*)sort_type
                              sort_direction:(NSString*)sort_direction
                                  completion:(void(^)(WebResponse *response, NSError *error))completion;

-(void)getRegisterSummaryHead:(NSString*)town_code
                   completion:(void(^)(WebResponse *response, NSError *error))completion;

-(void)getRegisterSummaryBody:(NSString*)town_code
                         page:(NSInteger)page
                   completion:(void(^)(WebResponse *response, NSError *error))completion;

#pragma mark - 四期改版
// 获取活动首页数据
-(void)fourthGetActivityHomeListWithPage:(NSInteger)page
                              completion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取最热的活动列表
-(void)fourthGetActivityHotListWithPage:(NSInteger)page
                             completion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取最新的活动列表
-(void)fourthGetActivityLatestWithPage:(NSInteger)page
                            completion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取专题活动列表
-(void)fourthGetActivitySpecialListWithPage:(NSInteger)page
                                 completion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取专题活动详情列表
-(void)fourthGetActivitySpecialDetailListWithPage:(NSInteger)page
                                            av_id:(NSString*)av_id
                                       completion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取活动详情
-(void)fourthGetActivityDetailWithAv_id:(NSString*)av_id
                             completion:(void(^)(WebResponse *response, NSError *error))completion;

#pragma mark - 四期中间我的活动0725
// 获取活动详情
-(void)fourthV2GetActivityDetailWithAv_id:(NSString*)av_id
                             completion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取我的活动列表
-(void)fourthV2MyActivityListWithPage:(NSInteger)page ompletion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取我的活动详情
-(void)fourthV2MyActivityDetailWithAv_id:(NSString*)av_id completion:(void(^)(WebResponse *response, NSError *error))completion;

//获取地方活动列表
-(void)getRegionActivityListWithPage:(NSInteger)page region_code:(NSString*)region_code
                          completion:(void(^)(WebResponse *response, NSError *error))completion;

// 获取热门活动列表
-(void)getInteractiveActivityListWithPage:(NSInteger)page
                               completion:(void(^)(WebResponse *response, NSError *error))completion;

//获取活动区域列表
-(void)getActivityRegionList:(void(^)(WebResponse *response, NSError *error))completion;

// 获取首页数据
//-(void)getHomePageDataWithPage:(NSInteger)page completion:(void(^)(WebResponse *response, NSError *error))completion;

@end
