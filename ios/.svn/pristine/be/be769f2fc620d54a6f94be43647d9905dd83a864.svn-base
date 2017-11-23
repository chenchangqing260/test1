//
//  SpecialIIndexInfoCollectionViewCell.m
//  ScienceChina
//
//  Created by SevenPlus on 2017/8/14.
//  Copyright © 2017年 sevenplus. All rights reserved.
//

#import "SpecialIIndexInfoCollectionViewCell.h"
#import "HomeModel.h"

@interface SpecialIIndexInfoCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *UITitle;
@property (weak, nonatomic) IBOutlet UILabel *UIDate;
@property (weak, nonatomic) IBOutlet UIImageView *UIImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@end

@implementation SpecialIIndexInfoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(NSString*)ID{
    return @"SpecialIIndexInfoCollectionViewCell";
}

-(void)setCellWithScienceSpecial:(HomeModel*)sa showSpace:(BOOL)showSpace{
    self.UITitle.text = sa.ni_title;
    self.UIDate.text = sa.ni_publish_date_str;
    [self.UIImage sd_setImageWithURL:[NSURL URLWithString:sa.ni_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    
    if(showSpace){
        self.topConstraint.constant = 10;
    }else{
        self.topConstraint.constant = 0;
    }
    [self layoutIfNeeded];
}

@end
