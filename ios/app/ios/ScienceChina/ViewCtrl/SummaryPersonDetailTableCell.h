//
//  SummaryPersonDetailTableCell.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/9/6.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SummaryDetail.h"

@interface SummaryPersonDetailTableCell : UITableViewCell

+(NSString*)ID;
+(SummaryPersonDetailTableCell *)newCell;

-(void)setCellWithSummaryDetail:(SummaryDetail*)detail isTown:(NSString*)isTown isShowTop:(BOOL) isShowTop;

@end
