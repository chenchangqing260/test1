//
//  OrganizationTypeListModel.h
//  ScienceChina
//
//  Created by touf on 2016/12/27.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrganizationTypeListModel : NSObject
@property (strong, nonatomic) NSString *ot_id;
@property (strong, nonatomic) NSString *ot_name;
@property (strong, nonatomic) NSString *ot_status;
@property (strong, nonatomic) NSString *ot_create_time;
@property (strong, nonatomic) NSString *ot_is_recommend;
@property (strong, nonatomic) NSString *ot_img_url;
@end
