//
//  ChuanBoTableCell.h
//  ScienceChina
//
//  Created by Ellison on 2017/6/8.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "SummaryData.h"

@interface ChuanBoTableCell : BaseTableViewCell

+(NSString*)ID;
+(ChuanBoTableCell *)newCell;

-(void)setCellWithSummaryData:(SummaryData*)summaryData  titleContent:(NSString*)titleContent index:(NSInteger)idx showMore:(BOOL)showMore;

@end
