//
//  EStationListCell.h
//  ScienceChina
//
//  Created by Ellison on 16/5/19.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "EStation.h"

@protocol EStationListCellDelegate <NSObject>

-(void)refreshTableViewCellWithIndexPath:(NSIndexPath*)indexPath;

@end

@interface EStationListCell :BaseTableViewCell

@property (nonatomic, weak)id<EStationListCellDelegate> delegate;

+(NSString*)ID;
+(EStationListCell *)newCell;

-(void)initCellData:(EStation*)station indexPath:(NSIndexPath*)indexPath;

@end
