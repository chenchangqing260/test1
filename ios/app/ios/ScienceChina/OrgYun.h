//
//  OrgYun.h
//  ScienceChina
//
//  Created by Ellison on 2017/5/18.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrgYun : NSObject

@property (strong,nonatomic) NSString *address;//详细地址
@property (strong,nonatomic) NSString *area;//地区
@property (strong,nonatomic) NSString *areaCode;//区编码
@property (strong,nonatomic) NSString *authority;//权限0-国家级1-省级管理2-市级管理3-区县管理
@property (strong,nonatomic) NSString *business_licence;//营业执照
@property (strong,nonatomic) NSString *city;//市
@property (strong,nonatomic) NSString *cityCode;//市编码
@property (strong,nonatomic) NSString *create_at;//创建时间
@property (strong,nonatomic) NSString *create_by;//创建人
@property (strong,nonatomic) NSString *eType;//0-科协 1-学会  10-其他
@property (strong,nonatomic) NSString *eTypeVal;//0-科协 1-学会  10-其他

@property (strong,nonatomic) NSString *member_id;//用户ID
@property (strong,nonatomic) NSString *it_name;//机构名称
@property (strong,nonatomic) NSString *province;//省


@property (strong,nonatomic) NSString *project_name;//项目名称
@property (strong,nonatomic) NSString *operator_name;//运营者姓名
@property (strong,nonatomic) NSString *telephone;//联系电话

@property (strong,nonatomic) NSString *review_info;//审核信息
@property (strong,nonatomic) NSString *status;//状态 0-待审核 1-审核通过 2-拒绝审批 3-永久拒绝
@property (strong,nonatomic) NSString *trs_channel_id;//用户在trs的频道ID
@property (strong,nonatomic) NSString *trs_xml_count;//用户上传到trs上xml类型的资源数量
@property (strong,nonatomic) NSString *trs_excel_count;//用户上传到trs上excel类型的资源数量
@property (strong,nonatomic) NSString *trs_download_count;//用户下载的资源数量
@property (strong,nonatomic) NSString *provinceCode;//省编码


@property (strong,nonatomic) NSString *in_status;//机构启用状态 0-启用1-禁用
@property (strong,nonatomic) NSString *in_status_val;
@property (strong,nonatomic) NSString *xml_standard;//xml标准 01-严格 02-宽松





@property (strong,nonatomic) NSString *update_at;//修改时间

@property (strong,nonatomic) NSString *review_time;//审核时间

@end
