//
//  CategoryCollectionViewCell.m
//  ScienceChina
//
//  Created by Ellison on 16/5/3.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "CategoryCollectionViewCell.h"

@interface CategoryCollectionViewCell()

@end

@implementation CategoryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.uiCloseBtn.hidden = YES;
}

+(NSString*)ID{
    return @"CategoryCollectionViewCell";
}

-(void)initCellData:(InfoCategory*) category{
    [_uiCNTitleLab setText:category.at_name_ch];
    [_uiENTitleLab setText:category.at_name_en];
    if (category.tag == 0) {
        [_uiImageView sd_setImageWithURL:[NSURL URLWithString:category.at_img_url_c] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    }else if(category.tag == 1){
        [_uiImageView sd_setImageWithURL:[NSURL URLWithString:category.at_img_url_s] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    }else{
        [_uiImageView sd_setImageWithURL:[NSURL URLWithString:category.at_img_url_v] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    }
}

@end
