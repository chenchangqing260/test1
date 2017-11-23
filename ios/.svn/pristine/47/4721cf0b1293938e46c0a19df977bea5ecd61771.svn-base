//
//  TopicSubItemCycleTableCell.h
//  ScienceChina
//
//  Created by Ellison on 16/6/23.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@protocol TopSubItemCycleDelegate <NSObject>

- (void)clickCycleWithImageURL:(NSString*)imgURL;

@end

@interface TopicSubItemCycleTableCell : UITableViewCell

@property (nonatomic, strong)NSMutableArray* imageURLs;
@property (nonatomic, weak)id<TopSubItemCycleDelegate> delegate;

+(NSString*)ID;
+(TopicSubItemCycleTableCell *)newCell;

@end
