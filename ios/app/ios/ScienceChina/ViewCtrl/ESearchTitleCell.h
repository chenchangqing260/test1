//
//  ESearchTitleCell.h
//  ScienceChina
//
//  Created by Ellison on 16/5/21.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ESearchTtileDelegate <NSObject>

- (void)clickCleanHisBtn;

@end

@interface ESearchTitleCell : UITableViewCell

@property (nonatomic, weak)id<ESearchTtileDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *uiCleanHisBtn;
@property (weak, nonatomic) IBOutlet UILabel *uiTitleLab;

+(NSString*)ID;
+(ESearchTitleCell *)newCell;

@end
