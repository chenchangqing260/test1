//
//  MyCollectTableCell.h
//  ScienceChina
//
//  Created by Ellison on 16/5/12.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@protocol MyCollectionDelegate <NSObject>

- (void)refreshData;

@end

@interface MyCollectTableCell : UITableViewCell

@property (nonatomic, weak)id<MyCollectionDelegate> delegate;
@property (nonatomic, strong)HomeModel* info;

+(NSString*)ID;

@end
