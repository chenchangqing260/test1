//
//  MyMoreStation.h
//  ScienceChina
//
//  Created by Ellison on 16/5/19.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@protocol MyMoreStationDelegate <NSObject>

-(void)clickMoreStation;

@end

@interface MyMoreStation : BaseTableViewCell

@property (nonatomic, strong)id<MyMoreStationDelegate> delegate;

+(NSString*)ID;
+(MyMoreStation *)newCell;

@end
