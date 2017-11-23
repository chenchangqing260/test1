//
//  EStationCell.h
//  ScienceChina
//
//  Created by Ellison on 16/5/19.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@protocol EStationCellDelegate <NSObject>

-(void)refreshStationTableViewCellWithIndexPath:(NSIndexPath*)indexPath;

@end

@interface EStationCell : BaseTableViewCell

@property (nonatomic, weak)id<EStationCellDelegate> delegate;

+(NSString*)ID;
+(EStationCell *)newCell;

-(void)initCellData:(EStationCell*)station indexPath:(NSIndexPath*)indexPath;

@end
