//
//  QuesMainItemCell.h
//  ScienceChina
//
//  Created by Ellison on 16/6/25.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "Question.h"

@interface QuesMainItemCell : BaseTableViewCell

+(NSString*)ID;
+(QuesMainItemCell *)newCell;

-(void)initCellDataWithQuestion:(Question*)question;

@end
