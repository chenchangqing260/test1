//
//  Sciencer.h
//  ScienceChina
//
//  Created by Ellison on 2017/6/7.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sciencer : NSObject

@property (strong,nonatomic) NSString *operator_name; //运营者姓名",
@property (strong,nonatomic) NSString *town_code; //城镇、街道编码",
@property (strong,nonatomic) NSString *sc_type_val; //权限(辅助字段)",
@property (strong,nonatomic) NSString *province_code; //省编码",
@property (strong,nonatomic) NSString *create_at; //创建时间",
@property (strong,nonatomic) NSString *operator_email; //运营者邮箱",
@property (strong,nonatomic) NSString *deleted; //删除状态：0-未删除、1-已删除",
@property (strong,nonatomic) NSString *operator_telephone; //运营者手机号",
@property (strong,nonatomic) NSString *sc_type; //科普员类型：0-中国科协级、1-省级、2-市级、3-区县级、4-乡镇级、5-个人级",
@property (strong,nonatomic) NSString *member_id; //会员ID",
@property (strong,nonatomic) NSString *city; //市",
@property (strong,nonatomic) NSString *sc_his_id; //科普员申请历史记录ID",
@property (strong,nonatomic) NSString *referrer_tel; //推荐人手机号",
@property (strong,nonatomic) NSString *sc_id; //科普员ID",
@property (strong,nonatomic) NSString *source; //来源：0-科普APP、1-科普云门户",
@property (strong,nonatomic) NSString *member_account; //会员账号(辅助字段)",
@property (strong,nonatomic) NSString *approve_time; //审批时间",
@property (strong,nonatomic) NSString *county; //县区",
@property (strong,nonatomic) NSString *address; //详细地址",
@property (strong,nonatomic) NSString *company; //所属单位",
@property (strong,nonatomic) NSString *province; //省",
@property (strong,nonatomic) NSString *approve_info; //审批信息",
@property (strong,nonatomic) NSString *city_code; //市编码",
@property (strong,nonatomic) NSString *town; //城镇、街道",
@property (strong,nonatomic) NSString *member_name; //用户昵称(辅助字段)",
@property (strong,nonatomic) NSString *county_code; //区县编码"

@end
