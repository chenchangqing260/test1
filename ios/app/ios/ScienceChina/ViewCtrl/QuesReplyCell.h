//
//  QuesReplyCell.h
//  ScienceChina
//
//  Created by Ellison on 16/7/1.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReplyQuestion.h"

@interface QuesReplyCell : UITableViewCell

+(NSString*)ID;
+(QuesReplyCell *)newCell;

- (void)initCellDataWithReply:(ReplyQuestion*)reply;

@end
