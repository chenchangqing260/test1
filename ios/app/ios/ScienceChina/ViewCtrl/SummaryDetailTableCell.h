//
//  SummaryDetailTableCell.h
//  ScienceChina
//
//  Created by Ellison on 2017/6/9.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SummaryDetail.h"

@interface SummaryDetailTableCell : UITableViewCell

+(NSString*)ID;
+(SummaryDetailTableCell *)newCell;

-(void)setCellWithSummaryDetail:(SummaryDetail*)detail isTown:(NSString*)isTown;

@end
