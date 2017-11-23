//
//  RecordTableViewCell.h
//  ScienceChina
//
//  Created by Ellison on 16/5/13.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

#import "BaseTableViewCell.h"

#define RecordCellHeight120 100
#define RecordCellHeight70   50

@interface RecordTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *uiTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *line2;

+(NSString*)ID;
+(RecordTableViewCell *)newCell;
-(void)setCellWithModel:(HomeModel*)model lastModel:(HomeModel*)lastModel;
@end
