//
//  CommentTableCell.m
//  ScienceChina
//
//  Created by Ellison on 16/5/6.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "CommentTableCell.h"

@implementation CommentTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(CommentTableCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"CommentTableCell" owner:nil options:nil][0];
}

+(NSString*)ID{
    return @"CommentTableCell";
}

@end
