//
//  IndexBannerTableCell.h
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/7.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "HomeModel.h"


@protocol IndexBannerTableCellCycleDelegate <NSObject>
- (void)clickCycleWithImageURL:(HomeModel*)sa;

@end

@interface IndexBannerTableCell : BaseTableViewCell
@property (nonatomic, strong)NSMutableArray* cycleSAList;
@property (nonatomic, weak)id<IndexBannerTableCellCycleDelegate> delegate;

+(NSString*)ID;
+(IndexBannerTableCell *)newCell;
-(void)setCellData;
@end
