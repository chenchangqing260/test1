//
//  MyEStationCollectionViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/9/4.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "MyEStationCollectionViewCell.h"

@interface MyEStationCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;
@property (weak, nonatomic) IBOutlet UILabel *uiNameLab;
@property (weak, nonatomic) IBOutlet UILabel *uiDescLab;

@end

@implementation MyEStationCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+(NSString*)ID{
    return @"MyEStationCollectionViewCell";
}


-(void)initCellData:(EStation*)station{
    [self.uiImageView sd_setImageWithURL:[NSURL URLWithString:station.si_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    [self.uiNameLab setText:station.si_name];
    [self.uiDescLab setAttributedText:[LabelUtil getNSAttributedStringWithLabel:self.uiDescLab lineSpace:1 text:station.si_desc]];
}

@end
