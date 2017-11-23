//
//  SpecialPicAndWenBaseTableViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/14.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "SpecialPicAndWenBaseTableViewCell.h"

@interface SpecialPicAndWenBaseTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *UIImgView;
@property (weak, nonatomic) IBOutlet UILabel *UITitle;
@property (weak, nonatomic) IBOutlet UILabel *UIDate;
@property (weak, nonatomic) IBOutlet UILabel *UIPinNum;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tuwenConstraint;

@end

@implementation SpecialPicAndWenBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"SpecialPicAndWenBaseTableViewCell";
}

+(SpecialPicAndWenBaseTableViewCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"SpecialPicAndWenBaseTableViewCell" owner:nil options:nil][0];
}

-(void)setCellWithScienceActivity:(HomeModel*)sa showSpace:(BOOL)showSpace{
    
    
    [self.UITitle setText:sa.ni_title];
    [self.UIDate setText:sa.ni_publish_date_str];
    [self.UIPinNum setText:sa.ni_reviewCount];
    [self.UIImgView sd_setImageWithURL:[NSURL URLWithString:sa.ni_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    
    [self layoutIfNeeded];
}

@end
