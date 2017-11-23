//
//  ReplyQuestion.h
//  ScienceChina
//
//  Created by Ellison Xu on 16/6/21.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReplyQuestion : NSObject

@property (nonatomic,strong) NSString* r_content;
@property (nonatomic,strong) NSString* r_floor;
@property (nonatomic,strong) NSString* r_id;
@property (nonatomic,strong) NSString* r_img_url;
@property (nonatomic,strong) NSString* r_name;
@property (nonatomic,strong) NSString* r_parentid;
@property (nonatomic,strong) NSString* r_push_time;
@property (nonatomic,strong) NSMutableArray* reList;
@property (nonatomic,strong) NSString* in_id;
@property (nonatomic,strong) NSString* in_title;
@property (nonatomic,strong) NSString* in_classify;
@property (nonatomic,strong) NSString* r_is_praise;//是否点赞 （0：未点赞 1：已点赞）
@property (nonatomic,strong) NSString* r_praise_count;// 点赞数量
@property (nonatomic,strong) NSString* replyCount; // 回复数量

@end
