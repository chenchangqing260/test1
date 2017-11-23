//
//  RecommendCollectionViewCell.m
//  ScienceChina
//
//  Created by Ellison on 16/5/7.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "RecommendCollectionViewCell.h"

@interface RecommendCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;
@property (weak, nonatomic) IBOutlet UILabel *uiTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *uiCategoryLab;
@property (weak, nonatomic) IBOutlet UILabel *uiDurLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conTopViewHeight;

@end

@implementation RecommendCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (kSCREEN_WIDTH < kWIDTH_375) {
        self.conTopViewHeight.constant = 124;
    }else{
        self.conTopViewHeight.constant = 128;
    }
    
    [self layoutIfNeeded];
}

+(NSString*)ID{
    return @"RecommendCollectionViewCell";
}

-(void)initCellData:(InfoObj*)model{
    [_uiImageView sd_setImageWithURL:[NSURL URLWithString:model.in_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    _uiTitleLab.attributedText = [LabelUtil getNSAttributedStringWithLabel:_uiTitleLab text:model.in_title];
    
    if ([model.in_classify isEqualToString:@"2"]) {
        self.uiDurLab.hidden = NO;
        [_uiDurLab setText:model.in_video_duration];
        [_uiCategoryLab setText:[NSString stringWithFormat:@"%@ 次播放", model.in_hits]];
    }else{
        self.uiDurLab.hidden = YES;
        [_uiCategoryLab setText:model.in_title];
    }
}

@end
