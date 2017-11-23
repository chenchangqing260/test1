//
//  QuesMainItemCell.m
//  ScienceChina
//
//  Created by Ellison on 16/6/25.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "QuesMainItemCell.h"
#import "SDCycleScrollView.h"

@interface QuesMainItemCell()

@property (weak, nonatomic) IBOutlet UIImageView *uiCategoryImgView;
@property (weak, nonatomic) IBOutlet UILabel *uiCategoryLab;
@property (weak, nonatomic) IBOutlet UILabel *uiQuesTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *uiQuesDescLab;
@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;
@property (weak, nonatomic) IBOutlet UILabel *uiLookCountLab;
@property (weak, nonatomic) IBOutlet UILabel *uiReplyCountLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conImgViewTopSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conImgViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *UIPush_time;

@end

@implementation QuesMainItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CGFloat showWidth = kSCREEN_WIDTH;
    CGFloat leftEdge = 0;
    if (isIpad) {
        showWidth = MAIN_SCREEN_WIDTH_ONIpad;
        leftEdge = (MAIN_SCREEN_WIDTH-MAIN_SCREEN_WIDTH_ONIpad)/2.0;
    }
    self.conImgViewTopSpace.constant = 13;
    self.conImgViewHeight.constant = showWidth * 208 / kWIDTH_375;
}

+(NSString*)ID{
    return @"QuesMainItemCell";
}

+(QuesMainItemCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"QuesMainItemCell" owner:nil options:nil][0];
}

-(void)initCellDataWithQuestion:(Question*)question{
    [_uiCategoryImgView sd_setImageWithURL:[NSURL URLWithString:question.te_images_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    [_uiCategoryLab setText:question.te_title];
    [_uiQuesTitleLab setText:question.qu_title];
    [_uiQuesDescLab setAttributedText:[LabelUtil getNSAttributedStringWithLabel:_uiQuesDescLab text:question.qu_content]];
    [self.UIPush_time setText:question.qu_push_time];
    if (question.qu_img && ![question.qu_img isEmptyOrWhitespace]) {
        CGFloat showWidth = kSCREEN_WIDTH;
        if (isIpad) {
            showWidth = MAIN_SCREEN_WIDTH_ONIpad;
        }
        self.conImgViewTopSpace.constant = 13;
        self.conImgViewHeight.constant = showWidth * 208 / kWIDTH_375;
        [_uiImageView sd_setImageWithURL:[NSURL URLWithString:question.qu_img] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    }else{
        self.conImgViewTopSpace.constant = 0;
        self.conImgViewHeight.constant = 0;
    }
    [_uiLookCountLab setText:question.hits];
    [_uiReplyCountLab setText:question.replyCount];
}

@end
