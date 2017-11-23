//
//  CompanyTableViewCell.h
//  ScienceChina
//
//  Created by Ellison on 2017/6/6.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SciencerCompany.h"

@interface CompanyTableViewCell : UITableViewCell

+(NSString*)ID;
+(CompanyTableViewCell *)newCell;

-(void)setCellWithTypeModel:(SciencerCompany*)company;


@end
