//
//  SpecialCollectionViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/11.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "SpecialCollectionViewCell.h"
#import "HomeModel.h"

@interface SpecialCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *UITitle;
@property (weak, nonatomic) IBOutlet UILabel *UIDate;
@property (weak, nonatomic) IBOutlet UIImageView *UIImage;

@end

@implementation SpecialCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"SpecialCollectionViewCell";
}

-(void)setCellWithScienceSpecial:(HomeModel*)sa showSpace:(BOOL)showSpace{
    self.UITitle.text = sa.ni_title;
    self.UIDate.text = sa.ni_publish_date_str;
    [self.UIImage sd_setImageWithURL:[NSURL URLWithString:sa.ni_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
}

@end
