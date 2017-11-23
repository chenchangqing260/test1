//
//  EStationTextCell.h
//  ScienceChina
//
//  Created by Ellison on 16/5/20.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EStationTextCell : UITableViewCell

+(NSString*)ID;
+(EStationTextCell *)newCell;

-(void)initCellData:(InfoObj*)info;

@end
