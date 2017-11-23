//
//  EStationListHeaderCell.h
//  ScienceChina
//
//  Created by Ellison on 16/5/19.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "EStationRank.h"

typedef enum {Remen = 0, Youqu = 1, Xinxian = 2, Fenlei = 3} EStationListType;

@protocol EStationListHeaderDelegate <NSObject>

- (void)clickStationRank:(EStationRank*)rank;
- (void)selectEStationListWithType:(EStationListType)type;

@end

@interface EStationListHeaderCell : BaseTableViewCell

@property (nonatomic, strong)NSMutableArray* imageURLs;
@property (nonatomic, weak)id<EStationListHeaderDelegate> delegate;

+(NSString*)ID;
+(EStationListHeaderCell *)newCell;

@end
