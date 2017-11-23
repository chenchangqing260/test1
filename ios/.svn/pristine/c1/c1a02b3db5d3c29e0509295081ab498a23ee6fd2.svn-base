//
//  TopicSubItemTableCell.m
//  ScienceChina
//
//  Created by Ellison on 16/6/23.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "TopicSubItemTableCell.h"

@interface TopicSubItemTableCell()

@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;
@property (weak, nonatomic) IBOutlet UILabel *uiTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *uiTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *uiCommentCountLab;
@property (weak, nonatomic) IBOutlet UILabel *uiCollectCountLab;
@property (weak, nonatomic) IBOutlet UILabel *uiClasslyLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conTitleLabBottomSpace;

@end

@implementation TopicSubItemTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 5S Title的上下间距变为13，6以上为18;
    if (kSCREEN_WIDTH < kWIDTH_375) {
        _conTitleLabBottomSpace.constant = 11;
    }else{
        _conTitleLabBottomSpace.constant = 18;
    }
}

+(NSString*)ID{
    return @"TopicSubItemTableCell";
}

+(TopicSubItemTableCell *)newCell{
    return [[NSBundle mainBundle]loadNibNamed:@"TopicSubItemTableCell" owner:nil options:nil][0];
}

- (void)initCellDataWithHomeModel:(HomeModel*)model{
    [_uiImageView sd_setImageWithURL:[NSURL URLWithString:model.in_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    _uiTitleLab.attributedText = [LabelUtil getNSAttributedStringWithLabel:_uiTitleLab text:model.in_title];
    [self.uiTimeLab setText:model.in_publish_date_str];
    [_uiCollectCountLab setText:model.in_collectCount];
    [_uiCommentCountLab setText:model.in_reviewCount];
    
    // 根据类型显示不同的数据
    if ([model.in_classify isEqualToString:@"0"]) {
        [self.uiClasslyLab setText:@"# 图文"];
    }else if([model.in_classify isEqualToString:@"1"]){
        [self.uiClasslyLab setText:[NSString stringWithFormat:@"%@%@", @"# 图集 / ", model.in_pic_amount]];
    }else if([model.in_classify isEqualToString:@"2"]){
        [self.uiClasslyLab setText:[NSString stringWithFormat:@"%@%@", @"# 视频 / ", model.in_video_duration]];
    }else if([model.in_classify isEqualToString:@"3"]){
        [self.uiClasslyLab setText:@"# 专题"];
    }
}

@end
