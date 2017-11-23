//
//  BDIDataStatistics.h
//  ScienceChina
//
//  Created by xuanyj on 16/11/16.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDIDataStatistics : NSObject\


/**   
 *  在登录时调用onAddUser方法
 *  1.uid：用户id，string类型
 */
+(void)onAddUserWithUserId:(NSString *)userid;


/**
 *   浏览文章的时候调用additem和visit
     1.iid：文章id，string类型
     2.uid：用户id，string类型 （未登录为空）
 */
+(void)onVisitWithModel:(id)model;


/**
 *   浏览文章的时候调用additem和visit
     title : 文章名称   string类型
     url : 文章的链接  URL(配置类型url)
     pic： 文章的图片   string类型
     iid： 文章的id  string类型
     cat：文章类目，用“|”分隔的字符串(从根类目到子类目顺序)(配置类型：list)
     ptime : 文章发表时间， 时间戳  double类型 单位秒 11位
     author：来源　string类型
     vcnt ： 浏览人数 int类型
     ccnt ： 评论人数 int类型
 */
+(void)additemWithModel:(id)model;


+(void)additemWithModelNew:(id)model;


/**
     推荐服务请求 —获取返回数据的（这个“推荐请求标识”应该传什么，我看你们的demo里是写死了，这个等做推荐的时候我会给您的，咱们可以先定一下APP的推荐位在哪里）
     [BfdAgent recommend:delegate: recommendId: options:]
     block方式:[BDIAgent recommend: options: resp: ]
 */
+(void)getRecommendDataWithSuccess:(void (^)(NSMutableArray *feedback,NSString *requestId))sccessBlock error:(void (^)(NSString *errorMessage))errorBlack;

/*推荐位实际展示后调用DFeedBack接口*/
+(void)DFeedBackWithIdArry:(NSArray*)idds requestId:(NSString *)requestId;

/**
 点击推荐商品的时候调用onFeedBack接口  == demo 里的onFeedBack
 
 推荐服务请求结果反馈 —如果有用户点击了推荐出来的文章时调用的（等咱们展示制作推荐的时候在调用，点击推荐文章的时候调用的feedback）
 [BfdAgent feedback:delegate: recommendId: options:]
 block方式:[BDIAgent feedback: itemId: options: resp:]
 
 */
+(void)tapRecommendArticleWithModel:(id)model requestId:(NSString *)requestId;






@end
