//
//  ActivityMenuTableViewCell.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/10/12.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol ActivityMenuTableViewCellCycleDelegate <NSObject>

- (void)clickHotBtn;
- (void)clickNewBtn;
- (void)clickSpecialBtn;
- (void)clicklocationBtn;

@end

@interface ActivityMenuTableViewCell : BaseTableViewCell
+(NSString*)ID;
+(ActivityMenuTableViewCell *)newCell;
@property (nonatomic, weak)id<ActivityMenuTableViewCellCycleDelegate> delegate;

@end
