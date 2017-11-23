//
//  MyEStationCell.m
//  ScienceChina
//
//  Created by Ellison on 16/5/19.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "MyEStationCell.h"

@interface MyEStationCell()

@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;
@property (weak, nonatomic) IBOutlet UILabel *uiNameLab;
@property (weak, nonatomic) IBOutlet UILabel *uiDescLab;

@end

@implementation MyEStationCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+(NSString*)ID{
    return @"MyEStationCell";
}

+(MyEStationCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"MyEStationCell" owner:nil options:nil][0];
}

-(void)initCellData:(EStation*)station{
    [self.uiImageView sd_setImageWithURL:[NSURL URLWithString:station.si_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    [self.uiNameLab setText:station.si_name];
    [self.uiDescLab setAttributedText:[LabelUtil getNSAttributedStringWithLabel:self.uiDescLab lineSpace:1 text:station.si_desc]];
}

@end
