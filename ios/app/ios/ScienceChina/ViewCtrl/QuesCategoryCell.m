//
//  QuesCategoryCell.m
//  ScienceChina
//
//  Created by Ellison on 16/6/27.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "QuesCategoryCell.h"

@implementation QuesCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"QuesCategoryCell";
}

+(QuesCategoryCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"QuesCategoryCell" owner:nil options:nil][0];
}
@end
