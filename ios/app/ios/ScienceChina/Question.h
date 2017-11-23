//
//  Question.h
//  ScienceChina
//
//  Created by Ellison on 16/6/25.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BeanSupport.h"

@interface Question : NSObject<BeanSupport>

@property (strong,nonatomic) NSString * te_title;//类型标题
@property (strong,nonatomic) NSString * hits;//点击人次
@property (strong,nonatomic) NSString * replyCount;//回复数量
@property (strong,nonatomic) NSString * qu_content;//提问内容
@property (strong,nonatomic) NSString * qu_id;//提问标识
@property (strong,nonatomic) NSString * te_images_url;//类型图片地址
@property (strong,nonatomic) NSString * qu_img;//提问图片地址
@property (strong,nonatomic) NSString * qu_title;//提问标题
@property (strong,nonatomic) NSMutableArray * rqList;// 回复列表
@property (strong,nonatomic) NSString * qu_push_time;// 发布时间
@property (strong,nonatomic) NSString * member_img_url;// 发布人头像
@property (strong,nonatomic) NSString * member_name;// // 提问人昵称
@property (strong,nonatomic) NSString * qu_reply_content; // 官方回复
@property (strong,nonatomic) NSString *qu_share_contentURL; //提问分享内容地址",
@property (strong,nonatomic) NSString *qu_share_imageURL; //提问分享图片地址",
@property (strong,nonatomic) NSString *qu_share_desc; //提问分享描述",
@property (strong,nonatomic) NSString *qu_share_title; //提问分享标题"

@end
