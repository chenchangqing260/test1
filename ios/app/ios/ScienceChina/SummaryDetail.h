//
//  SummaryDetail.h
//  ScienceChina
//
//  Created by Ellison on 2017/6/9.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SummaryDetail : NSObject

@property (nonatomic,strong) NSString *org_share_count; //基站分享数量",
@property (nonatomic,strong) NSString *region_name; //区域名",
@property (nonatomic,strong) NSString *sciencer_count; //科普员数量",
@property (nonatomic,strong) NSString *channels; //频道名称集合(\",\"隔开，辅助字段)",
@property (nonatomic,strong) NSString *article_share_count; //文章分享数量",
@property (nonatomic,strong) NSString *member_ids; //会员ID集合(\",\"隔开)",
@property (nonatomic,strong) NSString *sc_name; //科普员名称"
@property (nonatomic,strong) NSString *town_code; //城镇、街道编码",
@property (nonatomic,strong) NSString *sc_id; //科普员ID",
@end
