//
//  VideoRecCollectionViewCell.m
//  ScienceChina
//
//  Created by Ellison on 16/5/23.
//  Copyright © 2016年 sevenplus. All rights reserved.
//

#import "VideoRecCollectionViewCell.h"

@interface VideoRecCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;
@property (weak, nonatomic) IBOutlet UILabel *uiTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *uiContentLab;
@property (weak, nonatomic) IBOutlet UILabel *uiSummaryLab;
@property (weak, nonatomic) IBOutlet UILabel *uiTimeLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conImageTopSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conTitleTopSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conTitleBottomSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conSummaryTopSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conSummaryBottomSpace;

@end

@implementation VideoRecCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    if (kSCREEN_WIDTH < kWIDTH_375) {
        // 5
        self.conImageTopSpace.constant = 20;
        self.conTitleTopSpace.constant = 17;
        self.conTitleBottomSpace.constant = 10;
        self.conSummaryTopSpace.constant = 10;
        self.conSummaryBottomSpace.constant = 10;
    }else{
        self.conImageTopSpace.constant = 30;
        self.conTitleTopSpace.constant = 22;
        self.conTitleBottomSpace.constant = 11;
        self.conSummaryTopSpace.constant = 13;
        self.conSummaryBottomSpace.constant = 13;
    }
}

+(NSString*)ID{
    return @"VideoRecCollectionViewCell";
}

-(void)initCellData:(InfoObj*)info{
    [_uiImageView sd_setImageWithURL:[NSURL URLWithString:info.in_img_url] placeholderImage:[UIImage imageNamed:@"资讯默认图"]];
    
    // 2、描述内容视图
    [_uiTitleLab setText:info.in_title];
    [_uiSummaryLab setText:[NSString stringWithFormat:@"%@%@%@", info.in_article_type, @" / ", info.in_video_duration]];
    [_uiTimeLab setText:info.in_publish_date_str];
    if (info.in_desc) {
        [_uiContentLab setAttributedText:[LabelUtil getNSAttributedStringWithLabel:_uiContentLab text:info.in_desc]];
    }else{
        _uiContentLab.text = @"";
    }
    
}
@end
