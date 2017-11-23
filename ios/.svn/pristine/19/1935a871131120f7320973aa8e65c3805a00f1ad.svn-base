//
//  MonthIntegralForAnnualCompareCell.h
//  ScienceChina
//
//  Created by xuanyj on 2016/12/21.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MonthIntegralForAnnualCompareCellHeight 282.0

@protocol MonthIntegralForAnnualCompareCellDelegate <NSObject>
-(void)didSelectedYear:(NSString *)result;
@end

@interface MonthIntegralForAnnualCompareCell : UITableViewCell
@property(nonatomic,assign) id<MonthIntegralForAnnualCompareCellDelegate>delegate;
+(NSString *)ID;
-(void)setCellWithScoresArry:(NSArray *)scoresArry;
@end
