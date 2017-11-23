//
//  SpecialVedioTableViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/14.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "SpecialVedioTableViewCell.h"

@interface SpecialVedioTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *UITitle;
@property (weak, nonatomic) IBOutlet UIImageView *UIImage;
@property (weak, nonatomic) IBOutlet UILabel *UIDate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@end


@implementation SpecialVedioTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"SpecialVedioTableViewCell";
}

+(SpecialVedioTableViewCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"SpecialVedioTableViewCell" owner:nil options:nil][0];
}


-(void)setCellWithScienceActivity:(HomeModel*)sa showSpace:(BOOL)showSpace{
    
    
    [self.UITitle setText:sa.ni_title];
    [self.UIImage sd_setImageWithURL:[NSURL URLWithString:sa.ni_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    [self.UIDate setText:sa.ni_publish_date_str];
    self.userInteractionEnabled = 1;
    
    [self layoutIfNeeded];
}
@end
