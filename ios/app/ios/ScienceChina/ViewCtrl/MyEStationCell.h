//
//  MyEStationCell.h
//  ScienceChina
//
//  Created by Ellison on 16/5/19.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "EStation.h"

@interface MyEStationCell : BaseTableViewCell

+(NSString*)ID;
+(MyEStationCell *)newCell;

-(void)initCellData:(EStation*)station;

@end
