//
//  MyCommentTableCell.h
//  ScienceChina
//
//  Created by Ellison on 16/5/12.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"

@interface MyCommentTableCell : UITableViewCell

@property (nonatomic, strong)Comment* comment;

+(NSString*)ID;

@end
