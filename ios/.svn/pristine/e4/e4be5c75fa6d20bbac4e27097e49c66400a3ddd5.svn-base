//
//  MonthIntegralForMonthCompareCell.h
//  ScienceChina
//
//  Created by xuanyj on 2016/12/21.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MonthIntegralForMonthCompareCellHeight 450

@protocol MonthIntegralForMonthCompareCellDelegate <NSObject>
-(void)didSelectedMonth:(NSString *)result;
@end

@interface MonthIntegralForMonthCompareCell : UITableViewCell
@property(nonatomic,assign) id<MonthIntegralForMonthCompareCellDelegate>delegate;
+(NSString *)ID;
-(void)setCellWithScoresArry:(NSArray *)scoresArry;
@end
