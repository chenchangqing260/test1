//
//  CommentTableCell.h
//  ScienceChina
//
//  Created by Ellison on 16/5/6.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface CommentTableCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIView *uiContentView;

+(NSString*)ID;
+(CommentTableCell *)newCell;

@end
