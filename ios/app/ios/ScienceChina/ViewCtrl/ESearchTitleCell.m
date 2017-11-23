//
//  ESearchTitleCell.m
//  ScienceChina
//
//  Created by Ellison on 16/5/21.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "ESearchTitleCell.h"

@implementation ESearchTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+(NSString*)ID{
    return @"ESearchTitleCell";
}

+(ESearchTitleCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"ESearchTitleCell" owner:nil options:nil][0];
}

- (IBAction)clickCleanBtn:(id)sender {
    [self.delegate clickCleanHisBtn];
}
@end
