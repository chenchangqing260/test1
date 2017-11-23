//
//  SpecialPicListTableViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/14.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "SpecialPicListTableViewCell.h"

@interface SpecialPicListTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *UITitle;
@property (weak, nonatomic) IBOutlet UIImageView *UIImage1;
@property (weak, nonatomic) IBOutlet UIImageView *UIImage2;
@property (weak, nonatomic) IBOutlet UIImageView *UIImage3;
@property (weak, nonatomic) IBOutlet UILabel *UIDate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UIConstraint;
@end

@implementation SpecialPicListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"SpecialPicListTableViewCell";
}

+(SpecialPicListTableViewCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"SpecialPicListTableViewCell" owner:nil options:nil][0];
}

-(void)setCellWithScienceActivity:(HomeModel*)sa showSpace:(BOOL)showSpace{
    
    [self.UITitle setText:sa.ni_title];
    [self.UIDate setText:sa.ni_publish_date_str];
    [self.UIImage1 sd_setImageWithURL:[NSURL URLWithString:sa.ni_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    [self.UIImage2 sd_setImageWithURL:[NSURL URLWithString:sa.ni_img_url2] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    [self.UIImage3 sd_setImageWithURL:[NSURL URLWithString:sa.ni_img_url3] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];

    
    [self layoutIfNeeded];
}

@end
