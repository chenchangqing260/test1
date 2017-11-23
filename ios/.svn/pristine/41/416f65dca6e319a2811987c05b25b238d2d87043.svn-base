//
//  DailyCollectionViewCell.m
//  ScienceChina
//
//  Created by Ellison on 16/5/3.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "DailyCollectionViewCell.h"

@interface DailyCollectionViewCell()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conRedViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conTextViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conImgViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *uiTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *uiContentLab;
@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;


@end

@implementation DailyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _conRedViewHeight.constant = 150;
    _conTextViewHeight.constant = 124;
    _conImgViewHeight.constant = 151;
    
    if (kSCREEN_WIDTH < kWIDTH_375) {
        // 5S
    }else if(kSCREEN_WIDTH > kWIDTH_375){
        // PLUS
        
    }
}

+(NSString*)ID{
    return @"DailyCollectionViewCell";
}

- (void)initDataModel:(HomeModel*)model{
    [self.uiTitleLab setText:model.in_title];
    [self.uiContentLab setText:model.in_desc];
    [self.uiImageView sd_setImageWithURL:[NSURL URLWithString:model.in_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
}

@end
