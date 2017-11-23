//
//  MyAnswerCell.h
//  ScienceChina
//
//  Created by Ellison on 16/7/4.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReplyQuestion.h"

@interface MyAnswerCell : UITableViewCell

+(NSString*)ID;
+(MyAnswerCell *)newCell;

- (void)initCellDataWithReply:(ReplyQuestion*)reply;

@end
