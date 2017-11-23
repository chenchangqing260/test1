//
//  ActivityRemTableViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/10/12.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "ActivityRemTableViewCell.h"

@implementation ActivityRemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(ActivityRemTableViewCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"ActivityRemTableViewCell" owner:nil options:nil][0];
}

+(NSString*)ID{
    return @"ActivityRemTableViewCell";
}

@end
