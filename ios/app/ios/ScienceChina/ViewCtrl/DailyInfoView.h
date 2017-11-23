//
//  DailyInfoView.h
//  ScienceChina
//
//  Created by Ellison on 16/5/3.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@protocol DailyInfoViewDelegate <NSObject>

- (void)clickDailyInfoWithHomeModel:(HomeModel*)model;
- (void)closeDailyInfoView;

@end

@interface DailyInfoView : UIView

@property (nonatomic, weak)id<DailyInfoViewDelegate> delegate;
@property (nonatomic, strong)NSMutableArray* dailyInfoArray;

@end
