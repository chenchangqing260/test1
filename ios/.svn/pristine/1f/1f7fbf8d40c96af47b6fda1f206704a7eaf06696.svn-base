//
//  TopicItemCell.m
//  ScienceChina
//
//  Created by Ellison on 16/6/20.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "TopicItemCell.h"
#import "HomeModel.h"

@interface TopicItemCell()

@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;
@property (weak, nonatomic) IBOutlet UILabel *uiTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *uiDescLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conTitleTopSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conTitleBottomSpace;
@end

@implementation TopicItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 5S Title的上下间距变为13，6以上为18;
    if (kSCREEN_WIDTH < kWIDTH_375) {
        _conTitleTopSpace.constant = 13;
        _conTitleBottomSpace.constant = 8;
    }else{
        _conTitleTopSpace.constant = _conTitleBottomSpace.constant = 18;
    }
}

+(NSString*)ID{
    return @"TopicItemCell";
}

- (void)initCellDataWithHomeModel:(HomeModel*)model{
    _uiTitleLab.attributedText = [LabelUtil getNSAttributedStringWithLabel:_uiTitleLab text:model.in_title];
    _uiDescLab.attributedText = [LabelUtil getNSAttributedStringWithLabel:_uiDescLab text:model.in_desc];
    [_uiImageView sd_setImageWithURL:[NSURL URLWithString:model.in_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
}

@end
