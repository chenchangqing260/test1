//
//  TopicSubItemTextCell.m
//  ScienceChina
//
//  Created by Ellison on 16/6/24.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "TopicSubItemTextCell.h"

@interface TopicSubItemTextCell()

@property (weak, nonatomic) IBOutlet UILabel *uiTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *uiDescLab;
@property (weak, nonatomic) IBOutlet UILabel *uiTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *uiCollectCountLab;
@property (weak, nonatomic) IBOutlet UILabel *uiCommentCountLab;

@end

@implementation TopicSubItemTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+(NSString*)ID{
    return @"TopicSubItemTextCell";
}

+(TopicSubItemTextCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"TopicSubItemTextCell" owner:nil options:nil][0];
}

- (void)initCellDataWithHomeModel:(HomeModel*)model{
    [_uiTitleLab setText:model.in_title];
    _uiDescLab.attributedText = [LabelUtil getNSAttributedStringWithLabel:_uiDescLab text:model.in_desc];
    [_uiCollectCountLab setText:model.in_collectCount];
    [_uiCommentCountLab setText:model.in_reviewCount];
    [_uiTimeLab setText:model.in_hits];
}

@end
