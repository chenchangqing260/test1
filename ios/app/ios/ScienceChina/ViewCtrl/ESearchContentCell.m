//
//  ESearchContentCell.m
//  ScienceChina
//
//  Created by Ellison on 16/5/21.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "ESearchContentCell.h"

@implementation ESearchContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"ESearchContentCell";
}

+(ESearchContentCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"ESearchContentCell" owner:nil options:nil][0];
}


@end
