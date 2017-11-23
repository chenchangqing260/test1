//
//  ActivityMenuTableViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/10/12.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "ActivityMenuTableViewCell.h"

@implementation ActivityMenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(ActivityMenuTableViewCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"ActivityMenuTableViewCell" owner:nil options:nil][0];
}

+(NSString*)ID{
    return @"ActivityMenuTableViewCell";
}

- (IBAction)ClickBtn1:(id)sender {
    [self.delegate clickNewBtn];
}

- (IBAction)ClickBtn2:(id)sender {
    [self.delegate clickHotBtn];
}

- (IBAction)ClickBtn3:(id)sender {
    [self.delegate clicklocationBtn];
}

- (IBAction)ClickBtn4:(id)sender {
    [self.delegate clickSpecialBtn];
}


@end
